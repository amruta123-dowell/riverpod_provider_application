import 'package:flutter/material.dart';
import 'package:riverpod_provider_eg/providers/meal_provider.dart';

import 'package:riverpod_provider_eg/screens/categories_screen.dart';
import 'package:riverpod_provider_eg/screens/filters_screen.dart';
import 'package:riverpod_provider_eg/screens/meal_%20screen.dart';
import 'package:riverpod_provider_eg/widgets/main_drawer.dart';

import '../model/meal.dart';

const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _TabScreenState();
  }
}

class _TabScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favMeals = [];
  Map<Filter, bool> _selectedFilters = kInitialFilters;
  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  void _toggleMealFavStatus(Meal meal) {
    final isExisting = _favMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favMeals.remove(meal);
        _showInfoMessage("Item is removed from favorites....");
      });
    } else {
      setState(() {
        _favMeals.add(meal);
        _showInfoMessage("Item is added to favorites...");
      });
    }
    setState(() {
      _favMeals;
    });
  }

//Drawer click
  _setScreen(String identifier) async {
    //To close the drawer
    Navigator.of(context).pop();
    if (identifier == "filters") {
      final result =
          await Navigator.of(context).push<Map<Filter, bool>>(MaterialPageRoute(
              builder: (ctx) => FilterScreen(
                    selectedFilterState: _selectedFilters,
                  )));
      setState(() {
        _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = mealProvider.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      } else if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      } else if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      } else if (_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      } else {
        return true;
      }
    }).toList();
    Widget activePage = CategoriesScreen(
      onToggleFav: _toggleMealFavStatus,
      availableMeals: availableMeals,
    );
    String activePageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
          meals: _favMeals, onToggleFavorites: _toggleMealFavStatus);
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
