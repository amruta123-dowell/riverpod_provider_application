import 'package:riverpod/riverpod.dart';
import 'package:riverpod_provider_eg/providers/meal_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });
  void setFilter(Filter filter, bool isActive) {
    state = {...state, filter: isActive};
  }

  ///Update the value of the filter settings
  void setFiltersToProvider(Map<Filter, bool> currentValue) {
    state = currentValue;
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filteredMealProvider = Provider((ref) {
  final meals = ref.watch(mealProvider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    } else if (activeFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    } else if (activeFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    } else if (activeFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    } else {
      return true;
    }
  }).toList();
});
