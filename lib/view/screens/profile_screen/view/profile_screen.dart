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
            child: GetBuilder<ProfileController>(
              builder: (controller) {
                return Column(
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
                              size: 30,
                            ),
                            size: 17,
                            text: 'Edit profile',
                            ontap: () {},
                            trailIcon: const Icon(
                              Icons.arrow_forward,
                              size: 25,
                            ),
                          ),
                          kHeight10,
                          ProfileWidget(
                            icon: const Icon(
                              Icons.location_on,
                              size: 30,
                            ),
                            text: 'Saved Address',
                            ontap: () {
                              profileController.goToAddressPage();
                            },
                            trailIcon: const Icon(
                              Icons.arrow_forward,
                              size: 25,
                            ),
                            size: 17,
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
                              size: 30,
                            ),
                            text: 'Terms & Condition',
                            ontap: () {},
                            size: 17,
                            trailIcon: const Icon(
                              Icons.arrow_forward,
                              size: 25,
                            ),
                          ),
                          kHeight10,
                          ProfileWidget(
                            icon: const Icon(
                              Icons.privacy_tip,
                              size: 30,
                            ),
                            text: 'Privacy Policy',
                            size: 17,
                            ontap: () {},
                            trailIcon: const Icon(
                              Icons.arrow_forward,
                              size: 25,
                            ),
                          ),
                          kHeight10,
                          ProfileWidget(
                            icon: const Icon(
                              Icons.info,
                              size: 30,
                            ),
                            text: 'About',
                            ontap: () {},
                            size: 17,
                            trailIcon: const Icon(
                              Icons.arrow_forward,
                              size: 25,
                            ),
                          ),
                          kHeight10,
                          ProfileWidget(
                            icon: const Icon(
                              Icons.logout,
                              size: 30,
                            ),
                            text: 'Log Out',
                            ontap: () {
                              profileController.logOut(context);
                            },
                            size: 17,
                            trailIcon: const Icon(
                              Icons.arrow_forward,
                              size: 25,
                            ),
                          ),
                        ],
                      ),
                    ),
                    kHeight10,
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
