import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_navigation/app.dart';
import 'package:new_navigation/recipes/provider.dart';
import 'package:new_navigation/routing/stack.dart';

class Recipes extends ConsumerWidget {
  const Recipes({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final recipes = watch(recipesProvider);

    return Container(
        child: ListView.separated(
      itemBuilder: (context, index) {
        final recipe = recipes[index];
        return ListTile(
          title: Text(recipe.name),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            context.read(navigationStackProvider).push(NavigationStackItem.recipe(id: recipe.id));
          },
        );
      },
      separatorBuilder: (context, index) => Divider(height: 0),
      itemCount: recipes.length,
    ));
  }
}
