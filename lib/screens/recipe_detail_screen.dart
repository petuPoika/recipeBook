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
          ],
        ),
      )
    );
  }
}