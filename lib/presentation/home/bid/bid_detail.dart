import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/dummy.dart';

class BidDetails extends StatefulWidget {
  const BidDetails({Key? key}) : super(key: key);

  @override
  State<BidDetails> createState() => _BidDetailsState();
}

class _BidDetailsState extends State<BidDetails>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final List<Widget> imageSliders = data
        .map((item) => Container(
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: const EdgeInsets.all(1.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.asset(
                        item.image,
                        fit: BoxFit.cover,
                        height: 400,
                        width: 300,
                        scale: 0.8,
                        colorBlendMode: BlendMode.darken,
                      ),
                    ],
                  )),
            ))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.white.withOpacity(0.6)),
          child: IconButton(
              iconSize: 25.0,
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_rounded)),
        ),
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                const CircleAvatar(
                  radius: 20,
                  backgroundImage: AssetImage('assets/Layer1677.png'),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 12,
                  child: Text(
                    "Emily Will Smith",
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: const [
          Icon(
            Icons.chat_rounded,
            size: MyApp.kDefaultIconSize,
            color: Colors.black87,
          ),
          SizedBox(width: 12.0)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25.0, horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  height: 200,
                  aspectRatio: 16 / 9,
                  viewportFraction: 0.8,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 5),
                  autoPlayAnimationDuration: const Duration(seconds: 2),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  scrollDirection: Axis.horizontal,
                  onPageChanged: (index, reason) {
                    //TODO: USe bloc for state management
                    setState(() {
                      _current = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: data.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20.0),
            Text(
              'Bid time :',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 5.0),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                  border: Border.all(
                      color: Colors.black,
                      width: 2.0,
                      style: BorderStyle.solid),
                  borderRadius: BorderRadius.circular(12.0)),
              child: TimerCountdown(
                format: CountDownTimerFormat.daysHoursMinutesSeconds,
                endTime: DateTime.now().add(
                  const Duration(seconds: 10),
                ),
                onEnd: () {
                  print("Timer finished");
                },
                timeTextStyle: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                colonsTextStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
                descriptionTextStyle: const TextStyle(
                  color: Colors.red,
                  fontSize: 18,
                ),
                daysDescription: "day",
                hoursDescription: "hr",
                minutesDescription: "min",
                secondsDescription: "sec",
                spacerWidth: 20.0,
                enableDescriptions: true,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Divider(
              indent: 60,
              endIndent: 60,
              thickness: 2,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Atttributes',
              style: Theme.of(context).textTheme.headline5,
            ),
            const Spacer(),
            Center(
                child: CustomButton(
              label: 'Place a bid',
              onTap: () {
                Navigator.of(context).pushNamed(Routes.placeBid);
              },
            ))
          ],
        ),
      ),
    );
  }
}
