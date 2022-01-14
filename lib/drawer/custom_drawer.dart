import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_button.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final theme = Theme.of(context);
    return Container(
      width: 225,
      color: MyApp.kDefaultBackgroundColor,
      height: mediaQuery.size.height,
      child: Drawer(
        child: FadedSlideAnimation(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        width: double.infinity,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(Icons.close, color: theme.primaryColor),
                        ),
                      ),
                      const SizedBox(height: 20),
                      FadedScaleAnimation(
                        child: const CircleAvatar(
                          radius: 35,
                          backgroundImage: AssetImage('assets/Layer1677.png'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Hey',
                        style: theme.textTheme.subtitle2!.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                      Text(
                        'Saman Smith',
                        style: theme.textTheme.subtitle2!.copyWith(
                          color: theme.hintColor,
                        ),
                      ),
                      const SizedBox(
                        height: 50.0,
                      ),
                      tiles(
                          context: context,
                          title: MyApp.viewProfile,
                          function: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(Routes.profile);
                          }),
                      tiles(
                          context: context,
                          title: MyApp.editProfile,
                          function: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pushNamed(Routes.editProfile);

                          }),
                      tiles(
                          context: context,
                          title: MyApp.rateUs,
                          function: () {
                            rateUs();
                          }),
                      tiles(
                          context: context,
                          title: MyApp.logout,
                          function: () {
                            Navigator.of(context).pop();
                          }),
                      tiles(
                          context: context,
                          title: MyApp.aboutUs,
                          function: () {
                            aboutUs();
                          }),
                    ],
                  ),
                ),
              ),
            ],
          ),
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }

  tiles({BuildContext? context, String? title, function}) {
    return GestureDetector(
      onTap: function,
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Text(
          title!,
          style: Theme.of(context!)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }

  rateUs() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(MyApp.rateUs),
          alignment: Alignment.center,
          actions: <Widget>[
            RatingBar.builder(
              initialRating: 3,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            )
          ],
        );
      },
    );
  }

  aboutUs() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(MyApp.aboutUs),
          content: const Text(
            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
          ),
          alignment: Alignment.center,
          actions: <Widget>[
            CustomButton(
              label: "OK",
              color: MyApp.kDefaultBackgroundColorWhite,
              textColor: MyApp.kDefaultTextColorBlack,
              onTap: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }
}
