part of './roadmap_element_state.dart';

class RoadmapElementCubit extends Cubit<RoadmapElementState> {
  final CustomRoadmapServices customRoadmapServices = CustomRoadmapServices();

  RoadmapElementCubit() : super(RoadmapElementState());

  void fetchRoadmapElement(int id) async {
    emit(RoadmapElementLoading());
    try {
      final List<CustomRoadmapModel> roadmapElement =
          await customRoadmapServices.getRoadmapElementById(id);
      emit(RoadmapElementLoaded(roadmapElement));
    } catch (e) {
      emit(RoadmapElementError(e.toString()));
    }
  }

  void updateRoadmapElement(String name, String description, int id) async {
    emit(RoadmapElementLoading());
    try {
      await customRoadmapServices.updateRoadmapElement(
        id,
        name,
        description,
      );
      fetchRoadmapElement(id);
    } catch (e) {
      emit(RoadmapElementError(e.toString()));
    }
  }

  void deleteRoadmapElement(int id) async {
    emit(RoadmapElementLoading());
    try {
      await customRoadmapServices.deleteRoadmapElement(id);
      fetchRoadmapElement(id);
    } catch (e) {
      emit(RoadmapElementError(e.toString()));
    }
  }
}
