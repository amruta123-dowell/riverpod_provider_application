import 'package:flutter/material.dart';
import 'package:riverpod_provider_eg/custom_widget/meal_item.dart';
import 'package:riverpod_provider_eg/widgets/meal_details_screen.dart';

import '../model/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(
      {super.key,
      this.title,
      required this.meals,
     });

  final String? title;
  final List<Meal> meals;
  
  void onSelectedMeal(Meal meal, BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (_) => MealDetailsScreen(
              meal: meal,
            
            )));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Uh oh ... nothing here!',
            style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
          const SizedBox(height: 16),
          Text(
            'Try selecting a different category!',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
          ),
        ],
      ),
    );

    if (meals.isNotEmpty) {
      content = ListView.builder(
          itemCount: meals.length,
          itemBuilder: (ctx, index) => MealItem(
              meal: meals[index],
              onClickMeal: (meal) {
                onSelectedMeal(meals[index], context);
              }));
    }
    if (title == null) {
      return content;
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
