import 'package:drift/drift.dart' show Value;
import 'package:flutter/material.dart';
import '../database/database.dart';

class RecipeDetailScreen extends StatefulWidget {
  final AppDatabase db;
  final Recipe? recipe;
  const RecipeDetailScreen({super.key, required this.db, this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}


class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  // these get controller in initstate()
  late TextEditingController titleController;
  late TextEditingController servingsController;
  late TextEditingController prepTimeController;

  @override
  void initState(){
    super.initState();

    /* Add existing information or empty to controllers*/
    titleController = TextEditingController(text: widget.recipe?.title ?? '');

    servingsController = TextEditingController(text: widget.recipe?.servings.toString() ?? '');

    prepTimeController = TextEditingController(text: widget.recipe?.prepTimeMinutes.toString() ?? '');
  } //initstate

  /* Free up resources from controllers */
  @override
  void dispose() {
    titleController.dispose();
    servingsController.dispose();
    prepTimeController.dispose();

    super.dispose();

  } //dispose

  Future<void> saveRecipe() async {
    final title = titleController.text.trim(); // trim taxes extra spaces from beginning or end
    final servings = int.tryParse(servingsController.text); // textfield string, try parse as int
    final prepTime = int.tryParse(prepTimeController.text); // textfield string, try parse as int

    // user must give name
    if (title.isEmpty){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Anna reseptin nimi"),
          ), 
      );
      return;
    } //if

    await widget.db.addRecipe(
      RecipesCompanion.insert(
        title: title,
        servings: Value(servings),
        prepTimeMinutes: Value(prepTime),
      ),
    );

    // if this view is already deleted
    if (!mounted) return;

    Navigator.pop(context);

  } //saveRecipe


  @override
  Widget build(BuildContext context) {
    final isNew = widget.recipe == null; // to handle adding new or editing existing recipe

    return Scaffold(
      appBar: AppBar(title: Text(isNew ? "Uusi resepti" : widget.recipe!.title)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Perustiedot",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: "Reseptin nimi",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: servingsController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Annostenmäärä",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: prepTimeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Valmistusaika (minuuteissa)",
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 32),

            const Text(
              "Ainesosat",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: saveRecipe,
                child: const Text("Tallenna"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}