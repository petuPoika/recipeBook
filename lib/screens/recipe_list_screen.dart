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
            itemBuilder: (context, index) => _RecipeCard(recipe: recipes[index]),
          );
        },
      ),
    );
  } //build

} //RecipeListScreen

/* _ makes this class private */
class _RecipeCard extends StatelessWidget {
  final Recipe recipe;
  const _RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    // preptime and if no given it is only -. if else
    final prepTime = recipe.prepTimeMinutes != null
      ? '${recipe.prepTimeMinutes} min'
      : '-';

      return Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Theme.of(context).dividerColor),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondaryContainer,
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.restaurant),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.title,
                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '$prepTime * ${recipe.servings} annosta',
                      style: TextStyle(fontSize: 12, color: Theme.of(context).hintColor),
                    ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, size: 18),
          ],
        ),
      );
  } //build
    
}//_RecipeCard