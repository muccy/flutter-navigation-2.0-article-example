import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:new_navigation/ingredients/model.dart';

extension IngredientSearch on List<Ingredient> {
  @nullable
  Ingredient ingredientWithId(String id) => firstWhere((element) => element.id == id, orElse: () => null);
}
