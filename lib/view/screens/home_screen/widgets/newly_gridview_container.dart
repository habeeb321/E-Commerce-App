import 'package:flutter/material.dart';

class NewlyGridviewContainer extends StatelessWidget {
  NewlyGridviewContainer({Key? key}) : super(key: key);

  List<String> items = [
    'https://m.media-amazon.com/images/I/71yzJoE7WlL._AC_UY327_FMwebp_QL65_.jpg',
    'https://m.media-amazon.com/images/I/81lnKynSaqL._AC_UY327_FMwebp_QL65_.jpg',
    'https://m.media-amazon.com/images/I/81-fFXQdPTL._AC_UY327_FMwebp_QL65_.jpg',
    'https://m.media-amazon.com/images/I/71AvQd3VzqL._AC_UY327_FMwebp_QL65_.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Card(
      elevation: 0,
      color: const Color(0xFFA0E7E5),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const ScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 5 / 5,
          ),
          itemBuilder: (context, index) {
            return Container(
              height: size.height * 0.5,
              width: size.width * 0.2,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(items[index]), fit: BoxFit.fill),
              ),
            );
          },
          itemCount: items.length,
        ),
      ),
    );
  }
}
