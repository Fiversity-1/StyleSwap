import 'package:clothing_swap/features/community/event_class.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:clothing_swap/widgets/event_listing.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';

class EventPage extends StatefulWidget {
  const EventPage({super.key, required this.communityEvents});
  final List<Event> communityEvents;

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Define grid column count based on available width
          bool sideBars = constraints.maxWidth > 600;

          return Row(
            children: [
              Visibility(
                visible: sideBars,
                child: Expanded(
                    flex: 2,
                    child: Container(
                      color: Theme.of(context).canvasColor,
                    )),
              ),
              Expanded(
                flex: 5,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: (20.0)),
                    child: SizedBox(
                        width: width * 0.85,
                        child: EventList(listings: widget.communityEvents)),
                  ),
                ),
              ),
              Visibility(
                visible: sideBars,
                child: Expanded(
                    flex: 2,
                    child: Container(
                      color: Theme.of(context).canvasColor,
                    )),
              ),
            ],
          );
        },
      ),
    );
  }
}
