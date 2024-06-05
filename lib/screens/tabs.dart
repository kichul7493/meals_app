import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters.dart';
import 'package:meals_app/screens/meals.dart';
import 'package:meals_app/widgets/main_drawer.dart';

class Tabs extends StatefulWidget {
  const Tabs({super.key});

  @override
  State<Tabs> createState() => _TabsState();
}

class _TabsState extends State<Tabs> {
  var _selectedPageIndex = 0;
  var _filters = {
    Filter.gluten: false,
    Filter.lactose: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();

    if (identifier == "Settings") {
      final result = await Navigator.of(context)
          .push<Map<Filter, bool>>(MaterialPageRoute(builder: (context) {
        return Filters(filters: _filters);
      }));
      setState(() {
        if (result != null) {
          _filters = result;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(filters: _filters);
    String pageTitle = "Categories";

    if (_selectedPageIndex == 1) {
      pageTitle = "Favourites";
      activePage = const MealScreen(meals: []);
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
