import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peak_property/core/my_app.dart';

class FixedDetailScreen extends StatelessWidget {
  final String hero;

  const FixedDetailScreen({Key? key, required this.hero}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.black87,
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.black87,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 6.0)
                    ]),
                child: Hero(
                  tag: hero,
                  child: ClipRRect(
                    // borderRadius: BorderRadius.circular(30.0),
                    child: Image(
                      image: AssetImage(
                        hero,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 50.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.6)),
                      child: IconButton(
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_rounded)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.6)),
                      child: IconButton(
                          iconSize: 30.0,
                          color: Colors.black,
                          onPressed: () {},
                          icon: const Icon(Icons.bookmark_add_outlined)),
                    )
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Title",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.0,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: const [
                        Icon(
                          FontAwesomeIcons.locationArrow,
                          size: 10.0,
                          color: Colors.white70,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          "Country",
                          style:
                              TextStyle(fontSize: 15.0, color: Colors.white70),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const Positioned(
                  right: 20.0,
                  bottom: 20.0,
                  child: Icon(
                    Icons.location_on,
                    size: 20.0,
                    color: Colors.white70,
                  ))
            ],
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0xfff1f1f1),
            ),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage('assets/Layer1677.png'),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 12,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Emily Will Smith",
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              "Today 10:00 a.m.",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(color: Colors.grey, fontSize: 11),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      const Icon(
                        Icons.chat_outlined,
                        size: MyApp.kDefaultIconSize,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(
                    horizontal: MyApp.kDefaultPadding,
                    vertical: MyApp.kDefaultPadding),
                children: [
                  Text(
                    "Attributes",
                    style: Theme.of(context).textTheme.bodyText1,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
