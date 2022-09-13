import 'package:crestaurant2/app/widgets/card_resto_widget.dart';
import 'package:crestaurant2/services/restaurant_service.dart';
import 'package:crestaurant2/values/Icons.dart';
import 'package:crestaurant2/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../models/restaurant_model.dart';
import '../detail/detail_screen.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      appBar: appBarWidget(context),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Search(),
      ),
    );
  }

  PreferredSizeWidget appBarWidget(BuildContext context) {
    return AppBar(
      title: const Text(
        "Find Your Favorite Food",
        style: TextStyle(color: dark),
      ),
      centerTitle: true,
      backgroundColor: Colors.white,
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: SvgPicture.asset(
          back,
          width: 30,
          color: dark,
        ),
      ),
    );
  }
}

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  late bool _isShowClear = false;
  late bool _isLoading = false;
  late List<Restaurant>? listRestaurant = [];

  final TextEditingController _search = TextEditingController(text: "");

  final List<String> _popularSearch = [
    "Napolitana",
    "Kari kacang dan telur",
    "Salad yuzu",
    "Kafein",
    "Sosis squash dan mint",
    "Coklat panas",
    "Bring Your Phone Cafe",
  ];

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void searchRestaurant() async {
    setState(() {
      _isLoading = true;
      _isShowClear = true;
      listRestaurant = [];
    });
    // await RestaurantService()
    //     .findRestaurant(context: context, value: _search.text)
    //     .then((value) {
    //   listRestaurant = value;
    //   setState(() {
    //     _isLoading = false;
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          controller: _search,
          cursorColor: primary,
          keyboardType: TextInputType.text,
          maxLines: 1,
          onChanged: (value) {
            setState(() {
              listRestaurant = [];
              _isShowClear = value.isNotEmpty;
              searchRestaurant();
            });
          },
          decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: grey2,
              prefixIcon: SizedBox(
                width: 10,
                height: 10,
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: SvgPicture.asset(search, width: 10),
                ),
              ),
              suffixIcon: _isShowClear
                  ? InkWell(
                      onTap: () {
                        listRestaurant = [];
                        _search.clear();
                        setState(() {
                          _isShowClear = false;
                        });
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(12),
                        child: Icon(
                          Icons.cancel,
                          color: lipstickRed,
                        ),
                      ),
                    )
                  : null,
              hintText: "Bebek Penyet"),
        ),
        const SizedBox(
          height: 10,
        ),
        Expanded(
          child: _isLoading
              ? const Center(
                  child: CircularProgressIndicator(
                    color: primary,
                  ),
                )
              : listRestaurant!.isNotEmpty
                  ? ListView.separated(
                      itemBuilder: (BuildContext context, int index) {
                        Restaurant data = listRestaurant![index];
                        return InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => DetailScreen(data: data),
                            //   ),
                            // );
                          },
                          child: CardRestoWidget(
                            image: data.pictureId,
                            name: data.name,
                            city: data.city,
                            rating: data.rating,
                          ),
                        );
                      },
                      separatorBuilder: (BuildContext context, _) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: listRestaurant!.length)
                  : SingleChildScrollView(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Popular Search",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    color: dark, fontWeight: FontWeight.bold),
                          ),
                          Wrap(
                            spacing: 2,
                            children: _popularSearch
                                .map(
                                  (e) => ChoiceChip(
                                    label: Text(
                                      e,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(fontWeight: FontWeight.w400),
                                    ),
                                    selected: false,
                                    onSelected: (_) {
                                      setState(() {
                                        _search.text = e;
                                        listRestaurant = [];
                                        searchRestaurant();
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          )
                        ],
                      ),
                  ),
        )
      ],
    );
  }
}
