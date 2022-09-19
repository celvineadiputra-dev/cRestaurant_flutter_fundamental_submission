import 'package:crestaurant2/app/detail/detail_screen.dart';
import 'package:crestaurant2/app/widgets/card_resto_widget.dart';
import 'package:crestaurant2/models/restaurant_model.dart';
import 'package:crestaurant2/provider/database_provider.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

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
      body: SafeArea(child: Consumer<DatabaseProvider>(
        builder: (BuildContext context, DatabaseProvider data, _) {
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
                        builder: (context) => DetailScreen(data: restaurant),
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
        },
      )),
    );
  }
}
