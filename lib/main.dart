import 'package:flutter/material.dart';
import 'database/database.dart';
import 'screens/recipe_list_screen.dart';

void main() {
  final db = AppDatabase();
  runApp(RecipeApp(db: db));
} //main

class RecipeApp extends StatelessWidget {
  final AppDatabase db;
  const RecipeApp({super.key, required this.db});

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: "Reseptit",
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepOrange),
      home: RecipeListScreen(db: db),
    );
  } //build
} //RecipeApp