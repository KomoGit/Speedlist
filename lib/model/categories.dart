import 'package:pocketbase/pocketbase.dart';

// Have not been tested yet.
class CategoryModel {
  String collectionId;
  String categoryName;
  String categoryIcoUrl;

  CategoryModel(this.collectionId, this.categoryName, this.categoryIcoUrl);

  static CategoryModel fromModel(RecordModel model) {
    String collectionId = model.collectionId;
    String categoryName = model.getStringValue("categoryName");
    String categoryIcoUrl = model.getStringValue("categoryIcoUrl");

    return CategoryModel(collectionId, categoryName, categoryIcoUrl);
  }
}
