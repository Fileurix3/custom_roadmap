class CustomRoadmapModel {
  int id;
  String roadmapName;
  int idRoadmapElement;
  String roadmapElement;
  String description;
  int isCompleted;

  CustomRoadmapModel({
    required this.id,
    required this.roadmapName,
    required this.idRoadmapElement,
    required this.roadmapElement,
    required this.description,
    required this.isCompleted,
  });
}

class CustomRoadmapModel2 {
  final String roadmapName;
  final int totalItems;
  final int completedItems;

  CustomRoadmapModel2({
    required this.roadmapName,
    required this.totalItems,
    required this.completedItems,
  });
}
