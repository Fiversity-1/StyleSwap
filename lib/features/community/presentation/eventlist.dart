import 'package:clothing_swap/features/community/domain/event_class.dart';
import 'package:clothing_swap/features/community/presentation/event_listing.dart';
import 'package:clothing_swap/theme/gradient.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';

//Displays list of event_listing widgets
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
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: CustomTopAppBar(),
        ),
        bottomNavigationBar: const CustomBottomNavBar(
          currentIndex: 2,
        ),
        body: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: (20.0),
                ),
                child: SizedBox(
                    width: width * 0.9,
                    child: EventList(listings: widget.communityEvents)),
              ),
            );
          },
        ),
      ),
    );
  }
}
