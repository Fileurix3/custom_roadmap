import 'package:flutter/material.dart';
import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:flutter/widgets.dart';

class RoadmapElementDrawer extends StatefulWidget {
  final int? itemId;

  const RoadmapElementDrawer({super.key, this.itemId});

  @override
  State<RoadmapElementDrawer> createState() => _RoadmapElementDrawerState();
}

class _RoadmapElementDrawerState extends State<RoadmapElementDrawer> {
  Future<List<CustomRoadmapModel>>? roadmapElement;
  final customRoadmapServices = CustomRoadmapServices();

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
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "Completed: ${snapshot.data![index].isCompleted == 1 ? true : false}"),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              size: MediaQuery.of(context).size.width / 15,
                            ),
                          )
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${snapshot.data![index].idRoadmapElement.toString()}: ",
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Expanded(
                            child: Text(
                              snapshot.data![index].roadmapElement,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        snapshot.data![index].description,
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
