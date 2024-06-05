import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';

class FavoritesProvider extends StateNotifier<List<Meal>> {
  FavoritesProvider() : super([]);

  bool toggleFavorite(Meal meal) {
    if (state.contains(meal)) {
      state = List.from(state)..remove(meal);
      return false;
    } else {
      state = List.from(state)..add(meal);
      return true;
    }
  }
}

final favoritesProvider = StateNotifierProvider<FavoritesProvider, List<Meal>>(
    (ref) => FavoritesProvider());
