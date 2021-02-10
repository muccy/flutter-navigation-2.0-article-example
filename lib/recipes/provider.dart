import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:new_navigation/recipes/model.dart';

final recipesProvider = Provider((ref) => [
      Recipe(
        id: "1",
        name: "Tomato Sauce Spaghetti",
        ingredientIds: ["1", "2", "3"],
      )
    ]);
