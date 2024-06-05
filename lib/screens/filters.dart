import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_provider.dart';
import 'package:meals_app/widgets/meal_filter.dart';

class Filters extends ConsumerStatefulWidget {
  const Filters({super.key});

  @override
  ConsumerState<Filters> createState() => _FiltersState();
}

class _FiltersState extends ConsumerState<Filters> {
  @override
  Widget build(BuildContext context) {
    final filters = ref.watch(filtersProvider);
    final setFilter = ref.read(filtersProvider.notifier).setFilter;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Filters"),
      ),
      body: PopScope(
        canPop: false,
        onPopInvoked: (didPop) {
          if (didPop) return;

          Navigator.of(context).pop();
        },
        child: Column(
          children: [
            MealFilter(
              filterSet: filters[Filter.glutenFree]!,
              onChanged: (value) {
                setFilter(Filter.glutenFree, value);
              },
              title: "Gluten",
              subtitle: "Only include gluten-free meals.",
            ),
            MealFilter(
                filterSet: filters[Filter.lactoseFree]!,
                onChanged: (value) {
                  setFilter(Filter.lactoseFree, value);
                },
                title: "Lactose",
                subtitle: "Only include lactose-free meals."),
            MealFilter(
              filterSet: filters[Filter.vegetarian]!,
              onChanged: (value) {
                setFilter(Filter.vegetarian, value);
              },
              title: "Vegetarian",
              subtitle: "Only include vegetarian meals.",
            ),
            MealFilter(
              filterSet: filters[Filter.vegan]!,
              onChanged: (value) {
                setFilter(Filter.vegan, value);
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
