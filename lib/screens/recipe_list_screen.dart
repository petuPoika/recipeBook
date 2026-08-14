import 'package:flutter/material.dart';
import '../database/database.dart';

class RecipeListScreen extends StatelessWidget {
  final AppDatabase db;
  const RecipeListScreen({super.key, required this.db}); // getting database connection, not many connections

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Reseptit")),
      body: const Center(child: Text("Lista")),
    );
  } //build
} //StatelessWidget