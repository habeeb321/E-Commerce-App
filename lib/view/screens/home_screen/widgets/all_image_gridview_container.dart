import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scotch/core/const.dart';
import 'package:scotch/view/screens/home_screen/controller/home_controller.dart';

class AllImageGridviewContainer extends StatelessWidget {
  AllImageGridviewContainer({Key? key}) : super(key: key);

  List<String> items = [
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROEy6HFi9g3cF8EttxQpGM0juTIVLAhhxAbQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2ueq9b3-C9p-BzUtfeaE5MCsrwSG1R751zQ&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQjJEY_JtGFkmuwMl-T-MpMFSbBtU8cWmah1w&usqp=CAU',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRm5N931d5WVvluRD3SygGFKlkUWZpokJ37FA&usqp=CAU',
    'https://img2.junaroad.com/stories/story_p_63a390baadb8b82d0e0f299b-1671673435.jpeg',
    'https://img2.junaroad.com/stories/story_p_63870c45adb8b82d0eece6da-1671739758.jpeg',
  ];

  List<String> names = [
    'Womens fashion',
    'Christmas outfits',
    'Iphone 14 pro',
    'Accessories',
    'Shoes',
    'Mens fashion',
  ];

  @override
  Widget build(BuildContext context) {
    HomeController homeController = Get.put(HomeController(context));

    Size size = MediaQuery.of(context).size;
    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const ScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        childAspectRatio: 5.1 / 6,
      ),
      itemBuilder: (context, index) {
        return Column(
          children: [
            Container(
              height: size.height * 0.2,
              width: size.width * 0.4,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                    image: NetworkImage(
                        'http://172.16.6.168:5000/uploads/products/${homeController.productList[index].image[0]}'),
                    fit: BoxFit.cover),
              ),
            ),
            SizedBox(
              height: 40,
              width: size.width * 0.4,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(names[index]),
                  Text('₹${index * 5000 + index + 200}', style: textStyle),
                ],
              ),
            ),
          ],
        );
      },
      itemCount: homeController.productList.length,
    );
  }
}
