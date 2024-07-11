import 'package:custom_roadmap/bloc/roadmap%20element/roadmap_element_state.dart';
import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:custom_roadmap/widgets/edit_roadmap_element.dart';
import 'package:custom_roadmap/widgets/viewing_roadmap_element.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AboutRoadmapElementPage extends StatefulWidget {
  const AboutRoadmapElementPage({super.key});

  @override
  State<AboutRoadmapElementPage> createState() =>
      _AboutRoadmapElementPageState();
}

class _AboutRoadmapElementPageState extends State<AboutRoadmapElementPage> {
  Future<List<CustomRoadmapModel>>? roadmapElement;
  final customRoadmapServices = CustomRoadmapServices();

  bool isEdit = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<RoadmapElementCubit>().fetchRoadmapElement(
          ModalRoute.of(context)!.settings.arguments as int,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                isEdit = !isEdit;
              });
            },
            icon: isEdit == false
                ? const Icon(Icons.edit)
                : const Icon(Icons.close),
          )
        ],
      ),
      body: BlocBuilder<RoadmapElementCubit, RoadmapElementState>(
          builder: (context, state) {
        if (state is RoadmapElementLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RoadmapElementError) {
          return Center(child: Text(state.message));
        } else if (state is RoadmapElementLoaded) {
          return Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (isEdit == false)
                  ViewingRoadmapElement(
                    roadmapElement: state.roadmapElement[0].roadmapElement,
                    description: state.roadmapElement[0].description,
                  )
                else if (isEdit == true)
                  Expanded(
                    child: EditRoadmapElement(
                      id: state.roadmapElement[0].id,
                      idRoadmapElement:
                          state.roadmapElement[0].idRoadmapElement,
                      roadmapElement: state.roadmapElement[0].roadmapElement,
                      description: state.roadmapElement[0].description,
                    ),
                  )
              ],
            ),
          );
        }
        return const Text("error");
      }),
    );
  }
}
