//Event Class with 4 example events
class Event {
  final String company;
  final String image;
  final String title;
  final String date;
  final String time;
  final String details;
  final String location;
  final String city;
  int attendance;

  Event(
      {required this.title,
      required this.company,
      required this.image,
      required this.details,
      required this.date,
      required this.time,
      required this.location,
      required this.attendance,
      required this.city});
}

List<Event> communityEvents = [
  Event(
      company: 'Vinnies',
      image: 'lib/images/test_events/op.jpg',
      details: 'Bring sport hats!',
      title: 'Hat Swap',
      date: '1/5/24',
      time: '2pm',
      location: '17 River Street, Brisbane',
      city: "Brisbane",
      attendance: 4),
  Event(
      company: 'UQ',
      image: 'lib/images/test_events/op2.jpg',
      details: 'Striped Clothes Encouraged!',
      title: 'Stripe Swap',
      date: '4/5/24',
      time: '5pm',
      location: '8 Lakeway, St Lucia',
      city: "St Lucia",
      attendance: 21),
  Event(
      company: 'Salvation Army',
      image: 'lib/images/test_events/op3.jpg',
      details: '',
      title: '2nd Hand Swapping',
      date: '14/6/24',
      time: '10am',
      location: '54 Mount Cotton Road, Capalaba',
      city: "Capalaba",
      attendance: 58),
  Event(
      company: 'Blue Care',
      image: 'lib/images/test_events/op4.jpg',
      details: 'Bring hats!',
      title: 'Vintage Clothe Swap',
      date: '24/6/24',
      time: '1pm',
      location: '100 Broadshire Road, Wynum',
      city: "Wynum",
      attendance: 11),
];
