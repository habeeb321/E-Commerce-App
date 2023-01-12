import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/profile_screen/controller/profile_controller.dart';
import 'package:scotch/view/screens/profile_screen/widgets/profile_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ProfileController profileController = Get.put(ProfileController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10),
            child: Column(
              children: [
                kHeight10,
                Row(
                  children: const [
                    kWidth10,
                    Text('Account Settings', style: kTextstyle),
                  ],
                ),
                kHeight10,
                Card(
                  elevation: 0.1,
                  color: kWhitecolor,
                  child: Column(
                    children: [
                      ProfileWidget(
                        icon: const Icon(
                          Icons.person,
                        ),
                        size: 15,
                        text: 'Edit profile',
                        ontap: () {},
                        trailIcon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                      ),
                      kHeight10,
                      ProfileWidget(
                        icon: const Icon(
                          Icons.location_on,
                        ),
                        text: 'Saved Address',
                        ontap: () {},
                        trailIcon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                        size: 15,
                      ),
                    ],
                  ),
                ),
                kHeight10,
                Row(
                  children: const [
                    kWidth10,
                    Text('Information & Feedback', style: kTextstyle),
                  ],
                ),
                kHeight10,
                Card(
                  elevation: 0.1,
                  child: Column(
                    children: [
                      ProfileWidget(
                        icon: const Icon(
                          Icons.description,
                        ),
                        text: 'Terms & Condition',
                        ontap: () {},
                        size: 15,
                        trailIcon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                      ),
                      kHeight10,
                      ProfileWidget(
                        icon: const Icon(
                          Icons.privacy_tip,
                        ),
                        text: 'Privacy Policy',
                        size: 15,
                        ontap: () {},
                        trailIcon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                      ),
                      kHeight10,
                      ProfileWidget(
                        icon: const Icon(
                          Icons.info,
                        ),
                        text: 'About',
                        ontap: () {},
                        size: 15,
                        trailIcon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                      ),
                      kHeight10,
                      ProfileWidget(
                        icon: const Icon(
                          Icons.logout,
                        ),
                        text: 'Log Out',
                        ontap: () {
                          profileController.logOut(context);
                        },
                        size: 15,
                        trailIcon: const Icon(
                          Icons.arrow_forward_ios_outlined,
                        ),
                      ),
                    ],
                  ),
                ),
                kHeight10,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
