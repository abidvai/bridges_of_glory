import 'package:flutter/material.dart';


class DetailInfoText extends StatelessWidget {
  final String title;
  final String value;

  const DetailInfoText({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$title: ', style: Theme.of(context).textTheme.bodyLarge),
        SizedBox(width: 2),
        Expanded(child: Text(value)),
      ],
    );
  }
}
