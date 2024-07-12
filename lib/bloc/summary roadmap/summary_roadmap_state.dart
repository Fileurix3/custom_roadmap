import 'package:custom_roadmap/model/summary_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'summary_roadmap_cubit.dart';

class SummaryRoadmapState {}

class SummaryRoadmapLoading extends SummaryRoadmapState {}

class SummaryRoadmapLoaded extends SummaryRoadmapState {
  final List<SummaryRoadmapModel> roadmap;

  SummaryRoadmapLoaded(this.roadmap);
}

class SummaryRoadmapError extends SummaryRoadmapState {
  final String message;

  SummaryRoadmapError(this.message);
}
