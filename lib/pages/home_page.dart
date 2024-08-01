import 'package:custom_roadmap/bloc/summary%20roadmap/summary_roadmap_state.dart';
import 'package:custom_roadmap/bloc/theme/theme_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController roadmapNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<SummaryRoadmapCubit>().fetchRoadmaps();
  }

  void updateRoadmapNameAlert(String currentName) {
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
                  context.read<SummaryRoadmapCubit>().updateNameRoadmap(
                      currentName, roadmapNameController.text);
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
        automaticallyImplyLeading: false,
        title: const Text(
          "Custom roadmaps list",
        ),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return Padding(
                padding: const EdgeInsets.all(2),
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () {
                    context.read<ThemeCubit>().toggleTheme();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(6),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 100),
                      transitionBuilder: (child, animation) {
                        return ScaleTransition(
                          scale: animation,
                          child: child,
                        );
                      },
                      child: state.darkTheme == false
                          ? const Icon(
                              Icons.nights_stay,
                              key: ValueKey<int>(1),
                            )
                          : const Icon(
                              Icons.light_mode,
                              key: ValueKey<int>(2),
                            ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SummaryRoadmapCubit, SummaryRoadmapState>(
        builder: (context, state) {
          if (state is SummaryRoadmapLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SummaryRoadmapError) {
            return Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.labelMedium,
              ),
            );
          } else if (state is SummaryRoadmapLoaded) {
            if (state.roadmap.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      hoverColor: Colors.white.withOpacity(0),
                      highlightColor: Colors.grey.withOpacity(0.2),
                      padding: const EdgeInsets.all(0),
                      onPressed: () {
                        Navigator.pushNamed(context, "/addNewRoadmapPage");
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
            } else if (state.roadmap.isNotEmpty) {
              return Scaffold(
                body: ListView.builder(
                  itemCount: state.roadmap.length,
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
                                context
                                    .read<SummaryRoadmapCubit>()
                                    .deleteRoadmap(
                                        state.roadmap[index].roadmapName);
                              },
                              icon: Icons.delete,
                            ),
                            SlidableAction(
                              borderRadius: BorderRadius.circular(14),
                              backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                              onPressed: (context) {
                                updateRoadmapNameAlert(
                                    state.roadmap[index].roadmapName);
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
                                updateRoadmapNameAlert(
                                    state.roadmap[index].roadmapName);
                              },
                              icon: Icons.edit,
                            ),
                            SlidableAction(
                              borderRadius: BorderRadius.circular(14),
                              backgroundColor:
                                  Theme.of(context).colorScheme.error,
                              onPressed: (context) {
                                context
                                    .read<SummaryRoadmapCubit>()
                                    .deleteRoadmap(
                                        state.roadmap[index].roadmapName);
                              },
                              icon: Icons.delete,
                            ),
                          ],
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(14),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              "/roadmapPage",
                              arguments: state.roadmap[index].roadmapName,
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Theme.of(context).cardColor,
                              border:
                                  Theme.of(context).colorScheme.brightness ==
                                          Brightness.light
                                      ? Border.all(color: Colors.grey)
                                      : Border.all(color: Colors.grey.shade700),
                            ),
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    state.roadmap[index].roadmapName,
                                    style:
                                        Theme.of(context).textTheme.labelMedium,
                                    textAlign: TextAlign.center,
                                  ),
                                  Text(
                                    "completed: ${((state.roadmap[index].completedItems / state.roadmap[index].totalItems) * 100).toStringAsFixed(1)}%",
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
                    Navigator.pushNamed(context, "/addNewRoadmapPage");
                  },
                  child: const Icon(Icons.add),
                ),
              );
            }
          }
          return Center(
            child: Text(
              "error",
              style: Theme.of(context).textTheme.labelMedium,
            ),
          );
        },
      ),
    );
  }
}
