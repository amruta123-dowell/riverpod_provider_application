import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_provider_eg/data/dummy_data.dart';
import 'package:riverpod_provider_eg/providers/favorite_meal_notifier.dart';
import 'package:riverpod_provider_eg/providers/meal_provider.dart';

import 'package:riverpod_provider_eg/screens/categories_screen.dart';
import 'package:riverpod_provider_eg/screens/filters_screen.dart';
import 'package:riverpod_provider_eg/screens/meal_%20screen.dart';
import 'package:riverpod_provider_eg/widgets/main_drawer.dart';

import '../providers/filter_provider.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

//Drawer click
  _setScreen(String identifier) async {
    //To close the drawer
    Navigator.of(context).pop();
    if (identifier == "filters") {
      await Navigator.of(context).push<Map<Filter, bool>>(
          MaterialPageRoute(builder: (ctx) => const FilterScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealProvider);
    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    String activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      final favMeal = ref.watch(favMealProvider);

      activePage = MealsScreen(meals: favMeal);
      activePageTitle = "Your favorites";
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      drawer: MainDrawer(
        onSelectedScreen: _setScreen,
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedPageIndex,
          onTap: _selectPage,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: "Favourites"),
          ]),
    );
  }
}
