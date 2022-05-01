import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peak_property/business_logic/cubit/edit_profile_cubit/delete_property_cubit.dart';
import 'package:peak_property/business_logic/cubit/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/custom/custom_feeds.dart';
import 'package:peak_property/services/models/upload_model.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const _Profile();
  }
}

class _Profile extends StatefulWidget {
  const _Profile({Key? key}) : super(key: key);

  @override
  State<_Profile> createState() => _ProfileState();
}

class _ProfileState extends State<_Profile> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<EditProfileCubit>(context).getCurrentUserProfile();
  }

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
          child: BlocConsumer<EditProfileCubit, EditProfileState>(
            listener: (context, state) {
              if (state is EditProfileUnSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message.toString())));
              }
            },
            builder: (context, state) {
              if (state is EditProfileLoading) {
                return Center(child: getCircularProgress());
              } else if (state is UserProfileSuccessState) {
                return Column(
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  FadedScaleAnimation(
                                    child: CircleAvatar(
                                      radius: 40,
                                      backgroundImage: NetworkImage(
                                          state.userInfoModel!.image as String),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              state.userInfoModel!.name as String,
                              style: theme.textTheme.headline6,
                            ),
                            Text(
                              'Since: ${state.userInfoModel!.createdAt as String}',
                              style: theme.textTheme.subtitle2!.copyWith(
                                color: theme.hintColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Phone: ${state.userInfoModel!.phoneNo as String}',
                              style: theme.textTheme.subtitle2!.copyWith(
                                color: theme.hintColor,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Email: ${state.userInfoModel!.email as String}',
                              style: theme.textTheme.subtitle2!.copyWith(
                                color: theme.hintColor,
                                fontSize: 12,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushNamed(Routes.editProfile);
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
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
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
                          padding:
                              const EdgeInsets.all(MyApp.kDefaultPadding * 2),
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
                            state.userInfoModel!.aboutUser as String ,
                            style: theme.textTheme.subtitle1,
                          ),
                        )),
                    const Divider(thickness: 2.0),

                    /// ------ FEEDS --------------
              state.uploadModel!.isEmpty
                        ? Center(
                            child: Text(
                            'Your feeds will be here.. :)',
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                ?.copyWith(
                                    letterSpacing: 1.1,
                                    fontStyle: FontStyle.normal),
                          ))
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: state.uploadModel!.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            itemBuilder: (context, index) {
                              final _data = state.uploadModel![index];

                              return Dismissible(
                                key: UniqueKey(),
                                direction: DismissDirection.endToStart,
                                confirmDismiss:
                                    (DismissDirection direction) async =>
                                        await confirmation(_data),
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
                                  title: _data.title.toString(),
                                  subtitle: _data.description.toString(),
                                  description: _data.address.toString(),
                                  image: _data.thumbnail.toString(),
                                  model: _data,
                                  onTap: () {
                                    Navigator.of(context).pushNamed(
                                        Routes.fixedDetails,
                                        arguments: _data);
                                  },
                                  // hero: _data.image[index],
                                  bookmark: false,
                                  time: '.',
                                ),
                              );
                            }),
                    Padding(
                      padding: const EdgeInsets.all(MyApp.kDefaultPadding),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(Icons.arrow_back_rounded, color: Colors.grey),
                          Text("   Swipe left to dismiss"),
                        ],
                      ),
                    )
                  ],
                );
              }
              // else if(state is UserPropertyDeleteState)
              return const Text('Loading...');
            },
          ),
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
      ),
    );
  }

  confirmation(UploadModel uploadModel) {
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
            BlocListener<DeletePropertyCubit,DeletePropertyState>(
              listener: (context, state) {
                if (state is DeletePropertyUnSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.msg.toString())));
                } else if (state is DeletePropertySuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Successfully  Delete")));
                }
              },
              child: CustomButton(
                  label: MyApp.delete,
                  radius: MyApp.kDefaultPadding - 6,
                  padding: MyApp.kDefaultPadding - 6,
                  textColor: MyApp.kDefaultTextColorWhite,
                  onTap: () {
                    BlocProvider.of<DeletePropertyCubit>(context)
                        .propertyDelete(uploadModel);
                    Navigator.of(context).pop(true);
                  }),
            )
          ],
        );
      },
    );
  }
}
