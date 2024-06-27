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

  void addNewRoadmap(String name) async {
    await customRoadmapServices.addNewRoadmap(name);
    fetchRoadmapName();
  }

  void addNewRoadmapAlert() {
    showDialog(
      context: context,
      builder: (coontext) {
        return AlertDialog(
          title: const Text("Add"),
          content: TextField(
            controller: nameRoadmapController,
            decoration: const InputDecoration(labelText: "name"),
            style: Theme.of(context).textTheme.labelLarge,
            maxLength: 50,
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (nameRoadmapController.text.isNotEmpty) {
                  Navigator.pop(context);
                  addNewRoadmap(nameRoadmapController.text);
                  nameRoadmapController.clear();
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
            return const Text("123");
          }
        },
      ),
    );
  }
}
