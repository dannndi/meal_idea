import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meal_idea/ui/pages/detail_meal/detail_meal_controller.dart';
import 'package:meal_idea/ui/pages/home/home_controller.dart';

class DetailMealPage extends StatefulWidget {
  @override
  _DetailMealPageState createState() => _DetailMealPageState();
}

class _DetailMealPageState extends State<DetailMealPage> {
  var arguments = Get.arguments;
  var detailController = Get.put(DetailMealController());
  var _scrollController = ScrollController();
  var showTitle = false;
  var appBarColor = Colors.transparent;
  var elevation = 0.0;

  @override
  void initState() {
    super.initState();
    detailController.setMealDetail(
      id: arguments["id"],
      value: arguments["detail"],
    );

    _scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    super.dispose();

    _scrollController.removeListener(scrollListener);
  }

  void scrollListener() {
    if (_scrollController.offset > 100) {
      if (!showTitle) {
        setState(() {
          appBarColor = Colors.white;
          elevation = 2;
          showTitle = true;
        });
      }
    } else {
      setState(() {
        appBarColor = Colors.transparent;
        elevation = 0;
        showTitle = false;
      });
    }
  }

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
        title: showTitle
            ? Obx(() {
                return Text(
                  detailController.mealDetail.value?.strMeal ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                );
              })
            : SizedBox(),
        elevation: elevation,
        backgroundColor: appBarColor,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.favorite_outline),
            color: Colors.black,
            iconSize: 20,
          ),
        ],
      ),
      extendBodyBehindAppBar: true,
      body: Obx(() {
        switch (detailController.mealStatus.value) {
          case Status.init:
            return OnLoading();
          case Status.loading:
            return OnLoading();
          case Status.done:
            return OnDone(_scrollController);
          case Status.error:
            return OnError();
        }
      }),
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
          Text("Sorry something wrong, try another meal."),
        ],
      ),
    );
  }
}

class OnDone extends StatelessWidget {
  var detailController = Get.put(DetailMealController());
  ScrollController scrollController;
  OnDone(this.scrollController);
  @override
  Widget build(BuildContext context) {
    var meal = detailController.mealDetail.value;
    return SingleChildScrollView(
      controller: scrollController,
      child: ExpandableNotifier(
        child: ScrollOnExpand(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      meal?.strMealThumb ?? "",
                    ),
                    fit: BoxFit.fill,
                  ),
                ),
                child: Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 5),
                child: Text(
                  meal?.strMeal ?? "",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: meal?.strArea ?? "",
                        style: TextStyle(
                          color: Colors.black.withOpacity(0.7),
                          fontSize: 14,
                        ),
                      ),
                      if (meal?.strArea != null) ...[
                        TextSpan(
                          text: "   ●   ",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 10,
                          ),
                        ),
                        TextSpan(
                          text: meal?.strCategory ?? "",
                          style: TextStyle(
                            color: Colors.black.withOpacity(0.7),
                            fontSize: 14,
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                child: Divider(),
              ),
              ExpandablePanel(
                theme: ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToExpand: true,
                  tapHeaderToExpand: true,
                ),
                header: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Ingredients",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: 16,
                    ),
                  ),
                ),
                collapsed: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "Tap to see the ingredients",
                    style: Theme.of(context).textTheme.caption,
                  ),
                ),
                expanded: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          buildListTile(
                              meal?.strIngredient1, meal?.strMeasure1),
                          buildListTile(
                              meal?.strIngredient2, meal?.strMeasure2),
                          buildListTile(
                              meal?.strIngredient3, meal?.strMeasure3),
                          buildListTile(
                              meal?.strIngredient4, meal?.strMeasure4),
                          buildListTile(
                              meal?.strIngredient5, meal?.strMeasure5),
                          buildListTile(
                              meal?.strIngredient6, meal?.strMeasure6),
                          buildListTile(
                              meal?.strIngredient7, meal?.strMeasure7),
                          buildListTile(
                              meal?.strIngredient8, meal?.strMeasure8),
                          buildListTile(
                              meal?.strIngredient9, meal?.strMeasure9),
                          buildListTile(
                              meal?.strIngredient10, meal?.strMeasure10),
                          buildListTile(
                              meal?.strIngredient11, meal?.strMeasure11),
                          buildListTile(
                              meal?.strIngredient12, meal?.strMeasure12),
                          buildListTile(
                              meal?.strIngredient13, meal?.strMeasure13),
                          buildListTile(
                              meal?.strIngredient14, meal?.strMeasure14),
                          buildListTile(
                              meal?.strIngredient15, meal?.strMeasure15),
                          buildListTile(
                              meal?.strIngredient16, meal?.strMeasure16),
                          buildListTile(
                              meal?.strIngredient17, meal?.strMeasure17),
                          buildListTile(
                              meal?.strIngredient18, meal?.strMeasure18),
                          buildListTile(
                              meal?.strIngredient19, meal?.strMeasure19),
                          buildListTile(
                              meal?.strIngredient20, meal?.strMeasure20),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Instructions",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  meal?.strInstructions?.replaceAll("\n", "\n\n") ?? "",
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      ?.copyWith(fontSize: 14),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildListTile(String? item, String? value) {
    if (item == null && value == null) {
      return SizedBox();
    }

    if (item!.trim().isEmpty && value!.trim().isEmpty) {
      return SizedBox();
    }

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "●  $item",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
            TextSpan(
              text: "  -  ",
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 10,
              ),
            ),
            TextSpan(
              text: value,
              style: TextStyle(
                color: Colors.black.withOpacity(0.7),
                fontSize: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
