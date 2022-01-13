import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  const Notifications({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: FadedSlideAnimation(
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          itemCount: 20,
          itemBuilder: (context, index) {
            return ListTile(
              contentPadding: const EdgeInsets.only(left: 16, right: 10),
              leading: GestureDetector(
                onTap: () {
                  // Navigator.of(context).push(
                  //     MaterialPageRoute(builder: (_) => UserProfileScreen()));
                },
                child: FadedScaleAnimation(
                  child: const CircleAvatar(
                    radius: 22,
                    backgroundImage: AssetImage('assets/Layer1677.png'),
                  ),
                ),
              ),
              // title: Text('Kevin Taylor Liked your post'),
              title: RichText(
                text: TextSpan(
                  style: theme.textTheme.subtitle1!.copyWith(
                    letterSpacing: 0.5,
                  ),
                  children: [
                    TextSpan(
                        text: "Kevin Taylor",
                        style:
                            theme.textTheme.subtitle2!.copyWith(fontSize: 12)),
                    TextSpan(
                        text: ' ' + 'Bookmarked' + ' ',
                        style:
                            TextStyle(color: theme.primaryColor, fontSize: 12,fontWeight: FontWeight.bold)),
                    TextSpan(
                        text: "Your Post",
                        style: theme.textTheme.subtitle2!.copyWith(
                          fontSize: 12,
                        )),
                  ],
                ),
              ),
              subtitle: Text(
                "Today 10:00 am",
                style: theme.textTheme.subtitle2!.copyWith(
                  fontSize: 9,
                  color: theme.hintColor,
                ),
              ),
              trailing: AspectRatio(
                aspectRatio: 1 / 1,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(7),
                  child: Image.asset(
                    'assets/dummy/img_2.png',
                    fit: BoxFit.fitHeight,
                  ),
                ),
              ),
            );
          },
        ),
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
