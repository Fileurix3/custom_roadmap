class CustomRoadmapModel {
  int id;
  String roadmapName;
  int? idRoadmapElement;
  String? roadmapElement;
  String? description;
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
