import 'package:cackeapp/ui/styles/app_styles.dart';
import 'package:flutter/material.dart';

class CategoryChip extends StatefulWidget {
  final String lable;
  final bool isSelected;
  final Function() statuschange;
  const CategoryChip(
      {super.key,
      required this.lable,
      required this.statuschange,
      required this.isSelected});

  @override
  State<CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<CategoryChip> {
  @override
  Widget build(BuildContext context) {
    return ChoiceChip(
      selected: widget.isSelected,
      labelPadding: const EdgeInsets.all(2.0),
      avatar: CircleAvatar(
        backgroundColor: kPrimaryColorlight,
        child: Text(widget.lable[0].toUpperCase(),
            style: const TextStyle(color: kPrimaryColordark)),
      ),
      label: Text(
        widget.lable,
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: kPrimaryColordark.withOpacity(0.8),
      elevation: 6.0,
      shadowColor: Colors.orange.shade100,
      padding: const EdgeInsets.all(8.0),
      selectedColor: Colors.orange.shade800,
      onSelected: (value) {
        widget.statuschange();
      },
    );
  }
}
