import 'package:drift/drift.dart';

class Recipes extends Table {
  // with extra parentheses ()() at the end of lines, line will return the Column object
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  IntColumn get servings => integer().withDefault(const Constant(0))();
  IntColumn get prepTimeMinutes => integer().nullable()();
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();
}

class RecipeIngredients extends Table {
  IntColumn get id => integer().autoIncrement()();
  // when recipe is deleted ingredients are deleted
  IntColumn get recipeId => integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  RealColumn get amount => real()();  //real because amount can be 1.5 etc.
  TextColumn get unit => text().nullable()();
  TextColumn get category => text().withDefault(const Constant ('Muu'))();
}

class RecipeSteps extends Table {
  IntColumn get id => integer().autoIncrement()();
  // when recipe is deleted steps on the recipe are deleted
  IntColumn get recipeId => integer().references(Recipes, #id, onDelete: KeyAction.cascade)();
  IntColumn get stepNumber => integer()();
  TextColumn get description => text()();  
}