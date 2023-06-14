import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/model/category_item.dart';
import 'package:speedlist/model/user.dart';

import '../model/categories.dart';

//Pocketbase Credentials - #PASS - D969X5NU2y3sNy5
//#LOGIN - example@example.com

class CategoryController {
  Future<List<CategoryModel>> getAllCategories(PocketBase pb) async {
    //This is going to cause a very huge bottleneck for our application.
    //Best way to optimize this would be to ensure only a number of items are being returned and spread it among pages.
    //There will be issues in optimizing the code to not send out same 20 items again and again.
    List<RecordModel> rawData = await pb
        .collection('categories')
        .getFullList()
        .timeout(const Duration(seconds: 10));
    List<CategoryModel> categories = [];
    for (RecordModel model in rawData) {
      categories.add(CategoryModel.fromModel(model));
    }
    return categories;
  }
  //PERFORMANCE SINK
  Future<List<CategoryItem>> getAllCategoryItems(PocketBase pb) async {
    List<RecordModel> rawData = await pb.collection('categoryItem').getFullList();
    List<CategoryItem> categories = [];
    for (RecordModel model in rawData){
      categories.add(CategoryItem.fromModel(model));
    }
    if(categories.isEmpty) throw Exception("No items can be found");
    return categories;
  }
  //Possibly the worst thing that was made after nukes and ebola. This thing hurts to look at but I have no other implementation in mind.
  List<CategoryItem> getAllUserCategories(List<CategoryItem> items, UserModel user) {
    List<CategoryItem> userItems = [];
    for (CategoryItem item in items){
      if(item.parentUser == user.id){
        userItems.add(item);
      }
    }
    if (userItems.isEmpty) throw Exception("$user.username has no items");
    return userItems;
  }
}
