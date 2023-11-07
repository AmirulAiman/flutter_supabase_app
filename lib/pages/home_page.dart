import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_supabase_app/components/dialog_form.dart';
import 'package:flutter_supabase_app/components/todo_item.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _todoStream = Supabase.instance.client.from("my_todos").stream(
    primaryKey: ['id'],
  );

  final _controller = TextEditingController();

  void onSave() async {
    await Supabase.instance.client.from('my_todos').insert(
      {'task': _controller.text, 'is_completed': false},
    ).then(
      (value) => Navigator.of(context).pop(),
    );
    _controller.clear();
  }

  void functionShowDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogForm(
          controller: _controller,
          onSaveCallback: () => onSave(),
          onCancelCallback: () => Navigator.of(context).pop(),
        );
      },
    );
  }

  void onTaskCompleted(dynamic todo) async {
    await Supabase.instance.client.from("my_todos").update(
      {"is_completed": !todo['is_completed']},
    ).match(
      {'id': todo['id']},
    );
  }

  void onTaskDeleted(int id) async {
    await Supabase.instance.client
        .from('my_todos')
        .delete()
        .match({'id': id}).then((value) => null);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text(
          "Flutter Supabase App",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black54,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: StreamBuilder<List<Map<String, dynamic>>>(
          stream: _todoStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              final todos = snapshot.data;
              return ListView.builder(
                  itemCount: todos?.length,
                  itemBuilder: (context, index) {
                    return TodoItem(
                      task: todos?[index]['task'],
                      isCompleted: todos?[index]['is_completed'],
                      onCheckboxChange: (context) =>
                          onTaskCompleted(todos?[index]),
                      onDeleteCallback: (context) =>
                          onTaskDeleted(todos?[index]['id']),
                    );
                  });
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () => functionShowDialog(),
          child: const Icon(Icons.add)),
    );
  }
}
