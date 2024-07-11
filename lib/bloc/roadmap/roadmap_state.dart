import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part './roadmap_cubit.dart';

class RoadmapState {}

class RoadmapLoading extends RoadmapState {}

class RoadmapLoaded extends RoadmapState {
  final List<CustomRoadmapModel> roadmap;

  RoadmapLoaded(this.roadmap);
}

class RoadmapError extends RoadmapState {
  final String message;

  RoadmapError(this.message);
}
