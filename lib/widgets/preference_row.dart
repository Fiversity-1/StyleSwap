import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PreferenceRow extends StatefulWidget {
  const PreferenceRow({super.key, required this.category, required this.tags});
  final String category;
  final List<Widget> tags;

  @override
  PreferenceRowState createState() => PreferenceRowState();
}

class PreferenceRowState extends State<PreferenceRow> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 15, left: (15.0), bottom: 15),
          child: Row(
            children: [
              Text(widget.category,
                  style: kIsWeb
                      ? Theme.of(context).textTheme.headlineSmall
                      : Theme.of(context).textTheme.headlineSmall)
            ],
          ),
        ),
        Wrap(spacing: 10, runSpacing: 10, children: widget.tags),
      ],
    );
  }
}
