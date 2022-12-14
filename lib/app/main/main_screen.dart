import 'package:crestaurant2/app/commingsoon/coming_soon_screen.dart';
import 'package:crestaurant2/app/home/home_screen.dart';
import 'package:crestaurant2/app/profile/profile_screen.dart';
import 'package:crestaurant2/app/wishlist/wishlist_screen.dart';
import 'package:crestaurant2/provider/navigation_provider.dart';
import 'package:crestaurant2/values/Colors.dart';
import 'package:crestaurant2/values/icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late NavigationProvider navigationProvider;

  List<Widget> widgetPages = [
    const HomeScreen(),
    const WishListScreen(),
    const ComingSoonScreen(),
    const ProfileScreen(),
  ];

  void _onItemTap(int index) {
    setState(() {
      navigationProvider.setIndex(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    navigationProvider = Provider.of<NavigationProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: widgetPages[navigationProvider.selectedIndex],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Fluttertoast.showToast(
            msg: "Coming Soon",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
          );
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: safetyOrangeBlazeOrange,
        child: SvgPicture.asset(
          map,
          color: Colors.white,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          notchMargin: 10,
          child: SizedBox(
            height: 60,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MenuTab(
                        icon: home,
                        index: 0,
                        indexActive: navigationProvider.selectedIndex,
                        onPress: () {
                          _onItemTap(0);
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      MenuTab(
                        icon: love,
                        index: 1,
                        indexActive: navigationProvider.selectedIndex,
                        onPress: () {
                          _onItemTap(1);
                        },
                      ),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      MenuTab(
                        icon: home,
                        index: 2,
                        indexActive: navigationProvider.selectedIndex,
                        onPress: () {
                          _onItemTap(2);
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      MenuTab(
                        icon: user,
                        index: 3,
                        indexActive: navigationProvider.selectedIndex,
                        onPress: () {
                          _onItemTap(3);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )),
    );
  }
}

class MenuTab extends StatelessWidget {
  final int index, indexActive;
  final String icon;
  final void Function() onPress;

  const MenuTab(
      {Key? key,
      required this.icon,
      required this.onPress,
      required this.index,
      required this.indexActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPress,
      minWidth: 40,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            color: index == indexActive ? primary : grey1,
          )
        ],
      ),
    );
  }
}
