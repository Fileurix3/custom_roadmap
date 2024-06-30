import 'package:custom_roadmap/model/roadmap_summary.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<RoadmapSummary>>? roadmapName;
  final customRoadmapServices = CustomRoadmapServices();

  TextEditingController roadmapNameController = TextEditingController();
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

  void newRoadmapName(String currentName, String newName) async {
    await customRoadmapServices.updateNameRoadmap(currentName, newName);
    fetchRoadmaps();
  }

  void deleteRoadmap(String name) async {
    await customRoadmapServices.deleteElementsByRoadmapName(name);
    fetchRoadmaps();
  }

  void addNewRoadmapAlert() {
    showDialog(
      context: context,
      builder: (coontext) {
        return AlertDialog(
          title: const Text("Add new roadmap"),
          content: TextField(
            controller: roadmapNameController,
            decoration: const InputDecoration(labelText: "name"),
            style: Theme.of(context).textTheme.bodyMedium,
            maxLength: 25,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (roadmapNameController.text.isNotEmpty) {
                  Navigator.pop(context);
                  addNewRoadmapElement(roadmapNameController.text);
                  roadmapNameController.clear();
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
                minLines: 1,
                maxLines: 5,
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

  void newRoadmapNameAlert(String currentName) {
    showDialog(
      context: context,
      builder: (coontext) {
        return AlertDialog(
          title: const Text("New roadmap name"),
          content: TextField(
            controller: roadmapNameController,
            decoration: const InputDecoration(labelText: "name"),
            style: Theme.of(context).textTheme.bodyMedium,
            maxLength: 25,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (roadmapNameController.text.isNotEmpty) {
                  Navigator.pop(context);
                  newRoadmapName(currentName, roadmapNameController.text);
                  roadmapNameController.clear();
                }
              },
              child: const Center(child: Text("Next")),
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
      body: FutureBuilder<List<RoadmapSummary>>(
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
                    child: Slidable(
                      startActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(14),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            onPressed: (context) {
                              deleteRoadmap(snapshot.data![index].roadmapName);
                            },
                            icon: Icons.delete,
                          ),
                          SlidableAction(
                            borderRadius: BorderRadius.circular(14),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            onPressed: (context) {
                              newRoadmapNameAlert(
                                  snapshot.data![index].roadmapName);
                            },
                            icon: Icons.edit,
                          ),
                        ],
                      ),
                      endActionPane: ActionPane(
                        motion: const StretchMotion(),
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(14),
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            onPressed: (context) {
                              newRoadmapNameAlert(
                                  snapshot.data![index].roadmapName);
                            },
                            icon: Icons.edit,
                          ),
                          SlidableAction(
                            borderRadius: BorderRadius.circular(14),
                            backgroundColor:
                                Theme.of(context).colorScheme.error,
                            onPressed: (context) {
                              deleteRoadmap(snapshot.data![index].roadmapName);
                            },
                            icon: Icons.delete,
                          ),
                        ],
                      ),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(14),
                        onTap: () {
                          Navigator.pushNamed(context, "/roadmapPage",
                              arguments: snapshot.data![index].roadmapName);
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14),
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
                                  style:
                                      Theme.of(context).textTheme.labelMedium,
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
