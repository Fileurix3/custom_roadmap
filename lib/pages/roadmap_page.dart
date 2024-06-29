import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:flutter/material.dart';

class RoadmapPage extends StatefulWidget {
  const RoadmapPage({super.key});

  @override
  State<RoadmapPage> createState() => _RoadmapPageState();
}

class _RoadmapPageState extends State<RoadmapPage> {
  Future<List<CustomRoadmapModel>>? roadmap;
  final customRoadmapServices = CustomRoadmapServices();

  late String roadmapName;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    roadmapName = ModalRoute.of(context)!.settings.arguments as String;
    fetchRoadmap();
  }

  Future<void> fetchRoadmap() async {
    setState(() {
      roadmap = customRoadmapServices.getRoadmapByName(roadmapName);
    });
  }

  void _updateIsCompleted(int id, int isCompleted) async {
    await customRoadmapServices.updateIsCompleted(id, isCompleted);
    fetchRoadmap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          roadmapName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: FutureBuilder<List<CustomRoadmapModel>>(
        future: roadmap,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.hasError.toString()));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value:
                          snapshot.data![index].isCompleted == 0 ? false : true,
                      onChanged: (value) {
                        if (value == true) {
                          _updateIsCompleted(snapshot.data![index].id, 1);
                        } else {
                          _updateIsCompleted(snapshot.data![index].id, 0);
                        }
                      },
                    ),
                    Text(
                      "${snapshot.data![index].idRoadmapElement}: ${snapshot.data![index].roadmapElement}",
                      style: snapshot.data![index].isCompleted == 1
                          ? Theme.of(context).textTheme.titleMedium
                          : Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 10),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.edit),
                    )
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }
}
