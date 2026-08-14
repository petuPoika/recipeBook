import 'package:flutter/material.dart';
import '../database/database.dart';

class RecipeListScreen extends StatelessWidget {
  final AppDatabase db;
  const RecipeListScreen({super.key, required this.db}); // getting database connection, not many connections

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("Reseptit")),
      body: StreamBuilder<List<Recipe>>(
        stream: db.watchAllRecipes(),
        builder: (context, snapshot){
          // if stream fails
          if (snapshot.hasError){
            return Center (child: Text("Virhe ${snapshot.error}"));
          }// if
          // Shows loading icon during database query
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          } // if
          

          final recipes = snapshot.data!; // snapshot.data not null
          // if user has no recipes show info text
          if (recipes.isEmpty){
            return const Center(child: Text("Et ole lisännyt yhtään reseptiä"));
          } // if

          // separeted only shows recipes that fit in screen, better performance
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: recipes.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            // called when new recipe row appears to screen
            itemBuilder: (context, index){
              final recipe = recipes[index];
              return Text(recipe.title);
            },
          );
        },
      ),
    );
  } //build
} //StatelessWidget