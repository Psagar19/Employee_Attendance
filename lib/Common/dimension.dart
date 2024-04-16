import 'package:flutter/cupertino.dart';

double screenWidth(BuildContext context) {
  return MediaQuery.sizeOf(context).width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.sizeOf(context).height;
}

class HeightGap extends StatelessWidget {
  const HeightGap({super.key, required this.gap});
  final double gap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.sizeOf(context).height * gap);
  }
}

  class WidthGap extends StatelessWidget {
  const WidthGap({super.key, required this.gap});
  final double gap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(height: MediaQuery.sizeOf(context).width * gap);
  }
}
