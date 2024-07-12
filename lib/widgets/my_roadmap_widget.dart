import 'package:custom_roadmap/bloc/roadmap/roadmap_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';

class MyRoadmapWidget extends StatelessWidget {
  final int id;
  final String title;
  final int isCompleted;
  final int roadmapElementId;
  final bool isFirst;
  final bool isLast;

  const MyRoadmapWidget({
    super.key,
    required this.id,
    required this.title,
    required this.isCompleted,
    required this.roadmapElementId,
    required this.isFirst,
    required this.isLast,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoadmapCubit, RoadmapState>(
      builder: (context, state) {
        return SizedBox(
          height: 200,
          width: MediaQuery.of(context).size.width,
          child: TimelineTile(
            alignment: TimelineAlign.manual,
            lineXY: 0.17,
            isFirst: isFirst,
            isLast: isLast,
            beforeLineStyle: LineStyle(
              color: Theme.of(context).colorScheme.primary,
            ),
            indicatorStyle: IndicatorStyle(
              color: Theme.of(context).colorScheme.primary,
              width: MediaQuery.of(context).size.width / 8,
              iconStyle: IconStyle(
                iconData: isCompleted == 0 ? Icons.clear : Icons.done,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.white
                    : Colors.black,
              ),
            ),
            startChild: Checkbox(
              value: isCompleted == 0 ? false : true,
              onChanged: (value) {
                context
                    .read<RoadmapCubit>()
                    .updateIsCompleted(id, value == true ? 1 : 0);
              },
            ),
            endChild: Padding(
              padding: const EdgeInsets.all(25),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/aboutRoadmapElementPage",
                    arguments: id,
                  );
                },
                child: Ink(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 16,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primary,
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(title),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
