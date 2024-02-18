import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/meal.dart';

class FavoriteMealNotifier extends StateNotifier<List<Meal>> {
  FavoriteMealNotifier() : super([]);
  bool toggleFavItems(Meal meal) {
    //check  meal present or not. If present, create list without exist meal else add meal in the list
    final isMealPresent = state.contains(meal);
    if (isMealPresent) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favMealProvider = StateNotifierProvider<FavoriteMealNotifier, List<Meal>>(
    (ref) => FavoriteMealNotifier());
