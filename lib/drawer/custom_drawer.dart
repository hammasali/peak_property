import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

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
                      const SizedBox(height: 50.0,),
                      tiles(
                          context: context,
                          title: "Profile",
                          function: () {
                            Navigator.of(context).pushNamed(Routes.profile);
                          }),
                      tiles(
                          context: context,
                          title: "Edit Profile",
                          function: () {
                            Navigator.of(context).pop();
                          }),
                      tiles(
                          context: context,
                          title: "Feedback",
                          function: () {
                            Navigator.of(context).pop();
                          }),
                      tiles(
                          context: context,
                          title: "Rate Us",
                          function: () {
                            Navigator.of(context).pop();
                          }),
                      tiles(
                          context: context,
                          title: "Logout",
                          function: () {
                            Navigator.of(context).pop();
                          }),
                      tiles(
                          context: context,
                          title: "About Us",
                          function: () {
                            Navigator.of(context).pop();
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
}
