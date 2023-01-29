import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({
    Key? key,
    required this.name,
    required this.title,
    required this.address,
    required this.number,
    required this.onPressed,
  }) : super(key: key);
  final String name;
  final String title;
  final String address;
  final String number;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: kWhitecolor,
      padding: const EdgeInsets.all(
        10,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Deliver to:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  foregroundColor: themeColor,
                ),
                onPressed: onPressed,
                child: const Text(
                  'Change',
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                name.toUpperCase(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kWidth10,
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(
                    title,
                    style: const TextStyle(
                      color: Color.fromARGB(83, 0, 0, 0),
                      fontWeight: FontWeight.bold,
                      fontSize: 11,
                    ),
                  ),
                ),
              ),
            ],
          ),
          kHeight10,
          Text(
            address,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
          Text(
            number,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          kHeight5,
        ],
      ),
    );
  }
}
