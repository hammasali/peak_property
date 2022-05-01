import 'dart:io';

import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:peak_property/business_logic/cubit/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:peak_property/business_logic/cubit/image_cubit/image_cubit.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  XFile? _pickedFile;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final aboutController = TextEditingController();
  final usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<EditProfileCubit>(context)
        .getUserProfile(FirebaseRepo.instance.getCurrentUser()!.uid);
  }

  @override
  void dispose() {
    nameController.dispose();
    usernameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    aboutController.dispose();
    super.dispose();
  }

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
          BlocListener<ImageCubit, ImageState>(listener: (context, state) {
            if (state is ProfileImageSuccess) {
              state.imageFileList = null;
            }
          });
        },
        icon: const Icon(
          Icons.chevron_left,
          size: 32,
        ),
      ),
      elevation: 0,
    );
    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;

    return Scaffold(
      appBar: myAppBar,
      body: FadedSlideAnimation(
        child: SingleChildScrollView(
          child: Container(
            color: MyApp.kDefaultBackgroundColorWhite,
            height: bheight,
            child: Column(
              children: [
                image(),
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
                customTextField(
                    nameController, MyApp.fullNameTxt, TextInputType.name),
                Divider(
                  color: Colors.grey[300],
                  thickness: 3,
                ),
                customTextField(
                    usernameController, MyApp.username, TextInputType.name),
                Divider(
                  color: Colors.grey[300],
                  thickness: 3,
                ),
                customTextField(
                    phoneController, MyApp.phoneNo, TextInputType.phone),
                Divider(
                  color: Colors.grey[300],
                  thickness: 3,
                ),
                // customTextField(emailController, MyApp.emailAddress,
                //     TextInputType.emailAddress),
                // Divider(
                //   color: Colors.grey[300],
                //   thickness: 3,
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: aboutController,
                    minLines: 3,
                    maxLines: 5,
                    keyboardType: TextInputType.multiline,
                    decoration: const InputDecoration(
                      label: Text(MyApp.about),
                      hintText: MyApp.aboutHint,
                      hintStyle: TextStyle(color: Colors.grey),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                /// ======= Button ===============

                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                      padding: const EdgeInsets.all(MyApp.kDefaultPadding),
                      child: BlocConsumer<EditProfileCubit, EditProfileState>(
                          builder: (context, state) {
                        if (state is EditProfileLoading) {
                          return getCircularProgress();
                        }
                        return CustomButton(
                          textColor: MyApp.kDefaultBackgroundColorWhite,
                          width: MediaQuery.of(context).size.width,
                          label: MyApp.updateProfile,
                          onTap: () {
                            if (nameController.text.isEmpty ||
                                usernameController.text.isEmpty ||
                                phoneController.text.isEmpty ||
                                emailController.text.isEmpty ||
                                aboutController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text('Field Empty.')));
                            } else {
                              BlocProvider.of<EditProfileCubit>(context)
                                  .updateProfile(
                                      _pickedFile,
                                      nameController.text,
                                      usernameController.text,
                                      phoneController.text,
                                      emailController.text,
                                      aboutController.text);
                            }
                          },
                        );
                      }, listener: (context, state) {
                        if (state is UserProfileSuccessState) {
                          nameController.text =
                              state.userInfoModel!.name.toString();
                          phoneController.text =
                              state.userInfoModel!.phoneNo.toString();
                          emailController.text =
                              state.userInfoModel!.email.toString();
                          aboutController.text =
                              state.userInfoModel!.aboutUser.toString();
                          usernameController.text =
                              state.userInfoModel!.username.toString();
                        }
                        if (state is EditProfileSuccess) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Update Successfully.')));
                        } else if (state is EditProfileUnSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(state.message.toString())));
                        }
                      })),
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

  /// ================ Image ================
  image() {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20),
      width: double.infinity,
      alignment: Alignment.center,
      child: FutureBuilder<void>(
        future: BlocProvider.of<ImageCubit>(context).retrieveLostData(),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return getCircularProgress();
            case ConnectionState.done:
              return _previewImages();
            default:
              if (snapshot.hasError) {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                  'Pick image: ${snapshot.error}}',
                  textAlign: TextAlign.center,
                )));
                return _previewImages();
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                  'You have not yet picked an image.',
                  textAlign: TextAlign.center,
                )));
                return _previewImages();
              }
          }
        },
      ),
    );
  }

  /// =============  Widget  =================
  customTextField(
      TextEditingController controller, String? label, TextInputType type) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      child: TextField(
        controller: controller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(height: 1),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _previewImages() {
    return BlocConsumer<ImageCubit, ImageState>(
        bloc: BlocProvider.of<ImageCubit>(context),
        builder: (context, state) {
          if (state is ProfileImageSuccess) {
            _pickedFile = state.imageFileList;
          }

          return InkWell(
            onTap: () => showSheet(context),
            child: Semantics(
                child: Stack(
                  children: [
                    Semantics(
                        child: FadedScaleAnimation(
                          child: _pickedFile != null
                              ? CircleAvatar(
                                  radius: 60,
                                  backgroundImage: FileImage(
                                    File(_pickedFile!.path),
                                  ),
                                )
                              : const Icon(Icons.account_circle_outlined,
                                  size: 120),
                        ),
                        label: 'Select Photo'),
                    Positioned(
                      right: 0,
                      top: 7,
                      child: Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor,
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
                label: 'Select Photo'),
          );
        },
        listener: (context, state) {
          if (state is ImageUnSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
              'Image error: ${state.message}',
              textAlign: TextAlign.center,
            )));
            state.message = null;
          }
        });
  }

  void showSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            height: 140.0,
            color: MyApp.kDefaultBackgroundColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<ImageCubit>(context).onImageButtonPressed(
                        ImageSource.gallery,
                        isMultiImage: false,
                        isProfileImage: true);
                    Navigator.of(context).pop();
                  },
                  backgroundColor: MyApp.kDefaultButtonColorBlack,
                  heroTag: 'image0',
                  tooltip: 'Pick Image from gallery',
                  child: const Icon(Icons.photo_library),
                ),
                FloatingActionButton(
                  onPressed: () {
                    BlocProvider.of<ImageCubit>(context).onImageButtonPressed(
                        ImageSource.camera,
                        isProfileImage: true);
                    Navigator.of(context).pop();
                  },
                  backgroundColor: MyApp.kDefaultButtonColorBlack,
                  heroTag: 'image1',
                  tooltip: 'Take a Photo',
                  child: const Icon(Icons.camera_alt),
                ),
              ],
            ),
          );
        });
  }
}
