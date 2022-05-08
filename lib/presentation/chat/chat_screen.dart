import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peak_property/business_logic/cubit/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/services/models/args.dart';
import 'package:peak_property/services/models/chat_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

class ChatSingleScreen extends StatefulWidget {
  final ChatArgs args;

  const ChatSingleScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<ChatSingleScreen> createState() => _ChatSingleScreenState();
}

class _ChatSingleScreenState extends State<ChatSingleScreen> {
  TextEditingController? _controller;
  ScrollController? _listController;
  Query? _fetchChat;
  var _currentUser;
  bool? _isWriting;
  late String senderName;
  late String senderImageUrl;

  @override
  void initState() {
    _fetchChat = FirebaseRepo.instance.fetchUserChat(widget.args.uid);
    _currentUser = FirebaseRepo.instance.getCurrentUser()!.uid;
    BlocProvider.of<EditProfileCubit>(context).getUserProfile(_currentUser);
    _controller = TextEditingController();
    _listController = ScrollController();
    _isWriting = false;

    print('UID ${widget.args.uid}');

    super.initState();
  }

  @override
  void dispose() {
    _controller!.dispose();
    _listController!.dispose();
    super.dispose();
  }

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
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(widget.args.image),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Text(
              widget.args.name,
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

    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is UserProfileSuccessState) {
          senderName = state.userInfoModel!.name as String;
          senderImageUrl = state.userInfoModel!.image as String;
        }
      },
      child: Scaffold(
        appBar: myAppBar,
        body: FadedSlideAnimation(
          child: Column(
            children: [
              StreamBuilder<QuerySnapshot>(
                stream: _fetchChat!.snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: getCircularProgress(),
                    );
                  } else if (snapshot.hasError) {
                    return const Icon(Icons.error_outline);
                  } else {
                    return Expanded(child: chats(snapshot.data!.docs));
                  }
                },
              ),
              message(context),
            ],
          ),
          beginOffset: const Offset(0, 0.3),
          endOffset: const Offset(0, 0),
          slideCurve: Curves.linearToEaseOut,
        ),
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
            child: TextField(
              controller: _controller,
              autofocus: false,
              onChanged: (val) {
                (val.isNotEmpty && val.trim() != '')
                    ? setState(() {
                        _isWriting = true;
                      })
                    : setState(() {
                        _isWriting = false;
                      });
              },
              keyboardType: TextInputType.multiline,
              cursorColor: theme.primaryColor,
              decoration: const InputDecoration(
                hintText: "Write Your Comment",
                hintStyle: TextStyle(fontSize: 14),
                border: InputBorder.none,
              ),
            ),
          ),
          const Spacer(),
          _isWriting == true
              ? Expanded(
                  child: IconButton(
                    icon: Icon(
                      Icons.send,
                      color: theme.primaryColor,
                      size: 22,
                    ),
                    onPressed: () {
                      FirebaseRepo.instance.addMessageToDB(
                          message: _controller!.text,
                          receiverId: widget.args.uid,
                          receiverName: widget.args.name,
                          receiverImageUrl: widget.args.image,
                          senderName: senderName,
                          senderImageUrl: senderImageUrl);
                      _controller!.text = '';
                      setState(() {
                        _isWriting = false;
                      });
                    },
                  ),
                )
              : const Expanded(
                  child: IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.send,
                        color: Colors.grey,
                        size: 22,
                      )),
                ),
          const SizedBox(
            width: 5,
          ),
        ],
      ),
    );
  }

  sender(BuildContext context, String msg, String time) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    return FadedScaleAnimation(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 8),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor,
                ),
                // width: mediaQuery.size.width * 0.7,
                width: mediaQuery.size.width * 0.7,
                alignment: Alignment.centerRight,
                child: Text(
                  msg,
                  style: theme.textTheme.bodyText1!
                      .copyWith(fontSize: 14.7, color: Colors.white),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  receiver(BuildContext context, String msg, String time) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);
    return FadedScaleAnimation(
      child: Column(
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
                width: mediaQuery.size.width * 0.7,
                alignment: Alignment.centerLeft,
                child: Text(
                  msg,
                  style: theme.textTheme.bodyText1!
                      .copyWith(fontSize: 14.7, color: Colors.black),
                ),
              ),
              Text(
                time,
                style: const TextStyle(color: Colors.grey, fontSize: 8),
              ),
            ],
          ),
        ],
      ),
    );
  }

  chats(List<QueryDocumentSnapshot> docs) {
    if (docs.isEmpty) {
      return Center(
          child: Text(
        'Send Your Greetings :)',
        style: Theme.of(context)
            .textTheme
            .headline6
            ?.copyWith(letterSpacing: 1.1, fontStyle: FontStyle.normal),
      ));
    }

    ///This is to get the bottom of list when new message arrives. It will call
    ///every time whenever the setState calls / UI change
    SchedulerBinding.instance!.addPostFrameCallback((_) {
      _listController!.animateTo(_listController!.position.maxScrollExtent,
          duration: const Duration(microseconds: 250), curve: Curves.easeInOut);
    });

    return ListView.builder(
        controller: _listController,
        itemCount: docs.length,
        itemBuilder: (BuildContext context, int index) {
          var data =
              ChatModel.fromMap(docs[index].data() as Map<String, dynamic>);

          return data.senderId == _currentUser
              ? sender(context, data.message.toString(), data.time.toString())
              : receiver(
                  context, data.message.toString(), data.time.toString());
        });
  }
}

