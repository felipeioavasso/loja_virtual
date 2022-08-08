import 'package:flutter/material.dart';

import '../../../models/section.dart';

class SectionHeader extends StatelessWidget {

  // ignore: use_key_in_widget_constructors
  const SectionHeader(this.section);
  final Section? section;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        section!.name!,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 18,
        ),
      ),
    );
  }
}