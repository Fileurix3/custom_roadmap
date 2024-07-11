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

  CustomRoadmapModel copyWith({
    int? id,
    String? roadmapName,
    int? idRoadmapElement,
    String? roadmapElement,
    String? description,
    int? isCompleted,
  }) {
    return CustomRoadmapModel(
      id: id ?? this.id,
      roadmapName: roadmapName ?? this.roadmapName,
      idRoadmapElement: idRoadmapElement ?? this.idRoadmapElement,
      roadmapElement: roadmapElement ?? this.roadmapElement,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