/// =============================================================

// import 'dart:typed_data';
//
// import 'package:firebase_chat/firebase_chat.dart';
// import 'package:flutter/material.dart';
// import 'package:peak_property/core/my_app.dart';
// import 'package:peak_property/core/routes.dart';
//
// class ChatSingleScreen extends StatefulWidget {
//   const ChatSingleScreen({Key? key}) : super(key: key);
//
//   @override
//   State<ChatSingleScreen> createState() => _ChatSingleScreenState();
// }
//
// class _ChatSingleScreenState extends State<ChatSingleScreen> {
//   late Map<String, PeerUser> peers;
//
//   @override
//   void initState() {
//     super.initState();
//     peers = {
//       'myId': PeerUser(documentId: 'OW3V8T6jd8hCRcctDmspWFDONJh1', name: 'Hammas'),
//       'otherId': PeerUser(
//           documentId: 'OW3V8T6jd8hCRcctDmspWFDONJh1',
//           name: 'Shahwar',
//           image:
//               'https://cdn.vox-cdn.com/thumbor/SRwHbaTMxPr4f8EJdfai_UR2y34=/1400x1050/filters:format(jpeg)/cdn.vox-cdn.com/uploads/chorus_asset/file/6434955/obi-wan.0.jpg'),
//     };
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     print('${peers['myId']} : $peers  ${peers['otherId']?.name}');
//
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Chat App'),
//         ),
//         body: ChatPage(
//           ChatEntity(
//             mainUser: peers['myId'] as PeerUser,
//             peers: peers,
//             path: 'Chats/chatId',
//             title: peers['otherId']?.name,
//           ),
//         ));
//   }
// }
//
// class ChatPage extends BaseChat {
//   ChatPage(
//     ChatEntity entity,
//   ) : super(entity);
//
//   @override
//   _ChatPageState createState() => _ChatPageState();
// }
//
// class _ChatPageState extends BaseChatState<ChatPage> {
//   @override
//   Color get primaryColor => Theme.of(context).iconTheme.color as Color;
//
//   @override
//   Color get secondaryColor => Colors.blue;
//
//   @override
//   Widget get loadingWidget => Center(
//         child: Padding(
//           padding: const EdgeInsets.all(30.0),
//           child: getCircularProgress(),
//         ),
//       );
//
//   @override
//   Widget get emptyWidget => const Center(
//           child: Padding(
//         padding: EdgeInsets.all(40.0),
//         child: Text("Welcome"),
//       ));
//
//   @override
//   Widget errorWidget(String error) => Center(child: Text(error));
//
//   @override
//   Future editAndUpload(Uint8List data) async {
//     Uint8List? edited = await Navigator.of(context).pushNamed<Uint8List>(
//         Routes.drawPage,
//         arguments: DrawPageArgs(data, loadingWidget));
//     sendImage(edited);
//   }
//
// //TODO: HAndle error after aftar
//   @override
//   Future getImage() async {
//     List<Uint8List>? images;
//     images = await Navigator.of(context).pushNamed(Routes.cameraPage);
//     if (images != null && images.length == 1) {
//       Uint8List? image = await Navigator.of(context).pushNamed(Routes.drawPage,
//           arguments: DrawPageArgs(images[0], loadingWidget));
//       if (image == null) return null;
//       images = [image];
//     }
//
//     if (images != null) {
//       for (var image in images) {
//         await sendImage(image);
//       }
//     }
//   }
//
//   @override
//   Widget inputBuilder(BuildContext context, ChatInputState state) {
//     return SafeArea(
//       bottom: true,
//       top: false,
//       child: Container(
//         color: MyApp.kDefaultBackgroundColor,
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.end,
//           children: <Widget>[
//             if (state is InputEmptyState)
//               Material(
//                 child: IconButton(
//                   icon: Icon(Icons.add_a_photo,
//                       color: Theme.of(context).iconTheme.color),
//                   onPressed: () => getImage(),
//                   color: primaryColor,
//                   disabledColor: Colors.grey,
//                 ),
//                 color: MyApp.kDefaultBackgroundColor,
//               ),
//
//             Expanded(
//               child: Container(
//                 padding: const EdgeInsets.all(10),
//                 child: TextField(
//                   onSubmitted: (text) {
//                     if (text.isNotEmpty) sendMessage();
//                   },
//                   autofocus: false,
//                   maxLines: null,
//                   keyboardType: TextInputType.text,
//                   style: const TextStyle(fontSize: 20.0),
//                   controller: textEditingController,
//                   onChanged: inputChanged,
//                   cursorColor: Theme.of(context).primaryColor,
//                   decoration: const InputDecoration.collapsed(
//                     hintText: "Type here",
//                     hintStyle: TextStyle(color: Colors.grey),
//                   ),
//                 ),
//               ),
//             ),
//
//             // Send message button
//             Material(
//               child: Container(
//                 margin: const EdgeInsets.only(right: 4.0),
//                 child: IconButton(
//                   icon: const Icon(Icons.send),
//                   onPressed: state is ReadyToSendState ? sendMessage : null,
//                   color: primaryColor,
//                   disabledColor: Colors.grey,
//                 ),
//               ),
//               color: MyApp.kDefaultBackgroundColor,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class DrawPageArgs {
//   Uint8List uint8list;
//   Widget widget;
//
//   DrawPageArgs(this.uint8list, this.widget);
// }
