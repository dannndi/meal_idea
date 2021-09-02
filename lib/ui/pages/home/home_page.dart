import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meal_idea/ui/pages/home/home_controller.dart';
import 'package:meal_idea/ui/widgets/selectable_box.dart';
import 'package:sticky_headers/sticky_headers.dart';

class HomePage extends StatelessWidget {
  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 15, left: 24, right: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Text(
                          "Hallo Dandi",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Text(
                        "What you want to cook today ?",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.favorite_outline,
                    ),
                  )
                ],
              ),
            ),
            Container(
              height: 46,
              margin: EdgeInsets.only(top: 20, left: 24, right: 24),
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.blueGrey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              alignment: Alignment.center,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.search,
                    color: Colors.black54,
                  ),
                  SizedBox(width: 10),
                  Text(
                    "Search Recipes",
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(vertical: 10),
              child: Obx(
                () {
                  return ListView.builder(
                    itemCount: homeController.categories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      return SelectableBox(
                        title: homeController.categories[index],
                        width: 60,
                        margin: EdgeInsets.only(
                          left: index == 0 ? 10 : 5,
                          right: index == homeController.categories.length - 1
                              ? 10
                              : 5,
                        ),
                        isSelected: homeController.selectedCategorie.value ==
                            homeController.categories[index],
                        onTap: () {
                          homeController.setSelectedCategorie(
                            homeController.categories[index],
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
            Expanded(
              child: StaggeredGridView.countBuilder(
                padding: EdgeInsets.symmetric(horizontal: 10),
                crossAxisCount: 4,
                itemCount: 15,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    color: Colors.green,
                    child: new Center(
                      child: new CircleAvatar(
                        backgroundColor: Colors.white,
                        child: new Text('$index'),
                      ),
                    ),
                  );
                },
                staggeredTileBuilder: (int index) {
                  return StaggeredTile.count(2, index.isEven ? 3 : 2);
                },
                mainAxisSpacing: 4.0,
                crossAxisSpacing: 4.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
