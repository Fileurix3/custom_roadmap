import 'package:flutter/material.dart';

class ViewingRoadmapElement extends StatelessWidget {
  final String roadmapElement;
  final String description;

  const ViewingRoadmapElement({
    super.key,
    required this.roadmapElement,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text(
            roadmapElement,
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Text(
            description,
            style: Theme.of(context).textTheme.labelMedium,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
