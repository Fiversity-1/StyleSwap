import 'package:clothing_swap/features/community/event_class.dart';
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
  bool attendance = false;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.listings.length,
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
                hoverColor: Colors.transparent,
                shape: const RoundedRectangleBorder(
                  side: BorderSide(color: Colors.black26, width: 3),
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
                onTap: () {},
                title: Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('lib/images/op.jpg', fit: BoxFit.fitWidth),
                      Text(
                        '${widget.listings[index].title} - ${widget.listings[index].city}',
                        style: Theme.of(context).textTheme.headlineLarge,
                        textAlign: TextAlign.center,
                      ),
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
                        ListTile(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black26, width: 0.5),
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
                        ListTile(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black26, width: 0.5),
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
                        ListTile(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black26, width: 0.5),
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
                        ListTile(
                          shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.black26, width: 0.5),
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
                            Navigator.pushNamed(context, '/event',
                                arguments: communityEvents[index]);
                          },
                        )
                      ],
                    )
                  ],
                )),
            const SizedBox(
              height: 50,
            ),
          ],
        );
      },
    );
  }
}
