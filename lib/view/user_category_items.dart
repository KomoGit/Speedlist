import 'package:flutter/material.dart';
import 'package:speedlist/Utilities/user_utilities.dart';
import 'package:speedlist/model/category_item.dart';
import 'package:speedlist/view/widgets/category_item.dart';
import 'package:speedlist/view/widgets/drawer.dart';
import 'package:speedlist/view/widgets/persistent_app_bar.dart';

import '../Utilities/backend_utilities.dart';
import '../controller/category_controller.dart';
import '../debug/print.dart';


class UserCategoryItems extends StatefulWidget {

  const UserCategoryItems({
    super.key,
  });

  @override
  State<UserCategoryItems> createState() => _UserCategoryItemsState();
}

class _UserCategoryItemsState extends State<UserCategoryItems> {

  static Future<List<CategoryItem>> loadData() async {
    List<CategoryItem> rawItems = await CategoryController().getAllCategoryItems(BackendUtilities.getBackendAccess());
    return CategoryController().getAllUserCategories(rawItems, UserUtilities.user);
  }

  final Future<List<CategoryItem>> _categoryData = loadData();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const PersistentAppBar(),
      drawer: PersistentDrawer(user: UserUtilities.user),
      body: FutureBuilder<List<CategoryItem>>(
        future: _categoryData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.orange,
                backgroundColor: Colors.blueGrey,
              ),
            );
          }
          if (snapshot.hasError) {
            Debug.printLog('Error ${snapshot.error}');
          }
          final categories = snapshot.data ?? [];
          if (categories.isEmpty) {
            return const Center(
              child: Text("Data could not be retrieved from the server."),
            );
          }
          return Container(
            color: Colors.white,
            child: ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index) {
                  return CategoryItemWidget(categoryName: categories[index].itemName);
                },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: categories.length),
          );
        },
      ),
    );
  }
}