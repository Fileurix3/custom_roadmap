part of './roadmap_state.dart';

class RoadmapCubit extends Cubit<RoadmapState> {
  final CustomRoadmapServices customRoadmapServices = CustomRoadmapServices();

  RoadmapCubit() : super(RoadmapState());

  void fetchRoadmap(String roadmapName) async {
    emit(RoadmapLoading());
    try {
      final List<CustomRoadmapModel> roadmap =
          await customRoadmapServices.getRoadmapByName(roadmapName);
      emit(RoadmapLoaded(roadmap));
    } catch (e) {
      emit(RoadmapError(e.toString()));
    }
  }

  void addNewRoadmapAndRoadmapElement(
    String roadmapElementName,
    String description,
    String roadmapName,
  ) async {
    emit(RoadmapLoading());
    try {
      await customRoadmapServices.addNewRoadmap(
        roadmapName,
        roadmapElementName,
        description,
      );
      fetchRoadmap(roadmapName);
    } catch (e) {
      emit(RoadmapError(e.toString()));
    }
  }

  void updateIsCompleted(int id, int isCompleted) async {
    if (state is RoadmapLoaded) {
      final RoadmapLoaded currentState = state as RoadmapLoaded;
      emit(RoadmapLoading());
      try {
        await customRoadmapServices.updateIsCompleted(id, isCompleted);
        final updatedRoadmap = currentState.roadmap
            .map((element) => element.id == id
                ? element.copyWith(isCompleted: isCompleted)
                : element)
            .toList();
        emit(RoadmapLoaded(updatedRoadmap));
      } catch (e) {
        emit(RoadmapError(e.toString()));
      }
    }
  }
}
