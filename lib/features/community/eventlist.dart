import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';

class Event {
  final String company;
  final IconData logo;
  final String details;
  Event({required this.company, required this.logo, required this.details});
}

List<Event> events = [
  Event(
      company: 'Jacob',
      logo: Icons.category,
      details: 'This is random filler text'),
  Event(
      company: 'Steve',
      logo: Icons.numbers,
      details:
          'This is random filler textThis is random iller textThis is random filleiller textThis is random filleiller textThis is random fillefiller textThis is random filler text'),
  Event(
      company: 'Jack',
      logo: Icons.person,
      details: 'This is random filler textThis is random filler text'),
  Event(
      company: 'Josh',
      logo: Icons.type_specimen,
      details: 'This is random filler text'),
  Event(
      company: 'John',
      logo: Icons.gpp_good_outlined,
      details: 'This is random filler text'),
  Event(
      company: 'Filler',
      logo: Icons.palette,
      details: 'This is random filler text'),
];

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: CustomTopAppBar(),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 2),
      body: Center(
          child: Padding(
              padding: const EdgeInsets.only(top: (20.0)),
              child: SizedBox(
                width: width * 0.85,
                child: ListView.separated(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return ListTile(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8)),
                      ),
                      onTap: () {},
                      tileColor: Colors.white,
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CircleAvatar(
                            minRadius: 14,
                            backgroundImage:
                                AssetImage('lib/images/person.png'),
                          ),
                          Text(
                            ' ${events[index].company}',
                            style: Theme.of(context).textTheme.headlineSmall,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      minTileHeight: 125,
                      titleAlignment: ListTileTitleAlignment.threeLine,
                      subtitle: Text(events[index].details),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        const SizedBox(
                          height: 0.35,
                        ),
                        Container(
                          height: 50,
                          width: width,
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(8),
                                bottomRight: Radius.circular(8)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                  icon: const Icon(Icons.favorite_border),
                                  iconSize: 35,
                                  color: Colors.red,
                                  onPressed: () {
                                    Colors.black;
                                  }),
                              IconButton(
                                  icon: const Icon(Icons.comment),
                                  iconSize: 35,
                                  color: Colors.blue,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/eventlist');
                                  })
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        )
                      ],
                    );
                  },
                ),
              ))),
    );
  }
}
