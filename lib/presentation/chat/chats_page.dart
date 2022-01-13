import 'dart:math';

import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/routes.dart';

import 'chat_screen.dart';

class ChatsPage extends StatelessWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemCount: 10,
            itemBuilder: (context, index) {

              return ListTile(
                onTap: () {
                  Navigator.of(context).pushNamed(Routes.conversationScreen);
                },
                leading: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                      child: FadedScaleAnimation(
                        child: const CircleAvatar(
                          radius: 24,
                          backgroundImage:
                              AssetImage("assets/Layer1677.png"),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 0,
                      right: 0,
                      child: index % 2 == 0
                          ? Container(
                              decoration: BoxDecoration(
                                color: theme.primaryColor,
                                shape: BoxShape.circle,
                              ),
                              padding: const EdgeInsets.fromLTRB(4, 0, 4, 2),
                              child: Center(
                                child: Text(
                                  '${Random().nextInt(10)}',
                                  style: theme.textTheme.bodyText1!.copyWith(
                                      color: Colors.white, fontSize: 8),
                                ),
                              ),
                            )
                          : Container(),
                    ),
                  ],
                ),
                title: Text(
                  "Will Smith",
                  style: TextStyle(
                    color: index % 2 == 0  ? theme.primaryColor : Colors.black,
                    fontSize: 13.3,
                  ),
                ),
                subtitle: Text(
                  "Yes That Was Awesome",
                  style: theme.textTheme.subtitle2!.copyWith(
                    color: theme.hintColor,
                    fontSize: 10.7,
                  ),
                ),
                trailing: Text(
                  '2 min ago',
                  style: theme.textTheme.bodyText1!
                      .copyWith(color: Colors.grey, fontSize: 9.3),
                ),
              );
            }, separatorBuilder: (BuildContext context, int index) => const Divider(),
          ),
        ),
      ),
    );
  }
}
