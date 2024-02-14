import 'package:flutter/material.dart';
import 'package:riverpod_provider_eg/data/dummy_data.dart';
import 'package:riverpod_provider_eg/screens/meal_%20screen.dart';
import 'package:riverpod_provider_eg/model/category.dart';
import 'package:riverpod_provider_eg/widgets/category_item_widget.dart';

import '../model/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFav});

  final void Function(Meal meal) onToggleFav;
  _selectCategory(BuildContext context, CategoryModel category) {
    var filteredData = dummyMeals
        .where((element) => element.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MealsScreen(
                  title: category.title,
                  meals: filteredData,
                  onToggleFavorites: onToggleFav,
                )));
    // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MealsScreen(title: title, meals: meals)));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.5,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        children: [
          // availableCategories
          //     .map((cat) => CategoryItemWidget(
          //           category: cat,
          //           onClickCat: _selectCatory(context),
          //         ))
          //     .toList()
          for (final category in availableCategories) ...[
            CategoryItemWidget(
              category: category,
              onClickCat: () {
                _selectCategory(context, category);
              },
            )
          ]
        ]);
  }
}