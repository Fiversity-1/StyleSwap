// signup.dart

import 'package:clothing_swap/features/community/eventlist.dart';
import 'package:clothing_swap/widgets/custom_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:clothing_swap/widgets/custom_top_app_bar.dart';

class IndividualEvent extends StatefulWidget {
  const IndividualEvent({super.key, this.individualEvent});
  final Event? individualEvent;
  @override
  State<IndividualEvent> createState() => _IndividualEventState();
}

class _IndividualEventState extends State<IndividualEvent> {
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
              itemCount: 1,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ListTile(
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
