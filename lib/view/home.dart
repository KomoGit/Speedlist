import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:speedlist/view/widgets/category_controller.dart';
import 'package:speedlist/model/categories.dart';
import 'package:speedlist/view/widgets/drawer.dart';
import 'package:speedlist/view/widgets/view_category.dart';

import '../debug/print.dart';

PocketBase pb = PocketBase("http://192.168.0.104:8090");

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Future<List<CategoryModel>> _categoryData = loadData();
  static Future<List<CategoryModel>> loadData() async {
    return await CategoryController().fromRecordsToModels(pb);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer:
          const PersistentDrawer(), //The drawer will be dynamic, it will be filled with items dynamically. Remove const once implemented
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text(
            "Project - Speedlist"), //Make this a constant entity that can be called anywhere in the app.
      ),
      body: FutureBuilder<List<CategoryModel>>(
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
                  return CategoryWidget(
                      categoryName: categories[index].categoryName,
                      categoryIcoUrl: categories[index].categoryIcoUrl);
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
