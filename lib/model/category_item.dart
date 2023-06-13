import 'package:pocketbase/pocketbase.dart';
//Implement owner user for item. Use either whole UserModel or use just string id,
//whichever you see fit. My advise you UserModel as whole.
class CategoryItem {
  String collectionId;
  String parentUser; //Owner of the item.
  String itemName;
  String itemDescription;
  String itemLocation;

  CategoryItem(this.collectionId,this.parentUser,this.itemName, this.itemDescription, this.itemLocation);

  static CategoryItem fromModel(RecordModel model) {
    String collectionId = model.collectionId;
    String owningUserId = model.getStringValue("parentUser");
    String itemName = model.getStringValue("itemName");
    String itemDescription = model.getStringValue("itemDescription");
    String itemLocation = model.getStringValue("itemLocation");

    return CategoryItem(collectionId, owningUserId, itemName, itemDescription, itemLocation);
  }
}
