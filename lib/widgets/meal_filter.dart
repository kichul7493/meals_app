import 'package:flutter/material.dart';

class MealFilter extends StatelessWidget {
  const MealFilter(
      {super.key,
      required this.filterSet,
      required this.onChanged,
      required this.title,
      required this.subtitle});

  final bool filterSet;

  final Function(bool value) onChanged;

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return SwitchListTile(
      value: filterSet,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context)
            .textTheme
            .labelMedium!
            .copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
    );
  }
}
