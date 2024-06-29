import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<CustomRoadmapModel>>? roadmapName;
  final customRoadmapServices = CustomRoadmapServices();

  TextEditingController nameRoadmapController = TextEditingController();
  TextEditingController roadamElementController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int? isHoverIndex;

  @override
  void initState() {
    super.initState();
    fetchRoadmapName();
  }

  Future<void> fetchRoadmapName() async {
    setState(() {
      roadmapName = customRoadmapServices.getRoadmapsName();
    });
  }

  void addNewRoadmap(
      String nameRoadmap, String roadmapElement, String description) async {
    await customRoadmapServices.addNewRoadmap(
        nameRoadmap, roadmapElement, description);
    fetchRoadmapName();
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
            style: Theme.of(context).textTheme.labelLarge,
            maxLength: 20,
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
                style: Theme.of(context).textTheme.labelLarge,
                maxLength: 50,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                style: Theme.of(context).textTheme.labelLarge,
                maxLength: 254,
                minLines: 1,
                maxLines: 10,
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

  int getCrossAxisCount(double width) {
    if (width >= 1920) {
      return 9;
    } else if (width >= 1500) {
      return 8;
    } else if (width >= 1250) {
      return 7;
    } else if (width >= 1050) {
      return 6;
    } else if (width >= 800) {
      return 5;
    } else if (width >= 600) {
      return 4;
    } else if (width >= 400) {
      return 3;
    } else if (width >= 200) {
      return 2;
    } else if (width >= 100) {
      return 1;
    } else {
      return 3;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<CustomRoadmapModel>>(
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
                    style: Theme.of(context).textTheme.titleSmall,
                  )
                ],
              ),
            );
          } else {
            return Scaffold(
              body: GridView.builder(
                padding: const EdgeInsets.symmetric(
                  horizontal: 50,
                  vertical: 20,
                ),
                itemCount: snapshot.data!.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      getCrossAxisCount(MediaQuery.of(context).size.width),
                  mainAxisSpacing: 14,
                  crossAxisSpacing: 14,
                ),
                itemBuilder: (context, index) {
                  return MouseRegion(
                    onEnter: (_) {
                      setState(() {
                        isHoverIndex = index;
                      });
                    },
                    onExit: (_) {
                      setState(() {
                        isHoverIndex = null;
                      });
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, "/roadmapPage",
                            arguments: snapshot.data![index].roadmapName);
                      },
                      child: AnimatedContainer(
                        transform: isHoverIndex == index
                            ? Matrix4.translationValues(0, 0, 0)
                            : Matrix4.translationValues(0, 5, 0),
                        duration: const Duration(milliseconds: 200),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: isHoverIndex == index
                              ? Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7)
                              : Theme.of(context).cardColor,
                        ),
                        child: Center(
                          child: Text(
                            snapshot.data![index].roadmapName,
                            style: Theme.of(context).textTheme.titleSmall,
                            textAlign: TextAlign.center,
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
