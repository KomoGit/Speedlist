import 'package:flutter/material.dart';

class PersistentAppBar extends StatefulWidget implements PreferredSizeWidget{

  const PersistentAppBar({super.key});

  @override
  State<PersistentAppBar> createState() => _PersistentAppBarState();

  @override
  // TODO: implement preferredSize
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _PersistentAppBarState extends State<PersistentAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
        centerTitle: true,
        title: const Text(
            "Project - Speedlist"),
    );
  }
}


