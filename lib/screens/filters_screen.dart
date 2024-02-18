import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/filter_provider.dart';

class FilterScreen extends ConsumerStatefulWidget {
  const FilterScreen({super.key});

  @override
  ConsumerState<FilterScreen> createState() {
    return _FilterScreenState();
  }
}

class _FilterScreenState extends ConsumerState<FilterScreen> {
  bool _isGlutenFree = false;
  bool _isLactoseFree = false;
  bool _isVegetarian = false;
  bool _isVegan = false;

  @override
  void initState() {
    final activeFilter = ref.read(filterProvider);

    _isGlutenFree = activeFilter[Filter.glutenFree]!;
    _isLactoseFree = activeFilter[Filter.lactoseFree]!;
    _isVegetarian = activeFilter[Filter.vegetarian]!;
    _isVegan = activeFilter[Filter.vegan]!;
    return super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Your Filters"),
        ),
        body: PopScope(
          canPop: false,
          onPopInvoked: (bool didPop) {
            if (didPop) return;
            ref.read(filterProvider.notifier).setFiltersToProvider({
              Filter.glutenFree: _isGlutenFree,
              Filter.lactoseFree: _isLactoseFree,
              Filter.vegetarian: _isVegetarian,
              Filter.vegan: _isVegan
            });
            Navigator.of(context).pop();
          },
          child: Column(
            children: [
              SwitchListTile(
                value: _isGlutenFree,
                onChanged: (value) {
                  setState(() {
                    _isGlutenFree = value;
                  });
                },
                title: Text(
                  "Gluten-free",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Only include gluten-free meals.',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 24),
              ),
              SwitchListTile(
                value: _isLactoseFree,
                onChanged: (value) {
                  setState(() {
                    _isLactoseFree = value;
                  });
                },
                title: Text(
                  "lactose-free",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Only include lactose-free meals.',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 24),
              ),
              SwitchListTile(
                value: _isVegetarian,
                onChanged: (value) {
                  setState(() {
                    _isVegetarian = value;
                  });
                },
                title: Text(
                  "Vegetarian",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Only include vegetarian meals.',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 24),
              ),
              SwitchListTile(
                value: _isVegan,
                onChanged: (value) {
                  setState(() {
                    _isVegan = value;
                  });
                },
                title: Text(
                  "Vegan",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                subtitle: Text(
                  'Only include vegan meals.',
                  style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: Theme.of(context).colorScheme.onBackground),
                ),
                activeColor: Theme.of(context).colorScheme.tertiary,
                contentPadding: const EdgeInsets.only(left: 34, right: 24),
              ),
            ],
          ),
        ));
  }
}
