import 'package:flutter/material.dart';
import 'package:meals_app/data/dummy_data.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/category_gird_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.meals});

  final List<Meal> meals;

  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = meals.where((meal) {
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
