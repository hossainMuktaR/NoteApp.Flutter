import 'package:flutter/material.dart';

class DefaultRadioButton extends StatelessWidget {
  final String text;
  final bool selected;
  final VoidCallback onSelect;

  const DefaultRadioButton({
    super.key,
    required this.text,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Row(
        children: [
          Radio(
            value: selected,
            groupValue: true,
            onChanged: (_) => onSelect(),
          ),
          Text(text),
        ],
      ),
    );
  }
}