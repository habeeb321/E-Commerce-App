import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/loginscreen/view/login_screen.dart';

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          const LogingStackImage(),
          ScotchGetStarted(size: size),
        ],
      ),
    );
  }
}

class ScotchGetStarted extends StatelessWidget {
  const ScotchGetStarted({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          const Text(
            'Scotch',
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              'An E-commerce application used to buying and selling of goods and services, or the transmitting of funds or data.',
              style: TextStyle(fontSize: 17),
            ),
          ),
          InkWell(
            child: Container(
              height: size.height * 0.07,
              width: size.width * 0.5,
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    Text(
                      'Get started for free',
                      style: TextStyle(color: kWhitecolor),
                    ),
                    Icon(
                      Icons.keyboard_arrow_right,
                      color: kWhitecolor,
                    )
                  ],
                ),
              ),
            ),
            onTap: () => Get.to(LoginScreen()),
          ),
        ],
      ),
    );
  }
}

class LogingStackImage extends StatelessWidget {
  const LogingStackImage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stackSize = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          height: stackSize.height * 0.5,
          width: stackSize.width,
          decoration: const BoxDecoration(
            color: themeColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(140),
              bottomRight: Radius.circular(140),
            ),
          ),
        ),
        Positioned(
          top: stackSize.height * 0.3,
          left: stackSize.width * 0.33,
          child: const CircleAvatar(
            radius: 60,
            backgroundColor: kBlackcolor,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: kWhitecolor,
              backgroundImage: AssetImage(logo),
            ),
          ),
        ),
      ],
    );
  }
}
