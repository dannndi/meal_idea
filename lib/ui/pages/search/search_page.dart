import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:meal_idea/ui/pages/home/home_controller.dart';
import 'package:meal_idea/ui/pages/search/search_controller.dart';

class SearchInputPage extends StatefulWidget {
  @override
  _SearchInputPageState createState() => _SearchInputPageState();
}

class _SearchInputPageState extends State<SearchInputPage> {
  TextEditingController _textEditingController = TextEditingController();
  var searchController = Get.put(SearchController());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Get.back(),
          iconSize: 20,
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black.withOpacity(0.8),
          ),
        ),
        backgroundColor: Colors.white,
        title: TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Search for Recipe",
          ),
          autofocus: true,
          textInputAction: TextInputAction.search,
          onChanged: (value) {
            searchController.onQueryChange(value);
          },
          onSubmitted: (value) {
            if (value.isEmpty) {
              return;
            }
            searchController.searchMealByKeyword();
          },
        ),
        actions: [
          Obx(() {
            if (searchController.query.isNotEmpty) {
              return IconButton(
                onPressed: () {
                  _textEditingController.clear();
                  searchController.onQueryChange("");
                },
                highlightColor: Colors.transparent,
                icon: Icon(
                  Icons.close,
                  color: Colors.black,
                ),
              );
            } else {
              return Container();
            }
          })
        ],
        elevation: 1,
      ),
      backgroundColor: Colors.white,
      body: Obx(() {
        switch (searchController.searchStatus.value) {
          case SearchStatus.initial:
            return OnInitial();
          case SearchStatus.loading:
            return OnLoading();
          case SearchStatus.done:
            return OnDone();
          case SearchStatus.error:
            return OnError();
        }
      }),
    );
  }
}

class OnInitial extends StatelessWidget {
  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: StaggeredGridView.countBuilder(
        padding: EdgeInsets.symmetric(horizontal: 10),
        crossAxisCount: 4,
        itemCount: homeController.categories.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: NetworkImage(
                    homeController.categories[index].strCategoryThumb),
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
                homeController.categories[index].strCategory,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
        staggeredTileBuilder: (int index) {
          return StaggeredTile.count(2, index.isEven ? 2 : 1);
        },
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
      ),
    );
  }
}

class OnLoading extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(),
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
          Text("Sorry something wrong, try another keyword."),
        ],
      ),
    );
  }
}

class OnDone extends StatelessWidget {
  var searchController = Get.put(SearchController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Obx(() {
        return ListView.builder(
          itemCount: searchController.mealsResult.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {},
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
                              searchController
                                      .mealsResult[index].strMealThumb ??
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
                              searchController.mealsResult[index].strMeal ?? "",
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
                                    text: searchController
                                            .mealsResult[index].strArea ??
                                        "",
                                    style: TextStyle(
                                      color: Colors.black.withOpacity(0.7),
                                      fontSize: 11,
                                    ),
                                  ),
                                  if (searchController
                                          .mealsResult[index].strArea !=
                                      null) ...[
                                    TextSpan(
                                      text: "   ●   ",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.7),
                                        fontSize: 9,
                                      ),
                                    ),
                                    TextSpan(
                                      text: searchController
                                              .mealsResult[index].strCategory ??
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
