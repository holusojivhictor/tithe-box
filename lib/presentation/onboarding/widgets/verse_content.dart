import 'package:flutter/material.dart';

class VerseContent extends StatelessWidget {
  final String verse;
  final String reading;

  const VerseContent({
    Key? key,
    required this.verse,
    required this.reading,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          verse,
          style: textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold, fontSize: 20),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            reading,
            style: textTheme.bodyMedium!.copyWith(color: Colors.black54),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
