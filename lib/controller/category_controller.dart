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
  Future<List<CategoryItem>> getUserCategories(PocketBase pb, UserModel user) async {
    List<RecordModel> rawData = await pb.collection('categoryItem').getFullList();
    List<CategoryItem> categories = [];
    for (RecordModel model in rawData){
      categories.add(CategoryItem.fromModel(model));
    }
    if(categories.isEmpty) throw Exception("$user.username has no items.");
    return categories;
  }
}
