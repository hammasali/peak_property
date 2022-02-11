import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/custom/custom_feeds.dart';
import 'package:peak_property/dummy.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final myAppBar = AppBar(
      centerTitle: true,
      title: Text(
        MyApp.kAppTitle,
        style: theme.textTheme.headline6,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.chevron_left,
          size: MyApp.kDefaultPadding * 2,
        ),
      ),
      elevation: 0,
    );

    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;

    return Scaffold(
      appBar: myAppBar,
      backgroundColor: MyApp.kDefaultBackgroundColorWhite,
      body: SingleChildScrollView(
        child: FadedSlideAnimation(
          child: Column(
            children: [
              SizedBox(
                height: bheight * 0.4,
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                        height: 80,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            FadedScaleAnimation(
                              child: const CircleAvatar(
                                radius: 40,
                                backgroundImage:
                                    AssetImage('assets/Layer1677.png'),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        "Emili Williamson",
                        style: theme.textTheme.headline6,
                      ),
                      Text(
                        "I am Emili Williamson",
                        style: theme.textTheme.subtitle2!.copyWith(
                          color: theme.hintColor,
                          fontSize: 12,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed(Routes.editProfile);
                        },
                        child: Container(
                          width: constraints.maxWidth * 0.35,
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: theme.primaryColor,
                                  style: BorderStyle.solid,
                                  width: 1),
                              borderRadius: BorderRadius.circular(10),
                              color: theme.primaryColor),
                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                          child: Text(
                            MyApp.editProfile,
                            textAlign: TextAlign.center,
                            style: theme.textTheme.subtitle2!.copyWith(
                              color: MyApp.kDefaultTextColorWhite,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Divider(thickness: 2.0),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(MyApp.kDefaultPadding * 2),
                    child: Text(
                      MyApp.about,
                      style: theme.textTheme.headline5
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                  )),
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: MyApp.kDefaultPadding * 2,
                        right: 8.0,
                        bottom: MyApp.kDefaultPadding),
                    child: AutoSizeText(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                      style: theme.textTheme.subtitle1,
                    ),
                  )),
              const Divider(thickness: 2.0),
              ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: data.length,
                  shrinkWrap: true,
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  itemBuilder: (context, index) {
                    final _data = data[index];

                    return Dismissible(
                      key: UniqueKey(),
                      direction: DismissDirection.endToStart,
                      confirmDismiss: (DismissDirection direction) async =>
                          await confirmation(),
                      background: Container(
                        padding: const EdgeInsets.all(8.0),
                        alignment: Alignment.centerRight,
                        color: MyApp.kDefaultBackgroundColor,
                        child: const Icon(
                          Icons.delete_forever,
                          size: 32,
                          color: Colors.black,
                        ),
                      ),
                      child: CustomFeeds(
                        title: _data.title,
                        subtitle: _data.subtitle,
                        description: _data.description,
                        time: _data.time,
                        image: _data.image,
                        hero: _data.image[index],
                      ),
                    );
                  })
            ],
          ),
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }

  confirmation() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(MyApp.confirm),
          content: const Text(MyApp.confirmationText),
          actions: <Widget>[
            CustomButton(
              label: MyApp.cancel,
              color: MyApp.kDefaultBackgroundColorWhite,
              textColor: MyApp.kDefaultTextColorBlack,
              onTap: () => Navigator.of(context).pop(false),
            ),
            CustomButton(
              label: MyApp.delete,
              radius: MyApp.kDefaultPadding - 6,
              padding: MyApp.kDefaultPadding - 6,
              textColor: MyApp.kDefaultTextColorWhite,
              onTap: () => Navigator.of(context).pop(true),
            ),
          ],
        );
      },
    );
  }
}
