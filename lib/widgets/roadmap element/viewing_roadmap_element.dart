import 'package:flutter/material.dart';

class ViewingRoadmapElement extends StatelessWidget {
  final int idRoadmapElement;
  final String roadmapElement;
  final String description;

  const ViewingRoadmapElement({
    super.key,
    required this.idRoadmapElement,
    required this.roadmapElement,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${idRoadmapElement.toString()}: ",
                style: Theme.of(context).textTheme.titleLarge,
              ),
              Expanded(
                child: Text(
                  roadmapElement,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            description,
            style: Theme.of(context).textTheme.labelMedium,
          ),
        ],
      ),
    );
  }
}
