import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:flutter/material.dart';

class EditRoadmapElement extends StatefulWidget {
  final int id;
  final int idRoadmapElement;
  final String roadmapElement;
  final String description;

  const EditRoadmapElement({
    super.key,
    required this.id,
    required this.idRoadmapElement,
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

  void updateRoadmapElement(String name, String description) async {
    await customRoadmapServices.updateRoadmapElement(
      widget.id,
      name,
      description,
    );
  }

  void deleteRoadmapElement() async {
    await customRoadmapServices.deleteRoadmapElement(widget.id);
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
                        labelText: "name",
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
                      maxLength: 50,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                        labelText: "description",
                      ),
                      style: Theme.of(context).textTheme.bodyMedium,
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
                    deleteRoadmapElement();
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
                    updateRoadmapElement(
                      roadmapElementNameController.text,
                      descriptionController.text,
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
