import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meal_detail.dart';
import 'package:meals_app/widgets/meal_item.dart';

class MealScreen extends StatelessWidget {
  const MealScreen({super.key, this.title, required this.meals});

  final String? title;

  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MealDetailScreen(meal: meal)));
  }

  @override
  Widget build(BuildContext context) {
    if (title == null) {
      return meals.isEmpty
          ? Center(
              child: Text("No meals found",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: Colors.white)))
          : ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: MealItem(
                  meal: meals[index],
                  onSelectMeal: () {
                    _selectMeal(context, meals[index]);
                  },
                ),
              ),
              itemCount: meals.length,
            );
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(title!),
        ),
        body: meals.isEmpty
            ? Center(
                child: Text("No meals found",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(color: Colors.white)))
            : ListView.builder(
                itemBuilder: (context, index) => ListTile(
                  title: MealItem(
                    meal: meals[index],
                    onSelectMeal: () {
                      _selectMeal(context, meals[index]);
                    },
                  ),
                ),
                itemCount: meals.length,
              ));
  }
}
