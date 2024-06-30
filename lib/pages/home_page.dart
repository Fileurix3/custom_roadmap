import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<CustomRoadmapModel2>>? roadmapName;
  final customRoadmapServices = CustomRoadmapServices();

  TextEditingController nameRoadmapController = TextEditingController();
  TextEditingController roadamElementController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchRoadmaps();
  }

  Future<void> fetchRoadmaps() async {
    setState(() {
      roadmapName = customRoadmapServices.getRoadmaps();
    });
  }

  void addNewRoadmap(
      String nameRoadmap, String roadmapElement, String description) async {
    await customRoadmapServices.addNewRoadmap(
        nameRoadmap, roadmapElement, description);
    fetchRoadmaps();
  }

  void addNewRoadmapAlert() {
    showDialog(
      context: context,
      builder: (coontext) {
        return AlertDialog(
          title: const Text("Add new roadmap"),
          content: TextField(
            controller: nameRoadmapController,
            decoration: const InputDecoration(labelText: "name"),
            style: Theme.of(context).textTheme.bodyMedium,
            maxLength: 25,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (nameRoadmapController.text.isNotEmpty) {
                  Navigator.pop(context);
                  addNewRoadmapElement(nameRoadmapController.text);
                  nameRoadmapController.clear();
                }
              },
              child: const Center(child: Text("Next")),
            )
          ],
        );
      },
    );
  }

  void addNewRoadmapElement(String nameRoadmap) {
    showDialog(
      context: context,
      builder: (coontext) {
        return AlertDialog(
          title: const Text("First element roadmap"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: roadamElementController,
                decoration:
                    const InputDecoration(labelText: "Roadmap element name"),
                style: Theme.of(context).textTheme.bodyMedium,
                maxLength: 25,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                style: Theme.of(context).textTheme.bodyMedium,
                maxLength: 254,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (roadamElementController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  addNewRoadmap(
                    nameRoadmap,
                    roadamElementController.text,
                    descriptionController.text,
                  );
                  Navigator.pop(context);
                  roadamElementController.clear();
                  descriptionController.clear();
                }
              },
              child: const Center(child: Text("Add")),
            )
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Custom roadmap",
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: FutureBuilder<List<CustomRoadmapModel2>>(
        future: roadmapName,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    hoverColor: Colors.white.withOpacity(0),
                    highlightColor: Colors.grey.withOpacity(0.2),
                    padding: const EdgeInsets.all(0),
                    onPressed: () {
                      addNewRoadmapAlert();
                    },
                    icon: Icon(
                      Icons.add,
                      size: 110,
                      color: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.75)
                          : Colors.black.withOpacity(0.4),
                    ),
                  ),
                  Text(
                    "Add new roadmap",
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
              body: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width / 15,
                      vertical: 10,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10),
                      onTap: () {
                        Navigator.pushNamed(context, "/roadmapPage",
                            arguments: snapshot.data![index].roadmapName);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).cardColor,
                          border: Theme.of(context).colorScheme.brightness ==
                                  Brightness.light
                              ? Border.all(color: Colors.grey)
                              : Border.all(color: Colors.grey.shade700),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Text(
                                snapshot.data![index].roadmapName,
                                style: Theme.of(context).textTheme.labelMedium,
                                textAlign: TextAlign.center,
                              ),
                              Text(
                                "completed: ${((snapshot.data![index].completedItems / snapshot.data![index].totalItems) * 100).toStringAsFixed(1)}%",
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: () {
                  addNewRoadmapAlert();
                },
                child: const Icon(Icons.add),
              ),
            );
          }
        },
      ),
    );
  }
}
