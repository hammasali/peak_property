import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/custom/custom_button.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final myAppBar = AppBar(
      title: Text(
       MyApp.myProfile,
        style: theme.textTheme.headline6,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.chevron_left,
          size: 32,
        ),
      ),
      elevation: 0,
      actions: [
        TextButton(
          onPressed: () {},
          child: Text(
            MyApp.logout,
            style: theme.textTheme.button!.copyWith(
                color: theme.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;
    return Scaffold(
      appBar: myAppBar,
      body: FadedSlideAnimation(
        child: Container(
          color: MyApp.kDefaultBackgroundColorWhite,
          height: bheight,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 20, bottom: 20),
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      FadedScaleAnimation(
                        child: const CircleAvatar(
                          radius: 60,
                          backgroundImage: AssetImage('assets/Layer1677.png'),
                        ),
                      ),
                      Positioned(
                        right: 0,
                        top: 7,
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: theme.primaryColor,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            size: 18,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 20),
                      alignment: Alignment.centerLeft,
                      color: Colors.grey[300],
                      width: double.infinity,
                      child: Text(
                        MyApp.profileInfo,
                        style: theme.textTheme.headline6!.copyWith(
                          color: Colors.grey,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                      child: TextField(
                        controller:
                            TextEditingController(text: 'Samantha Smith'),
                        decoration: const InputDecoration(
                          labelText: MyApp.fullNameTxt,
                          alignLabelWithHint: false,
                          border: InputBorder.none,
                          labelStyle: TextStyle(height: 1),
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 3,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextField(
                        controller:
                            TextEditingController(text: 'samantha_smith'),
                        decoration: const InputDecoration(
                          labelText: MyApp.username,
                          labelStyle: TextStyle(height: 1),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 3,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextField(
                        controller: TextEditingController(text: 'Happy ;)'),
                        decoration: const InputDecoration(
                          labelText: MyApp.bio,
                          labelStyle: TextStyle(height: 1),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 3,
                    ),
                    Container(
                      color: Colors.white,
                      width: double.infinity,
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: TextField(
                        controller: TextEditingController(
                            text: "samanthasmith@mail.com"),
                        decoration: const InputDecoration(
                          labelText: MyApp.emailAddress,
                          labelStyle: TextStyle(height: 1),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Divider(
                      color: Colors.grey[300],
                      thickness: 3,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        minLines: 3,
                        maxLines: 5,
                        keyboardType: TextInputType.multiline,
                        decoration: const InputDecoration(
                          label: Text(MyApp.about),
                          hintText: MyApp.aboutHint,
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.all(MyApp.kDefaultPadding),
                        child: CustomButton(
                          textColor: MyApp.kDefaultBackgroundColorWhite,
                          width: MediaQuery.of(context).size.width,
                          label: MyApp.saveProfile,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
      ),
    );
  }
}
