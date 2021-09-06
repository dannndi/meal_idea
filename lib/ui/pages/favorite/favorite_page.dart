import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_idea/ui/pages/favorite/favorite_controller.dart';

import '../../../nav_routes.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  var favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(Icons.arrow_back_ios),
          color: Colors.black,
          iconSize: 20,
        ),
        title: Text(
          "Favorite Meal",
          style: TextStyle(
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        if (favoriteController.listFavorite.value == null) {
          return OnError();
        } else {
          if (favoriteController.listFavorite.value!.isEmpty) {
            return OnEmpty();
          } else {
            return OnDone();
          }
        }
      }),
    );
  }
}

class OnError extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: 150,
            height: 150,
            image: NetworkImage(
              "https://img.freepik.com/free-vector/plate-cuttlery-graphic-illustration_53876-9118.jpg",
            ),
          ),
          SizedBox(height: 15),
          Text("Sorry something wrong"),
        ],
      ),
    );
  }
}

class OnEmpty extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            width: 150,
            height: 150,
            image: NetworkImage(
              "https://img.freepik.com/free-vector/plate-cuttlery-graphic-illustration_53876-9118.jpg",
            ),
          ),
          SizedBox(height: 15),
          Text("You don't have favorite food yet, try ad some  :D"),
        ],
      ),
    );
  }
}

class OnDone extends StatelessWidget {
  var favoriteController = Get.put(FavoriteController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return ListView.builder(
          itemCount: favoriteController.listFavorite.value!.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () async {
                await Get.toNamed(
                  NavRoutes.Detail,
                  arguments: {
                    "id": favoriteController.listFavorite.value![index].idMeal,
                    "detail": favoriteController.listFavorite.value![index],
                  },
                );
                favoriteController.getFavorite();
              },
              child: Container(
                height: 60,
                margin: EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          image: DecorationImage(
                            image: NetworkImage(
                              favoriteController.listFavorite.value![index]
                                      .strMealThumb ??
                                  "",
                            ),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              favoriteController
                                      .listFavorite.value![index].strMeal ??
                                  "",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                              maxLines: 1,
                            ),
                            SizedBox(height: 5),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                children: [
                                  TextSpan(
                                    text: favoriteController.listFavorite
                                            .value![index].strArea ??
                                        "",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 11,
                                    ),
                                  ),
                                  if (favoriteController
                                          .listFavorite.value![index].strArea !=
                                      null) ...[
                                    TextSpan(
                                      text: "   ●   ",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 9,
                                      ),
                                    ),
                                    TextSpan(
                                      text: favoriteController.listFavorite
                                              .value![index].strCategory ??
                                          "",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 11,
                                      ),
                                    ),
                                  ]
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
