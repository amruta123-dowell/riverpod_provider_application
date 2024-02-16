import 'package:riverpod/riverpod.dart';
import 'package:riverpod_provider_eg/data/dummy_data.dart';

final mealProvider = Provider((ref) => dummyMeals);
