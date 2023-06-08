import 'package:flutter/material.dart';
import 'package:speedlist/Utilities/user_utilities.dart';
import 'package:speedlist/view/widgets/drawer.dart';
import 'package:speedlist/view/widgets/persistent_app_bar.dart';


class UserCategoryItems extends StatefulWidget {
  const UserCategoryItems({
    super.key,
  });

  @override
  State<UserCategoryItems> createState() => _UserCategoryItemsState();
}

class _UserCategoryItemsState extends State<UserCategoryItems> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     appBar: const PersistentAppBar(),
      drawer: PersistentDrawer(user: UserUtilities.user),
    );
  }
}