import 'package:flutter/material.dart';
import 'package:flutter_supabase_app/components/button_component.dart';

class DialogForm extends StatelessWidget {
  final controller;
  VoidCallback onSaveCallback;
  VoidCallback onCancelCallback;

  DialogForm({
    super.key,
    required this.controller,
    required this.onSaveCallback,
    required this.onCancelCallback,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      title: const Text("Add Todo Dialog"),
      content: SizedBox(
        height: 100,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextField(
              controller: controller,
              autofocus: true,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: "New todo...",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ButtonComponent(
                  text: "Save",
                  onClickCallback: onSaveCallback,
                ),
                const SizedBox(
                  width: 10,
                ),
                ButtonComponent(
                  text: "Cancel",
                  onClickCallback: onCancelCallback,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
