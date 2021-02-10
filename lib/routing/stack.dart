import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'stack.freezed.dart';

class NavigationStack with ChangeNotifier {
  List<NavigationStackItem> _items;
  NavigationStack(List<NavigationStackItem> items) : _items = List.of(items) ?? [];

  UnmodifiableListView<NavigationStackItem> get items => UnmodifiableListView(_items);
  set items(List<NavigationStackItem> newItems) {
    _items = List.from(newItems ?? []);
    notifyListeners();
  }

  void push(NavigationStackItem item) {
    _items.add(item);
    notifyListeners();
  }

  NavigationStackItem pop() {
    try {
      final poppedItem = _items.removeLast();
      notifyListeners();
      return poppedItem;
    } catch (e) {
      return null;
    }
  }
}

@freezed
abstract class NavigationStackItem with _$NavigationStackItem {
  const factory NavigationStackItem.notFound() = NavigationStackItemNotFound;
  const factory NavigationStackItem.appSection({@required String id}) = NavigationStackItemAppSection;
  const factory NavigationStackItem.ingredient({@required String id}) = NavigationStackItemIngredient;
  const factory NavigationStackItem.recipe({@required String id}) = NavigationStackItemRecipe;
}
