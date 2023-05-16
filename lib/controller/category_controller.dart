import 'package:pocketbase/pocketbase.dart';

import '../model/categories.dart';

//Pocketbase Credentials - #PASS - D969X5NU2y3sNy5
//#LOGIN - example@example.com

class CategoryController {
  Future<List<CategoryModel>> fromRecordsToModels(PocketBase pb) async {
    var rawData = await pb
        .collection('categories')
        .getFullList()
        .timeout(const Duration(seconds: 10));
    List<RecordModel> listOfCategory = rawData;
    List<CategoryModel> categories = [];
    for (RecordModel model in listOfCategory) {
      categories.add(CategoryModel.fromModel(model));
    }
    return categories;
  }
}
