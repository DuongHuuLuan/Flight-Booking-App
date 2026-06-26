import 'package:flutter/material.dart';

class HorizontalChipList extends StatelessWidget {
  final List<Widget> chips;
  final double height;
  final double spacing;

  const HorizontalChipList({
    super.key,
    required this.chips,
    this.height = 40,
    this.spacing = 8,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: chips.length,
        separatorBuilder: (_, __) => SizedBox(width: spacing),
        itemBuilder: (_, index) => chips[index],
      ),
    );
  }
}
