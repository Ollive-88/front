import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ollive_front/models/user/user_model.dart';

class FridgeInventoryScreen extends StatefulWidget {
  const FridgeInventoryScreen({super.key});

  @override
  State<FridgeInventoryScreen> createState() => _FridgeInventoryScreenState();
}

class _FridgeInventoryScreenState extends State<FridgeInventoryScreen> {
  List<UserIngredients> ingredients = UserIngredientsList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('냉장고 관리'),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 50,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: ingredients.length,
                itemBuilder: (context, index) {
                  final ingredient = ingredients[index];
                  return Slidable(
                    endActionPane:
                        ActionPane(motion: const BehindMotion(), children: [
                      SlidableAction(
                        backgroundColor: Colors.red,
                        label: '삭제',
                        onPressed: (context) => _onDismissed(),
                      ),
                    ]),
                    child: buildIngredientListTitle(ingredient),
                  );
                }),
          )
        ],
      ),
    );
  }
}

void _onDismissed() {}

Widget buildIngredientListTitle(UserIngredients ingredient) => ListTile(
      contentPadding: const EdgeInsets.all(8.0),
      leading: Text(ingredient.ingredientName),
      trailing: Text(ingredient.expirationDate),
    );
