part of './summary_roadmap_state.dart';

class SummaryRoadmapCubit extends Cubit<SummaryRoadmapState> {
  final CustomRoadmapServices customRoadmapServices = CustomRoadmapServices();
  SummaryRoadmapCubit() : super(SummaryRoadmapState());

  void fetchRoadmaps() async {
    emit(SummaryRoadmapLoading());
    try {
      final List<SummaryRoadmapModel> roadmap =
          await customRoadmapServices.getRoadmaps();
      emit(SummaryRoadmapLoaded(roadmap));
    } catch (e) {
      emit(SummaryRoadmapError(e.toString()));
    }
  }

  void addNewRoadmap(
      String nameRoadmap, String roadmapElement, String description) async {
    emit(SummaryRoadmapLoading());
    try {
      await customRoadmapServices.addNewRoadmap(
          nameRoadmap, roadmapElement, description);
      fetchRoadmaps();
    } catch (e) {
      emit(SummaryRoadmapError(e.toString()));
    }
  }

  void updateNameRoadmap(String currentName, String newName) async {
    emit(SummaryRoadmapLoading());
    try {
      await customRoadmapServices.updateNameRoadmap(currentName, newName);
      fetchRoadmaps();
    } catch (e) {
      emit(SummaryRoadmapError(e.toString()));
    }
  }

  void deleteRoadmap(String name) async {
    emit(SummaryRoadmapLoading());
    try {
      await customRoadmapServices.deleteRoadmapsByName(name);
      fetchRoadmaps();
    } catch (e) {
      emit(SummaryRoadmapError(e.toString()));
    }
  }
}
