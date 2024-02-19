import 'package:flutter/material.dart';
import 'package:riverpod_provider_eg/data/dummy_data.dart';
import 'package:riverpod_provider_eg/screens/meal_%20screen.dart';
import 'package:riverpod_provider_eg/model/category.dart';
import 'package:riverpod_provider_eg/widgets/category_item_widget.dart';

import '../model/meal.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key, required this.availableMeals});

  final List<Meal> availableMeals;

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 100),
        lowerBound: 0,
        upperBound: 1);
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _selectCategory(BuildContext context, CategoryModel category) {
    var filteredData = widget.availableMeals
        .where((element) => element.categories.contains(category.id))
        .toList();
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => MealsScreen(
                  title: category.title,
                  meals: filteredData,
                )));
    // Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=> MealsScreen(title: title, meals: meals)));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        child: GridView(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1.5,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            children: [
              for (final category in availableCategories) ...[
                CategoryItemWidget(
                  category: category,
                  onClickCat: () {
                    _selectCategory(context, category);
                  },
                )
              ]
            ]),
        builder: (context, child) {
          //Third method
          return SlideTransition(
            position:
                Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))
                    .animate(CurvedAnimation(
                        parent: _animationController, curve: Curves.easeInOut)),
            child: child,
          );

          //second method
          // return SlideTransition(
          //   position: _animationController.drive(
          //       Tween(begin: const Offset(0, 0.3), end: const Offset(0, 0))),
          //   child: child,
          // );

          ///Ist method
          // Padding(
          //     padding: EdgeInsets.only(
          //       top: 100 - _animationController.value,
          //     ),
          //     child: child);
        });
  }
}
