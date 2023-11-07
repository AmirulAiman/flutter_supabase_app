import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  final String text;
  VoidCallback onClickCallback;

  ButtonComponent({
    super.key,
    required this.text,
    required this.onClickCallback,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onClickCallback,
      color: Colors.black,
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
