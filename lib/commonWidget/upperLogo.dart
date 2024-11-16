import 'package:flutter/material.dart';
import '../theme.dart';

class UpperLogo extends StatelessWidget {
  const UpperLogo({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          EdgeInsets.symmetric(horizontal: width / 20, vertical: height / 20),
      height: height * 0.3,
      width: width * 0.9,
      decoration: BoxDecoration(
          shape: BoxShape.circle,
          image: const DecorationImage(
              image: AssetImage("assets/images/gardeniaLogo.jpg"),
              fit: BoxFit.cover),
          color: ThemeColor.white,
          borderRadius: null),
    );
  }
}

class UpperLogo2 extends StatelessWidget {
  const UpperLogo2({
    super.key,
    required this.width,
    required this.height,
  });

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: height * 0.1),
      child: CircleAvatar(
        backgroundImage: const AssetImage(
          "assets/images/gardeniaLogo.jpg",
        ),
        child: SizedBox(
          height: height * 0.3,
          width: width * 0.8,
        ),
      ),
    );
  }
}
