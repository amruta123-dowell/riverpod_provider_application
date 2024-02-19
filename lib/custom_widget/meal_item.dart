import 'package:flutter/material.dart';
import 'package:riverpod_provider_eg/custom_widget/meal_item_trait.dart';
import 'package:transparent_image/transparent_image.dart';

import '../model/meal.dart';

class MealItem extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) onClickMeal;
  const MealItem({super.key, required this.meal, required this.onClickMeal});
  String get complexityText {
    return meal.complexity.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  String get affordabilityText {
    return meal.affordability.name[0].toUpperCase() +
        meal.complexity.name.substring(1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      clipBehavior: Clip.hardEdge,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onClickMeal(meal);
        },
        child: Stack(
          children: [
            Hero(
              tag: meal.id,
              child: FadeInImage(
                placeholder: MemoryImage(kTransparentImage),
                image: NetworkImage(meal.imageUrl),
                fit: BoxFit.cover,
                height: 200,
                width: double.infinity,
              ),
            ),
            Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  alignment: Alignment.bottomRight,
                  color: Colors.black26,
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 44),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        meal.title,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      Row(
                        children: [
                          MealItemTrait(
                              icon: Icons.schedule,
                              label: "${meal.duration} mins"),
                          const SizedBox(
                            width: 7,
                          ),
                          MealItemTrait(
                              icon: Icons.work, label: "$complexityText min"),
                          const SizedBox(
                            width: 7,
                          ),
                          MealItemTrait(
                              icon: Icons.attach_money, label: complexityText)
                        ],
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
