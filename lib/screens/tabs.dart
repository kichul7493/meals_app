import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favorites_provider.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/providers/meals_provider.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class Tabs extends ConsumerStatefulWidget {
  const Tabs({super.key});

  @override
  ConsumerState<Tabs> createState() => _TabsState();
}

class _TabsState extends ConsumerState<Tabs> {
  var _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == "Settings") {
      await Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return const Filters();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);

    final favoriteMeals = ref.watch(favoritesProvider);

    Widget activePage = CategoriesScreen(meals: availableMeals);
    String pageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      pageTitle = "Favourites";
      activePage = MealScreen(meals: favoriteMeals);
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(pageTitle),
        ),
        body: activePage,
        drawer: MainDrawer(_setScreen),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          currentIndex: _selectedPageIndex,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.set_meal), label: "Categories"),
            BottomNavigationBarItem(
                icon: Icon(Icons.star), label: "Favourites"),
          ],
        ));
  }
}
