import 'package:flutter/material.dart';

import '../model/category.dart';

class CategoryItemWidget extends StatelessWidget {
  final CategoryModel category;
  final void Function() onClickCat;
  const CategoryItemWidget(
      {required this.category, required this.onClickCat, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onClickCat,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(15),
        margin: const EdgeInsets.all(20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(colors: [
              category.color.withOpacity(0.5),
              category.color.withOpacity(0.9)
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        child: Text(
          category.title,
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
        ),
      ),
    );
  }
}
