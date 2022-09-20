import 'package:crestaurant2/values/icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget noConnection() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Center(
      child: SvgPicture.asset(
        noConnectionImage,
        width: 300,
      ),
    ),
  );
}

Widget notFound() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Center(
      child: SvgPicture.asset(
        notFoundImage,
        width: 300,
      ),
    ),
  );
}

Widget errorCode() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Center(
      child: SvgPicture.asset(
        errorImage,
        width: 200,
      ),
    ),
  );
}

Widget empty() {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 10),
    child: Center(
      child: SvgPicture.asset(
        emptyWishList,
        width: 250,
      ),
    ),
  );
}
