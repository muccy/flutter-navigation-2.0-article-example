import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:new_navigation/app_sections/model.dart';
import 'package:new_navigation/routing/stack.dart';

abstract class _Keys {
  _Keys._();
  static const appSection = "section";
  static const ingredient = "ingredient";
  static const recipe = "recipe";
}

class MainRouterInformationParser extends RouteInformationParser<NavigationStack> {
  final bool Function(String id) isValidIngredientId;
  final bool Function(String id) isValidRecipeId;

  MainRouterInformationParser({@required this.isValidIngredientId, @required this.isValidRecipeId});

  @override
  Future<NavigationStack> parseRouteInformation(RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location);

    final items = <NavigationStackItem>[];
    for (var i = 0, j = 1; i < uri.pathSegments.length && j < uri.pathSegments.length; i = i + 2, j = j + 2) {
      final key = uri.pathSegments[i];
      final value = uri.pathSegments[j];

      switch (key) {
        case _Keys.appSection:
          if (AppSection.validIds.contains(value)) {
            items.add(NavigationStackItem.appSection(id: value));
          } else {
            items.add(NavigationStackItem.notFound());
          }
          break;
        case _Keys.ingredient:
          if (isValidIngredientId(value)) {
            items.add(NavigationStackItem.ingredient(id: value));
          } else {
            items.add(NavigationStackItem.notFound());
          }
          break;
        case _Keys.recipe:
          if (isValidRecipeId(value)) {
            items.add(NavigationStackItem.recipe(id: value));
          } else {
            items.add(NavigationStackItem.notFound());
          }
          break;
        default:
          items.add(NavigationStackItem.notFound());
      }
    } // for

    if (items.isEmpty || items.first is! NavigationStackItemAppSection) {
      final fallback = NavigationStackItem.appSection(id: AppSection.ingredients().id);
      if (items.isNotEmpty && items.first is NavigationStackItemNotFound) {
        items[0] = fallback;
      } else {
        items.insert(0, fallback);
      }
    }

    return NavigationStack(items);
  }

  @override
  RouteInformation restoreRouteInformation(NavigationStack configuration) {
    final location = configuration.items.fold<String>("", (previousValue, element) {
      return previousValue +
          element.when(
            notFound: () => "",
            appSection: (id) => "/${_Keys.appSection}/$id",
            ingredient: (id) => "/${_Keys.ingredient}/$id",
            recipe: (id) => "/${_Keys.recipe}/$id",
          );
    });
    return RouteInformation(location: location);
  }
}
