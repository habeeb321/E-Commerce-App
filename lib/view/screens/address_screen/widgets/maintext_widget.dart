import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class MainTextWidget extends StatelessWidget {
  const MainTextWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Scotch',
        style: TextStyle(
          fontFamily: 'FredokaOne',
          fontSize: 30,
          color: kBlackcolor,
        ),
      ),
    );
  }
}
