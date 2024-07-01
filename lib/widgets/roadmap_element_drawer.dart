import 'package:custom_roadmap/widgets/roadmap%20element/edit_roadmap_element.dart';
import 'package:custom_roadmap/widgets/roadmap%20element/viewing_roadmap_element.dart';
import 'package:flutter/material.dart';
import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';

class RoadmapElementDrawer extends StatefulWidget {
  final int? itemId;

  const RoadmapElementDrawer({super.key, this.itemId});

  @override
  State<RoadmapElementDrawer> createState() => _RoadmapElementDrawerState();
}

class _RoadmapElementDrawerState extends State<RoadmapElementDrawer> {
  Future<List<CustomRoadmapModel>>? roadmapElement;
  final customRoadmapServices = CustomRoadmapServices();

  bool isEdit = false;

  @override
  void initState() {
    super.initState();
    _getRoadmapElementById();
  }

  Future<void> _getRoadmapElementById() async {
    roadmapElement =
        customRoadmapServices.getRoadmapElementById(widget.itemId!);
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      child: FutureBuilder<List<CustomRoadmapModel>>(
        future: roadmapElement,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No data available'));
          } else {
            return Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                          "Completed: ${snapshot.data![0].isCompleted == 1 ? true : false}"),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isEdit = !isEdit;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          size: MediaQuery.of(context).size.width / 15,
                        ),
                      )
                    ],
                  ),
                  if (isEdit == false)
                    ViewingRoadmapElement(
                      idRoadmapElement: snapshot.data![0].idRoadmapElement,
                      roadmapElement: snapshot.data![0].roadmapElement,
                      description: snapshot.data![0].description,
                    )
                  else if (isEdit == true)
                    Expanded(
                      child: EditRoadmapElement(
                        id: snapshot.data![0].id,
                        idRoadmapElement: snapshot.data![0].idRoadmapElement,
                        roadmapElement: snapshot.data![0].roadmapElement,
                        description: snapshot.data![0].description,
                      ),
                    )
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
