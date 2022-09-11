import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttertoast/fluttertoast.dart';

class MenuWidget extends StatelessWidget {
  final String label, icon;
  final Color color;

  const MenuWidget(
      {Key? key, required this.label, required this.color, required this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Fluttertoast.showToast(
          msg: "Coming Soon",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );
      },
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
                color: color, borderRadius: BorderRadius.circular(18)),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: SvgPicture.asset(icon),
            ),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(label)
        ],
      ),
    );
  }
}
