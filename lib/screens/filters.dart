import 'package:flutter/material.dart';
import 'package:meals_app/widgets/meal_filter.dart';

enum Filter {
  gluten,
  lactose,
  vegetarian,
  vegan,
}

class Filters extends StatefulWidget {
  const Filters({super.key, required this.filters});

  final Map<Filter, bool> filters;

  @override
  State<Filters> createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();

    _glutenFreeFilterSet = widget.filters[Filter.gluten] ?? false;
    _lactoseFreeFilterSet = widget.filters[Filter.lactose] ?? false;
    _vegetarianFilterSet = widget.filters[Filter.vegetarian] ?? false;
    _veganFilterSet = widget.filters[Filter.vegan] ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;

          Navigator.of(context).pop({
            Filter.gluten: _glutenFreeFilterSet,
            Filter.lactose: _lactoseFreeFilterSet,
            Filter.vegetarian: _vegetarianFilterSet,
            Filter.vegan: _veganFilterSet,
          });
        },
        child: Column(
          children: [
            MealFilter(
              filterSet: _glutenFreeFilterSet,
              onChanged: (value) {
                setState(() {
                  _glutenFreeFilterSet = value;
                });
              },
              title: "Gluten",
              subtitle: "Only include gluten-free meals.",
            ),
            MealFilter(
                filterSet: _lactoseFreeFilterSet,
                onChanged: (value) {
                  setState(() {
                    _lactoseFreeFilterSet = value;
                  });
                },
                title: "Lactose",
                subtitle: "Only include lactose-free meals."),
            MealFilter(
              filterSet: _vegetarianFilterSet,
              onChanged: (value) {
                setState(() {
                  _vegetarianFilterSet = value;
                });
              },
              title: "Vegetarian",
              subtitle: "Only include vegetarian meals.",
            ),
            MealFilter(
              filterSet: _veganFilterSet,
              onChanged: (value) {
                setState(() {
                  _veganFilterSet = value;
                });
              },
              title: "Vegan",
              subtitle: "Only include vegan meals.",
            ),
          ],
        ),
      ),
    );
  }
}
