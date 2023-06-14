import 'package:flutter/material.dart';

class CategoryItemWidget extends StatelessWidget {
  final String categoryName;

  const CategoryItemWidget({
    required this.categoryName,
    //required this.categoryIcoUrl,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(10),
            width: 50,
            height: 50,
            // decoration: BoxDecoration(
            //   shape: BoxShape.circle,
            //   image: DecorationImage(
            //     image: NetworkImage(categoryIcoUrl),
            //     fit: BoxFit.fill,
            //   ),
            // ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(
            categoryName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
