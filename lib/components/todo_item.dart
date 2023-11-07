import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class TodoItem extends StatelessWidget {
  final String task;
  final bool isCompleted;
  Function(bool?)? onCheckboxChange;
  Function(BuildContext)? onDeleteCallback;

  TodoItem({
    super.key,
    required this.task,
    required this.isCompleted,
    required this.onCheckboxChange,
    required this.onDeleteCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 8,
        right: 8,
        bottom: 8,
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              borderRadius: BorderRadius.circular(12),
              onPressed: onDeleteCallback,
              icon: Icons.delete,
              backgroundColor: Colors.red,
            )
          ],
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.black,
          ),
          padding: const EdgeInsets.all(8),
          child: Row(
            children: [
              Checkbox(
                value: isCompleted,
                onChanged: onCheckboxChange,
                activeColor: Colors.grey,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                task,
                style: TextStyle(
                  color: Colors.white,
                  decoration: isCompleted
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
