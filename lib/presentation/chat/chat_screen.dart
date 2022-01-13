import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';

class ChatSingleScreen extends StatelessWidget {
  ChatSingleScreen({Key? key}) : super(key: key);
  final List<String> messages = [
    "Hello There",
    "How You Doing ",
    "Hey Wassup",
    "Isnt This App Amazing",
    "Its So Cool That I Can Chat With My Friends"
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final myAppBar = AppBar(
      elevation: 0,
      title: Transform(
        transform: Matrix4.translationValues(-25, 3, 0),
        child: Row(
          children: [
            Container(
              height: 45,
              margin: const EdgeInsets.symmetric(vertical: 16),
              decoration: const BoxDecoration(shape: BoxShape.circle),
              child: FadedScaleAnimation(
                child: const CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage("assets/Layer1677.png"),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              "Kevin Taylor",
              style: theme.textTheme.headline6!.copyWith(
                fontSize: 16.7,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
      leading: GestureDetector(
        onTap: () {
          Navigator.of(context).pop();
        },
        child: const Icon(
          Icons.chevron_left,
          color: Colors.black,
          size: 32,
        ),
      ),
    );

    return Scaffold(
      appBar: myAppBar,
      body: FadedSlideAnimation(
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.only(top: MyApp.kDefaultPadding),
                itemCount: 20,
                itemBuilder: (context, index) {
                  if (index % 2 == 0) return sender(context, index);
                  return receiver(context, index);
                },
              ),
            ),
            message(context),
          ],
        ),
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }

  message(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Container(
      height: 60,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
      child: Row(
        children: [
          const SizedBox(
            width: 5,
          ),
          Icon(
            Icons.emoji_emotions_outlined,
            color: theme.primaryIconTheme.color,
            size: 22,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: mediaQuery.size.width * 0.7,
            child: const TextField(
              decoration: InputDecoration(
                hintText: "Write Your Comment",
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
          const Spacer(),
          Icon(
            Icons.send,
            color: theme.primaryColor,
            size: 22,
          ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  sender(BuildContext context, int index) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Text(
              "12:00 am",
              style: TextStyle(color: Colors.grey, fontSize: 8),
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor,
              ),
              // width: mediaQuery.size.width * 0.7,
              width: messages[index % messages.length].length * 10.0 >=
                      mediaQuery.size.width * 0.7
                  ? mediaQuery.size.width * 0.7
                  : messages[index % messages.length].length * 10.0,
              alignment: Alignment.centerRight,
              child: Text(
                messages[index % messages.length],
                style: theme.textTheme.bodyText1!
                    .copyWith(fontSize: 14.7, color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }

  receiver(BuildContext context, int index) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
              padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey[400]),
              // width: mediaQuery.size.width * 0.7,
              width: messages[index % messages.length].length * 10.0 >=
                      mediaQuery.size.width * 0.7
                  ? mediaQuery.size.width * 0.7
                  : messages[index % messages.length].length * 10.0,
              alignment: Alignment.centerLeft,
              child: Text(
                messages[index % messages.length],
                style: theme.textTheme.bodyText1!
                    .copyWith(fontSize: 14.7, color: Colors.black),
              ),
            ),
            Container(
              child: const Text(
                "12:07 am",
                style: TextStyle(color: Colors.grey, fontSize: 8),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
