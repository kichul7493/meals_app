import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_gird_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.filters});

  final Map<Filter, bool> filters;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = dummyMeals.where((meal) {
      var isGlutenFree = filters[Filter.gluten] ?? false;
      var isLactoseFree = filters[Filter.lactose] ?? false;
      var isVegetarian = filters[Filter.vegetarian] ?? false;
      var isVegan = filters[Filter.vegan] ?? false;

      if (isGlutenFree && !meal.isGlutenFree) {
        return false;
      }

      if (isLactoseFree && !meal.isLactoseFree) {
        return false;
      }

      if (isVegetarian && !meal.isVegetarian) {
        return false;
      }

      if (isVegan && !meal.isVegan) {
        return false;
      }

      return meal.categories.contains(category.id);
    }).toList();

    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return MealScreen(title: category.title, meals: filteredMeals);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGirdItem(
              category: category,
              onSelectCategory: () {
                _selectCategory(context, category);
              })
      ],
    );
  }
}
