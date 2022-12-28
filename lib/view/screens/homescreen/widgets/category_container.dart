import 'package:flutter/material.dart';
import 'package:scotch/core/const.dart';

class CategoryContainer extends StatelessWidget {
  CategoryContainer({Key? key}) : super(key: key);

  List<String> items = [
    'https://img0.junaroad.com/stories/story_p_6396d50bf47b70081b045858-1671621426.jpeg',
    'https://img3.junaroad.com/stories/story_p_63886dd3adb8b82d0eeeae88-1670492558.jpeg',
    'https://img2.junaroad.com/stories/story_p_634d060eb388b00820cf040a-1666781038.jpeg',
    'https://img1.junaroad.com//assets/images/mobileNotif/img-1657799410925.jpg?crsl_pos=0',
    'https://img1.junaroad.com//assets/images/mobileNotif/img-1658918101342.jpg?crsl_pos=0',
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      height: 100,
      child: ListView.separated(
        itemBuilder: (context, index) {
          return Row(
            children: [
              Column(
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      height: size.height * 0.1,
                      width: size.width * 0.2,
                      decoration: BoxDecoration(
                        color: kBlackcolor,
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: NetworkImage(items[index]),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (BuildContext context, int index) {
          return kWidth10;
        },
      ),
    );
  }
}
