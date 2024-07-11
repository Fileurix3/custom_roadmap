import 'package:custom_roadmap/bloc/roadmap/roadmap_state.dart';
import 'package:custom_roadmap/widgets/my_timeline_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RoadmapPage extends StatefulWidget {
  const RoadmapPage({super.key});

  @override
  State<RoadmapPage> createState() => _RoadmapPageState();
}

class _RoadmapPageState extends State<RoadmapPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  late String roadmapName;

  TextEditingController roadmapElementNameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  int? selectedItemId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    roadmapName = ModalRoute.of(context)!.settings.arguments as String;
    context.read<RoadmapCubit>().fetchRoadmap(roadmapName);
  }

  void addRoadmapElementAlert() {
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
                maxLength: 50,
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
                  context.read<RoadmapCubit>().addNewRoadmapAndRoadmapElement(
                        roadmapElementNameController.text,
                        descriptionController.text,
                        roadmapName,
                      );
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

  void openDrawer(int itemId) {
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
        actions: [Container()],
        title: Text(
          roadmapName,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ),
      body: BlocBuilder<RoadmapCubit, RoadmapState>(
        builder: (context, state) {
          if (state is RoadmapLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is RoadmapError) {
            return Center(child: Text(state.message));
          } else if (state is RoadmapLoaded) {
            return ListView.builder(
              itemCount: state.roadmap.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 100,
                  ),
                  child: Column(
                    children: [
                      MyTimelineTile(
                        id: state.roadmap[index].id,
                        title: state.roadmap[index].roadmapElement,
                        isCompleted: state.roadmap[index].isCompleted,
                        roadmapElementId: state.roadmap[index].idRoadmapElement,
                        isFirst: index == 0 ? true : false,
                        isLast:
                            index == state.roadmap.length - 1 ? true : false,
                      )
                    ],
                  ),
                );
              },
            );
          }
          return const Text("error");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addRoadmapElementAlert();
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
