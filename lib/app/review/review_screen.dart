import 'package:crestaurant2/app/widgets/button_widget.dart';
import 'package:crestaurant2/models/customer_review_model.dart';
import 'package:crestaurant2/provider/auth_provider.dart';
import 'package:crestaurant2/provider/detail_restaurant_provider.dart';
import 'package:crestaurant2/services/review_service.dart';
import 'package:crestaurant2/utils/connection_check_manual_util.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final DetailRestaurantProvider detailRestaurantProvider =
        Provider.of<DetailRestaurantProvider>(context, listen: false);
    final AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              detailRestaurantProvider.detailRestaurant!.name,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: dark, fontSize: 14, fontWeight: FontWeight.w400),
            ),
            Text(
              AppLocalizations.of(context)!.giveYourReview,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: dark, fontSize: 12, fontWeight: FontWeight.w400),
            )
          ],
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.clear),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    const CircleAvatar(
                      backgroundColor: grey1,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(authProvider.currentUser.userName)
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                RatingBar(
                  initialRating: 0,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 40,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 10),
                  ratingWidget: RatingWidget(
                    full: const Icon(
                      Icons.star,
                      color: orange,
                    ),
                    half: const Icon(
                      Icons.star_half,
                      color: orange,
                    ),
                    empty: const Icon(
                      Icons.star_border,
                      color: grey1,
                    ),
                  ),
                  onRatingUpdate: (double value) {},
                ),
                const SizedBox(
                  height: 20,
                ),
                FormReview(
                  id: detailRestaurantProvider.detailRestaurant!.id,
                  userName: authProvider.currentUser.userName,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FormReview extends StatefulWidget {
  final String id, userName;

  const FormReview({Key? key, required this.id, required this.userName})
      : super(key: key);

  @override
  State<FormReview> createState() => _FormReviewState();
}

class _FormReviewState extends State<FormReview> {
  late bool _isLoading = false;
  TextEditingController reviewController = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final DetailRestaurantProvider detailRestaurantProvider =
        Provider.of<DetailRestaurantProvider>(context, listen: false);

    void handlePostReview() async {
      if (await ConnectionCheckManual().isOffline()) {
        Fluttertoast.showToast(msg: "Connection Error, check your connection");
        return;
      }

      setState(() {
        _isLoading = true;
      });
      List<CustomerReview>? response = await ReviewService().postReview(
          id: widget.id, name: widget.userName, review: reviewController.text);

      if (response != null) {
        detailRestaurantProvider.setNewReview(newReview: response);
        Fluttertoast.showToast(msg: "Success");
      } else {
        Fluttertoast.showToast(msg: "Failed");
      }

      setState(() {
        _isLoading = false;
      });
    }

    return Column(
      children: [
        TextFormField(
          cursorColor: primary,
          textAlignVertical: TextAlignVertical.center,
          maxLength: 150,
          maxLines: 4,
          controller: reviewController,
          decoration: InputDecoration(
            filled: true,
            fillColor: grey2,
            hintText: AppLocalizations.of(context)!.reviewHint,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none),
            enabledBorder:
                const OutlineInputBorder(borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: primary, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        ButtonWidget(
            onPress: () {
              handlePostReview();
            },
            label: "Posting",
            isLoading: _isLoading),
      ],
    );
  }
}
