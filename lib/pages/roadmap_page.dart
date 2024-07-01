import 'package:custom_roadmap/model/custom_roadmap_model.dart';
import 'package:custom_roadmap/services/custom_roadmap_services.dart';
import 'package:custom_roadmap/widgets/roadmap_element_drawer.dart';
import 'package:flutter/material.dart';

class RoadmapPage extends StatefulWidget {
  const RoadmapPage({super.key});

  @override
  State<RoadmapPage> createState() => _RoadmapPageState();
}

class _RoadmapPageState extends State<RoadmapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<List<CustomRoadmapModel>>? roadmap;
  final customRoadmapServices = CustomRoadmapServices();

  late String roadmapName;

  TextEditingController roadmapElementNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int? selectedItemId;

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

  void _addNewRoadmapElement(
      String roadmapElementName, String description) async {
    await customRoadmapServices.addNewRoadmap(
      roadmapName,
      roadmapElementName,
      description,
    );
    fetchRoadmap();
  }

  void addRoadmapElement() {
    showDialog(
      context: context,
      builder: (coontext) {
        return AlertDialog(
          title: const Text("New roadmap element"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: roadmapElementNameController,
                decoration:
                    const InputDecoration(labelText: "Roadmap element name"),
                style: Theme.of(context).textTheme.bodyMedium,
                maxLength: 25,
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
                style: Theme.of(context).textTheme.bodyMedium,
                minLines: 1,
                maxLines: 5,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                if (roadmapElementNameController.text.isNotEmpty &&
                    descriptionController.text.isNotEmpty) {
                  _addNewRoadmapElement(roadmapElementNameController.text,
                      descriptionController.text);
                  Navigator.pop(context);
                  roadmapElementNameController.clear();
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

  void _updateIsCompleted(int id, int isCompleted) async {
    await customRoadmapServices.updateIsCompleted(id, isCompleted);
    setState(() {
      final index = roadmap
          ?.then((value) => value.indexWhere((element) => element.id == id));
      index?.then((idx) {
        if (idx != -1) {
          roadmap?.then((value) => value[idx].isCompleted = isCompleted);
        }
      });
    });
  }

  void openDrawerWithItemId(int itemId) {
    setState(() {
      selectedItemId = itemId;
    });
    _scaffoldKey.currentState!.openEndDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, "/homePage");
          },
          icon: const Icon(Icons.arrow_back),
        ),
        actions: [Container()],
        title: Text(
          roadmapName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      endDrawerEnableOpenDragGesture: false,
      endDrawer: RoadmapElementDrawer(itemId: selectedItemId),
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
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 50,
                      margin: const EdgeInsets.only(
                        right: 20,
                      ),
                      child: Text(
                        snapshot.data![index].idRoadmapElement.toString(),
                        style: Theme.of(context).textTheme.titleLarge,
                        textAlign: TextAlign.end,
                      ),
                    ),
                    Column(
                      children: [
                        if (index == 0)
                          const Padding(
                            padding: EdgeInsets.only(top: 35),
                          ),
                        if (index != 0)
                          Container(
                            height: 35,
                            width: 3,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                        Container(
                          height: MediaQuery.of(context).size.width / 6,
                          width: MediaQuery.of(context).size.width / 6,
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Checkbox(
                            value: snapshot.data![index].isCompleted == 0
                                ? false
                                : true,
                            onChanged: (value) {
                              if (value == true) {
                                _updateIsCompleted(snapshot.data![index].id, 1);
                              } else {
                                _updateIsCompleted(snapshot.data![index].id, 0);
                              }
                            },
                          ),
                        ),
                        if (index == snapshot.data!.length - 1)
                          const Padding(
                            padding: EdgeInsets.only(bottom: 35),
                          ),
                        if (index != snapshot.data!.length - 1)
                          Container(
                            height: 35,
                            width: 3,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                      ],
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(
                          left: 8,
                          right: 4,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              borderRadius: BorderRadius.circular(16),
                              onTap: () {
                                openDrawerWithItemId(snapshot.data![index].id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  vertical: 4,
                                  horizontal: 8,
                                ),
                                child: Text(
                                  snapshot.data![index].roadmapElement,
                                  style: snapshot.data![index].isCompleted == 0
                                      ? Theme.of(context).textTheme.titleMedium
                                      : Theme.of(context).textTheme.titleSmall,
                                  overflow: TextOverflow.visible,
                                  softWrap: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addRoadmapElement();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
