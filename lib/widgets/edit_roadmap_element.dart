import 'package:custom_roadmap/bloc/roadmap%20element/roadmap_element_state.dart';
import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditRoadmapElement extends StatefulWidget {
  final int id;
  final String roadmapElement;
  final String description;

  const EditRoadmapElement({
    super.key,
    required this.id,
    required this.roadmapElement,
    required this.description,
  });

  @override
  State<EditRoadmapElement> createState() => _EditRoadmapElementState();
}

class _EditRoadmapElementState extends State<EditRoadmapElement> {
  Future<List<CustomRoadmapModel>>? roadmapElement;
  final customRoadmapServices = CustomRoadmapServices();

  TextEditingController roadmapElementNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    roadmapElementNameController.text = widget.roadmapElement;
    descriptionController.text = widget.description;
  }

  void updateRoadmapElement(String name, String description, int id) async {
    await customRoadmapServices.updateRoadmapElement(
      id,
      name,
      description,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Column(
                  children: [
                    TextField(
                      controller: roadmapElementNameController,
                      decoration: const InputDecoration(
                        hintText: "name",
                      ),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                      maxLength: 50,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "description",
                      ),
                      style: Theme.of(context).textTheme.labelMedium,
                      maxLines: null,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  onPressed: () {
                    context
                        .read<RoadmapElementCubit>()
                        .deleteRoadmapElement(widget.id);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    foregroundColor: WidgetStateProperty.all<Color>(
                      Colors.white,
                    ),
                    backgroundColor: WidgetStateProperty.all<Color>(
                      Theme.of(context).colorScheme.error,
                    ),
                  ),
                  child: const Icon(Icons.delete),
                ),
              ),
              const SizedBox(width: 6),
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  onPressed: () {
                    context.read<RoadmapElementCubit>().updateRoadmapElement(
                          roadmapElementNameController.text,
                          descriptionController.text,
                          widget.id,
                        );
                    Navigator.pop(context);
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
