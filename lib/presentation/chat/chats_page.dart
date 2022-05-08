import 'package:animation_wrappers/animations/faded_scale_animation.dart';
import 'package:animation_wrappers/animations/faded_slide_animation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peak_property/business_logic/cubit/edit_profile_cubit/delete_property_cubit.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/services/models/args.dart';
import 'package:peak_property/services/models/chat_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  late var _fetchUserChatRoom;

  @override
  void initState() {
    super.initState();
    _fetchUserChatRoom = FirebaseRepo.instance.fetchUserChatRoom().snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FadedSlideAnimation(
        beginOffset: const Offset(0, 0.3),
        endOffset: const Offset(0, 0),
        slideCurve: Curves.linearToEaseOut,
        child: Container(
          margin: const EdgeInsets.only(top: 5),
          child: StreamBuilder<QuerySnapshot>(
              stream: _fetchUserChatRoom,
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.all(MyApp.kDefaultPadding),
                    child: Center(child: getCircularProgress()),
                  );
                } else if (snapshot.hasError) {
                  return const Icon(Icons.error_outline);
                } else {
                  return _tiles(snapshot.data!.docs, context);
                }
              }),
        ),
      ),
    );
  }

  Widget _tiles(
      List<QueryDocumentSnapshot<Object?>> docs, BuildContext context) {
    final theme = Theme.of(context);

    return docs.isEmpty
        ? Center(
            child: Text(
            'Chat room will be here.',
            style: Theme.of(context)
                .textTheme
                .headline6
                ?.copyWith(letterSpacing: 1.1, fontStyle: FontStyle.normal),
          ))
        : Column(
            children: [
              ListView.separated(
                physics: const BouncingScrollPhysics(),
                itemCount: docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  ChatModel _data = ChatModel.fromMap(
                      docs[index].data() as Map<String, dynamic>);

                  return Dismissible(
                    key: UniqueKey(),
                    direction: DismissDirection.endToStart,
                    confirmDismiss: (DismissDirection direction) async =>
                        await confirmation(docs[index].id, context),
                    background: Container(
                      padding: const EdgeInsets.all(MyApp.kDefaultPadding),
                      color: const Color(0xffff6666),
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            'Delete',
                            style: theme.textTheme.headline5
                                ?.copyWith(fontSize: 16.0),
                            textHeightBehavior: const TextHeightBehavior(
                                applyHeightToFirstAscent: false),
                            textAlign: TextAlign.left,
                          )),
                    ),
                    child: ListTile(
                      onTap: () {
                        Navigator.of(context).pushNamed(
                            Routes.conversationScreen,
                            arguments: ChatArgs(_data.name as String,
                                _data.photo as String, docs[index].id));
                      },
                      leading: Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 5, 0),
                        child: FadedScaleAnimation(
                          child: CircleAvatar(
                            radius: 24,
                            backgroundImage:
                                NetworkImage(_data.photo as String),
                          ),
                        ),
                      ),
                      title: Text(
                        _data.name as String,
                        style: TextStyle(
                          color: index % 2 == 0
                              ? theme.primaryColor
                              : Colors.black,
                          fontSize: 13.3,
                        ),
                      ),
                      subtitle: Text(
                        _data.message as String,
                        style: theme.textTheme.subtitle2!.copyWith(
                          color: theme.hintColor,
                          fontSize: 10.7,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Text(
                        _data.time as String,
                        style: theme.textTheme.bodyText1!
                            .copyWith(color: Colors.grey, fontSize: 9.3),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const Divider(),
              ),
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

  confirmation(String docId, BuildContext context) {
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
            BlocListener<DeletePropertyCubit, DeletePropertyState>(
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
                        .deleteChat(docId);
                    Navigator.of(context).pop(true);
                  }),
            )
          ],
        );
      },
    );
  }
}
