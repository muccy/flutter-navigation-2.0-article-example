import 'package:flutter/material.dart';
import 'package:new_navigation/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_navigation/ingredients/provider.dart';
import 'package:new_navigation/routing/stack.dart';

class Ingredients extends ConsumerWidget {
  const Ingredients({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final ingredients = watch(ingredientsProvider);

    return Container(
        child: ListView.separated(
      itemBuilder: (_, index) {
        final ingredient = ingredients[index];
        return ListTile(
          title: Text(ingredient.name),
          trailing: Icon(Icons.chevron_right),
          onTap: () {
            final gne = context.read(navigationStackProvider);
            gne.push(NavigationStackItem.ingredient(id: ingredient.id));
          },
        );
      },
      separatorBuilder: (context, index) => Divider(height: 0),
      itemCount: ingredients.length,
    ));
  }
}
