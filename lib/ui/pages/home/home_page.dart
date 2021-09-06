import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meal_idea/nav_routes.dart';
import 'package:meal_idea/ui/pages/home/home_controller.dart';
import 'package:meal_idea/ui/widgets/selectable_box.dart';

class HomePage extends StatelessWidget {
  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      extendBodyBehindAppBar: true,
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
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 5),
                        child: Obx(
                          () => Text(
                            "Hallo ${homeController.username}",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                            ),
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
                  GestureDetector(
                    onTap: () => Get.toNamed(NavRoutes.Favorite),
                    child: Container(
                      width: 50,
                      height: 50,
                      child: Icon(
                        Icons.favorite_border,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => Get.toNamed(NavRoutes.SearchInput),
              child: Container(
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
            ),
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(vertical: 15),
              child: Obx(
                () => ListView.builder(
                  itemCount: homeController.categories.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Obx(
                      () {
                        return SelectableBox(
                          title: homeController.categories[index].strCategory,
                          padding: EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
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
            ),
            Expanded(
              child: Obx(() {
                if (homeController.mealStatus.value == Status.done) {
                  return Obx(
                    () => StaggeredGridView.countBuilder(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      crossAxisCount: 4,
                      itemCount: homeController.meals.length,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () => Get.toNamed(
                            NavRoutes.Detail,
                            arguments: {
                              "id": homeController.meals[index].idMeal,
                              "detail": null,
                            },
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context)
                                  .primaryColor
                                  .withOpacity(0.2),
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                image: NetworkImage(
                                    homeController.meals[index].strMealThumb),
                                fit: BoxFit.fill,
                              ),
                            ),
                            child: Container(
                              padding: EdgeInsets.fromLTRB(10, 0, 10, 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                gradient: LinearGradient(
                                  colors: [Colors.black, Colors.transparent],
                                  begin: Alignment.bottomCenter,
                                  end: Alignment.center,
                                ),
                              ),
                              alignment: Alignment.bottomLeft,
                              child: Text(
                                homeController.meals[index].strMeal,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
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
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
