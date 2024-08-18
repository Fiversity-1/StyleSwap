import 'package:clothing_swap/widgets/custom_top_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';

class Event {
  final String company;
  final IconData logo;
  final String title;
  final String date;
  final String time;
  final String details;
  Event(
      {required this.title,
      required this.company,
      required this.logo,
      required this.details,
      required this.date,
      required this.time});
}

List<Event> events = [
  Event(
      company: 'Jacob',
      logo: Icons.category,
      details:
          'Come join us for a weekly clothes Come join us for a weekly clothes Come join us for a weekly clothes Come join us for a weekly clothes Come join us for a weekly clothes Come join us for a weekly clothes swap at Redlands Vinnies. Bring your favourite hat!',
      title: 'Clothes Swap',
      date: '4/5/24',
      time: '5pm'),
  Event(
      company: 'Jacob',
      logo: Icons.category,
      details: 'This is random filler text',
      title: 'Clothes Swap',
      date: '4/5/24',
      time: '5pm'),
  Event(
      company: 'Jacob',
      logo: Icons.category,
      details: 'This is random filler text',
      title: 'Clothes Swap',
      date: '4/5/24',
      time: '5pm'),
  Event(
      company: 'Jacob',
      logo: Icons.category,
      details: 'This is random filler text',
      title: 'Clothes Swap',
      date: '4/5/24',
      time: '5pm'),
  Event(
      company: 'Jacob',
      logo: Icons.category,
      details: 'This is random filler text',
      title: 'Clothes Swap',
      date: '4/5/24',
      time: '5pm'),
];

class EventList extends StatelessWidget {
  const EventList({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
                        hoverColor: Colors.transparent,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8),
                          ),
                        ),
                        onTap: () {},
                        title: Padding(
                          padding: const EdgeInsets.only(bottom: 15.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ClipOval(
                                child: Image.asset(
                                  'lib/images/vinnies.jpg',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Text(
                                ' ${events[index].title}',
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                        minTileHeight: 125,
                        titleAlignment: ListTileTitleAlignment.threeLine,
                        subtitle: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text('Hosted By: ${events[index].company}'),
                                Text(
                                    'When: ${events[index].date}, ${events[index].time}'),
                              ],
                            ),
                            const SizedBox(height: 15),
                            Text(events[index].details),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Row(
                                  children: [
                                    const Text("Attending: 5"),
                                    IconButton(
                                      icon: const Icon(
                                          Icons.check_circle_outline),
                                      iconSize: 25,
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                IconButton(
                                  icon: const Icon(Icons.comment),
                                  iconSize: 25,
                                  onPressed: () {
                                    Navigator.pushNamed(context, '/event',
                                        arguments: events[index]);
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
            ),
          ),
        ),
      ),
    );
  }
}
