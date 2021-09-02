import 'package:get/get.dart';
import 'package:hive/hive.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getUsername();
    getCategories();
  }

  var username = "".obs;
  RxList<String> categories = <String>[].obs;
  RxString selectedCategorie = "".obs;

  void getUsername() {
    var profileBox = Hive.box("profile");
    username.value = profileBox.get("username");
  }

  void getCategories() {
    categories.addAll(
        ["Beef", "Chicken", "AAAA", "BBBB", "CCCC", "DDDD", "EEEE", "FFFFF"]);
    selectedCategorie.value = categories[0];
  }

  void setSelectedCategorie(String categorie) {
    selectedCategorie.value = categorie;
  }
}
