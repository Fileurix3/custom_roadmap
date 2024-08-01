import 'package:custom_roadmap/bloc/summary%20roadmap/summary_roadmap_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddNewRoadmapPage extends StatefulWidget {
  const AddNewRoadmapPage({super.key});

  @override
  State<AddNewRoadmapPage> createState() => _AddNewRoadmapPageState();
}

class _AddNewRoadmapPageState extends State<AddNewRoadmapPage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController roadmapNameController = TextEditingController();
  TextEditingController firstElementNameController = TextEditingController();
  TextEditingController firstElementDescriptionController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add new roadmap"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width / 12,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: roadmapNameController,
                        decoration: const InputDecoration(
                          labelText: "roadmap name",
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLength: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field must not be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 40),
                      SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          "Add first element",
                          style: Theme.of(context).textTheme.labelMedium,
                          textAlign: TextAlign.left,
                        ),
                      ),
                      TextFormField(
                        controller: firstElementNameController,
                        decoration: const InputDecoration(
                          labelText: "name",
                          counterText: "",
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLength: 50,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field must not be empty";
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 14),
                      TextFormField(
                        controller: firstElementDescriptionController,
                        decoration: const InputDecoration(
                          labelText: "description",
                        ),
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: null,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Field must not be empty";
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context.read<SummaryRoadmapCubit>().addNewRoadmap(
                          roadmapNameController.text,
                          firstElementNameController.text,
                          firstElementDescriptionController.text,
                        );
                    Navigator.pop(context);
                  }
                },
                child: const Center(
                  child: Text("Add"),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
