import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:meal_idea/data/source/local/entity/meal_detail_entity.dart';
import 'package:meal_idea/nav_routes.dart';
import 'package:meal_idea/ui/pages/detail_meal/detail_meal_page.dart';
import 'package:meal_idea/ui/pages/favorite/favorite_page.dart';
import 'package:meal_idea/ui/pages/get_started/get_started_page.dart';
import 'package:meal_idea/ui/pages/home/home_page.dart';
import 'package:meal_idea/ui/pages/search/search_page.dart';

void main() async {
  await Hive.initFlutter();
  // box for owner username
  await Hive.openBox('profile');
  Hive.registerAdapter(MealDetailEntityAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.transparent,
    ));
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(
          name: '/',
          page: () {
            var profileBox = Hive.box("profile");
            var name = profileBox.get("username");
            if (name != null) {
              return HomePage();
            } else {
              return GetStartedPage();
            }
          },
        ),
        GetPage(name: NavRoutes.Home, page: () => HomePage()),
        GetPage(name: NavRoutes.Favorite, page: () => FavoritePage()),
        GetPage(name: NavRoutes.SearchInput, page: () => SearchInputPage()),
        GetPage(name: NavRoutes.Detail, page: () => DetailMealPage())
      ],
    );
  }
}
