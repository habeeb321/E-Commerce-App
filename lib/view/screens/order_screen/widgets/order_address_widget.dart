import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/address_screen/controller/address_controller.dart';
import 'package:scotch/view/screens/profile_screen/widgets/profile_widget.dart';

class OrderAddressWidget extends StatelessWidget {
  const OrderAddressWidget({
    Key? key,
    required this.index,
    required this.value,
  }) : super(key: key);

  final int index;
  final AddressController value;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: kWhitecolor,
      child: Column(
        children: [
          ProfileWidget(
            text: 'Deliver to :',
            size: 16,
            ontap: () {},
            trailIcon: SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: kWhitecolor,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(color: kGreyColor),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                child: const Text(
                  'Change',
                  style: TextStyle(
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                    letterSpacing: 1,
                  ),
                ),
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 15, right: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                kHeight10,
                Row(
                  children: [
                    Text(
                      // value.addressModel?.fullName ?? "",
                      value.addressList[index].fullName.toUpperCase(),
                      style: const TextStyle(
                        fontFamily: "Manrope",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    kWidth10,
                    Container(
                      height: 20,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black.withOpacity(0.3),
                      ),
                      child: Text(
                        value.addressList[index].title.toUpperCase(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 14,
                          color: kWhitecolor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            // value.deleteAddress(
                            //     value.addressList[index].id, context);
                          },
                          icon: const Icon(
                            Icons.delete,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Text(
                  value.addressList[index].address,
                  style: const TextStyle(
                    fontFamily: "Manrope",
                    letterSpacing: 1,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      "PIN :${value.addressList[index].pin}, ",
                      style: const TextStyle(
                        fontFamily: "Manrope",
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      value.addressList[index].state,
                      style: const TextStyle(
                        fontFamily: "Manrope",
                        letterSpacing: 1,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Text(
                  value.addressList[index].place,
                  style: const TextStyle(
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                kHeight10,
                Text(
                  value.addressList[index].phone,
                  style: const TextStyle(
                    fontFamily: "Manrope",
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                ),
                kHeight10,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
