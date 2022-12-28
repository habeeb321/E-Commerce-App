import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GridView.builder(
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
                image: NetworkImage(items[index]), fit: BoxFit.cover),
          ),
        );
      },
      itemCount: items.length,
    );
  }
}
