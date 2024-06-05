import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/meals_provider.dart';

enum Filter { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersProvider extends StateNotifier<Map<Filter, bool>> {
  FiltersProvider()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarian: false,
          Filter.vegan: false,
        });

  void setFilter(Filter filter, bool value) {
    state = Map.from(state)..[filter] = value;
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersProvider, Map<Filter, bool>>(
  (ref) => FiltersProvider(),
);

final filteredMealsProvider = Provider((ref) {
  final filters = ref.watch(filtersProvider);
  final meals = ref.watch(mealsProvider);

  return meals.where((meal) {
    if (filters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if (filters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    if (filters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }

    if (filters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
