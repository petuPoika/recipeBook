import 'package:flutter/material.dart';
import '../database/database.dart';

class RecipeDetailScreen extends StatelessWidget {
  final AppDatabase db;
  final Recipe? recipe;
  const RecipeDetailScreen({super.key, required this.db, this.recipe});

  @override
  Widget build(BuildContext context) {
    final isNew = recipe == null;
    return Scaffold(
      appBar: AppBar(title: Text(isNew ? "Uusi resepti" : recipe!.title)),
      body: Center(
        child: Text(isNew ? "Not impelemnted" : "Reseptin tiedot"),
      ),
    );
  }
}