import 'package:clothing_swap/features/community/domain/event_class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

//List of events on Event Page
class EventList extends StatefulWidget {
  const EventList({
    super.key,
    required this.listings,
  });

  final List<Event> listings;

  @override
  State<EventList> createState() => _EventListState();
}

class _EventListState extends State<EventList> {
  //GPT used for mapping boolean - see comment below
  //Used so each announcement wouldn't open when see more pressed
  Map<int, bool> seeMoreMap = {};
  bool attendance = false;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return LayoutBuilder(
      builder: (context, constraints) {
        // Define grid column count based on available width
        bool sideBars = constraints.maxWidth > 600;

        return SizedBox(
          child: ListView.builder(
            itemCount: widget.listings.length,
            itemBuilder: (context, index) {
              //GPT for mapping booleans
              bool seeMore = seeMoreMap[index] ?? false;
              return Padding(
                padding: const EdgeInsets.only(bottom: 25.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        seeMoreMap[index] = !seeMore;
                        setState(() {});
                      },
                      child: ListTile(
                        shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.black26, width: 3),
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        title: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(widget.listings[index].image,
                                fit: BoxFit.cover),
                            SizedBox(
                              width: width * 0.725,
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 10.0,
                                    bottom: seeMoreMap[index] == true ? 10 : 0),
                                child: Center(
                                  child: Text(
                                    '${widget.listings[index].title} - ${widget.listings[index].city}',
                                    style: kIsWeb && sideBars
                                        ? Theme.of(context)
                                            .textTheme
                                            .headlineLarge
                                        : kIsWeb && !sideBars
                                            ? Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                            : Theme.of(context)
                                                .textTheme
                                                .bodyLarge,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        minTileHeight: 125,
                        titleAlignment: ListTileTitleAlignment.threeLine,
                        subtitle: Column(
                          children: [
                            ListView(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: const EdgeInsets.all(0),
                              children: [
                                Visibility(
                                  visible: seeMore,
                                  child: ListTile(
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black26, width: 0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    title: Text(
                                      'Hosted by: ${widget.listings[index].company}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    leading: const Icon(Icons.home),
                                  ),
                                ),
                                Visibility(
                                  visible: seeMore,
                                  child: ListTile(
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black26, width: 0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    title: Text(
                                      "Where: ${widget.listings[index].location}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    leading: const Icon(Icons.location_on),
                                  ),
                                ),
                                Visibility(
                                  visible: seeMore,
                                  child: ListTile(
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black26, width: 0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    title: Text(
                                      "When: ${widget.listings[index].date}, ${widget.listings[index].time} ",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    leading: const Icon(
                                        Icons.calendar_month_rounded),
                                  ),
                                ),
                                Visibility(
                                  visible: seeMore,
                                  child: ListTile(
                                    shape: const RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: Colors.black26, width: 0.5),
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(0),
                                      ),
                                    ),
                                    title: Text(
                                      "Details: ${widget.listings[index].details}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium,
                                    ),
                                    leading: const Icon(Icons.info),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    Text("Attending: ",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium),
                                    //https://pub.dev/packages/like_button
                                    //Inspired by like button example, used throughout
                                    LikeButton(
                                      size: 25,
                                      isLiked: attendance,
                                      likeCount:
                                          communityEvents[index].attendance,
                                      likeBuilder: (attendance) {
                                        final colour =
                                            attendance ? Colors.green : null;
                                        return Icon(Icons.check_circle_outline,
                                            color: colour);
                                      },
                                    )
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.comment),
                                  iconSize: 25,
                                  hoverColor: Theme.of(context).hoverColor,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/comment');
                                  },
                                ),
                                IconButton(
                                    onPressed: () {
                                      seeMoreMap[index] = !seeMore;
                                      setState(() {});
                                    },
                                    icon: const Icon(Icons.more_horiz)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }
}
