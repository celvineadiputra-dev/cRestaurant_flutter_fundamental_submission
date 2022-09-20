import 'package:crestaurant2/app/detail/detail_screen.dart';
import 'package:crestaurant2/app/widgets/card_resto_widget.dart';
import 'package:crestaurant2/app/widgets/error_widget.dart';
import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/provider/database_provider.dart';
import 'package:crestaurant2/provider/detail_restaurant_provider.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widgets/button_widget.dart';

class WishListScreen extends StatelessWidget {
  const WishListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Wish list",
          style: TextStyle(color: dark),
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Consumer<DatabaseProvider>(
          builder: (BuildContext context, DatabaseProvider data, _) {
            switch (data.state) {
              case ResultState.loading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case ResultState.noData:
                return Column(
                  children: [
                    const Spacer(),
                    empty(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: ButtonWidget(
                          onPress: () {
                            Navigator.pushReplacementNamed(context, '/search');
                          },
                          label: AppLocalizations.of(context)!.searchNearby),
                    ),
                    const Spacer(),
                  ],
                );
              case ResultState.hasData:
                return ListView.separated(
                  itemBuilder: (BuildContext context, int index) {
                    final Restaurant restaurant = data.wishList[index];
                    return Slidable(
                      key: const ValueKey(0),
                      startActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            onPressed: (val) {
                              data.destroy(restaurant.id);
                            },
                            backgroundColor: lipstickRed,
                            icon: Icons.delete,
                            label: "Remove",
                          )
                        ],
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  DetailScreen(data: restaurant),
                            ),
                          );
                        },
                        child: CardRestoWidget(
                            image: restaurant.pictureId,
                            name: restaurant.name,
                            city: restaurant.city,
                            rating: restaurant.rating),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, _) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: data.wishList.length,
                );
              case ResultState.error:
                return errorCode();
              default:
                return const Center(
                  child: CircularProgressIndicator(),
                );
            }
          },
        ),
      ),
    );
  }
}
