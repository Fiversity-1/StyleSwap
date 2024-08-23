import 'package:clothing_swap/features/community/event_class.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

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
  //Map from chatgpt for mapping booleans
  Map<int, bool> seeMoreMap = {};
  bool attendance = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ListView.builder(
        itemCount: widget.listings.length,
        itemBuilder: (context, index) {
          //Map from chatgpt for mapping booleans
          bool seeMore = seeMoreMap[index] ?? false;
          return Padding(
            padding: const EdgeInsets.only(bottom: 25.0),
            child: Column(
              children: [
                ListTile(
                  shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.black26, width: 3),
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                  title: Padding(
                    padding: const EdgeInsets.only(bottom: 0.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(widget.listings[index].image,
                            fit: BoxFit.fitWidth),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '${widget.listings[index].title} - ${widget.listings[index].city}',
                              style: kIsWeb
                                  ? Theme.of(context).textTheme.headlineLarge
                                  : Theme.of(context).textTheme.bodyLarge,
                              textAlign: TextAlign.center,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  seeMoreMap[index] = !seeMore;
                                  setState(() {});
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(5),
                                  backgroundColor: Colors.transparent,
                                  minimumSize: const Size(0, 0),
                                ),
                                child: Text(
                                  !seeMore ? 'See More' : 'See Less',
                                  style: const TextStyle(fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                style: Theme.of(context).textTheme.bodyMedium,
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
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              leading: const Icon(Icons.calendar_month_rounded),
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
                                style: Theme.of(context).textTheme.bodyMedium,
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
                              const Text("Attending: "),
                              LikeButton(
                                size: 25,
                                isLiked: attendance,
                                likeCount: communityEvents[index].attendance,
                                likeBuilder: (attendance) {
                                  final colour = attendance
                                      ? Theme.of(context).hoverColor
                                      : Theme.of(context).indicatorColor;
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
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
