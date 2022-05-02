import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peak_property/business_logic/bloc/bookmark_bloc/bookmark_bloc.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_feeds.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BookmarkBloc(),
      child: const _Bookmark(),
    );
  }
}

class _Bookmark extends StatefulWidget {
  const _Bookmark({Key? key}) : super(key: key);

  @override
  State<_Bookmark> createState() => _BookmarkState();
}

class _BookmarkState extends State<_Bookmark> {
  Stream<QuerySnapshot> data =
      FirebaseRepo.instance.fetchBookmark().snapshots();

  @override
  void initState() {
    super.initState();
    // BlocProvider.of<BookmarkBloc>(context).add(FetchAllBookmarks());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: data,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: getCircularProgress());
        }

        if (snapshot.hasData) {
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot e) {
              return FutureBuilder<String>(
                  future: FirebaseRepo.instance.downloadAllUserURLs(
                      e.get('uid'), e.get('pickedFilesName')[0]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      UploadModel _data = UploadModel.fromMap(
                          e.data() as Map<String, dynamic>,
                          snapshot.data,
                          e.id);

                      return CustomFeeds(
                        title: _data.title.toString(),
                        subtitle: _data.description.toString(),
                        description: _data.address.toString(),
                        image: _data.thumbnail.toString(),
                        onTap: () {
                          Navigator.of(context)
                              .pushNamed(Routes.fixedDetails, arguments: _data);
                        },
                        onBookmarktap: () {
                          BlocProvider.of<BookmarkBloc>(context)
                              .add(IsBookmarked(true, _data));
                        },
                        bookmark: true,
                        time: '',
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width / 4),
                      child: Center(
                        child: getCircularProgress(),
                      ),
                    );
                  });
            }).toList(),
          );
        }

        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 4),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage('assets/cloud.png'),
                  height: 50,
                  width: 50,
                ),
                Text(
                  'Bookmark Property',
                  style: Theme.of(context).textTheme.bodyText1,
                )
              ],
            ),
          ),
        );
      },
    );

    // return BlocConsumer<BookmarkBloc, BookmarkState>(
    //   builder: (context, state) {
    //     if (state is BookmarkLoading) {
    //       return Center(child: getCircularProgress());
    //     } else if (state is BookmarkSuccessState) {
    //       var isBookmarked = !state.isBookmarked;
    //
    //       return state.model.isEmpty
    //           ? Padding(
    //               padding: EdgeInsets.symmetric(
    //                   horizontal: MediaQuery.of(context).size.width / 4),
    //               child: Center(
    //                 child: Column(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     const Image(
    //                       image: AssetImage('assets/cloud.png'),
    //                       height: 50,
    //                       width: 50,
    //                     ),
    //                     Text(
    //                       'Bookmark Property',
    //                       style: Theme.of(context).textTheme.bodyText1,
    //                     )
    //                   ],
    //                 ),
    //               ),
    //             )
    //           : RefreshIndicator(
    //               color: Colors.black,
    //               displacement: 60,
    //               onRefresh: _onRefresh,
    //               child: ListView.separated(
    //                 physics: const BouncingScrollPhysics(
    //                   parent: AlwaysScrollableScrollPhysics(),
    //                 ),
    //                 itemCount: state.model.length,
    //                 shrinkWrap: true,
    //                 padding: const EdgeInsets.only(top: 5, bottom: 80),
    //                 itemBuilder: (context, index) {
    //                   final _data = state.model[index];
    //
    //                   return CustomFeeds(
    //                     title: _data.title.toString(),
    //                     subtitle: _data.description.toString(),
    //                     description: _data.address.toString(),
    //                     image: _data.thumbnail.toString(),
    //                     onTap: () {
    //                       Navigator.of(context)
    //                           .pushNamed(Routes.fixedDetails, arguments: _data);
    //                     },
    //                     onBookmarktap: () {
    //                       BlocProvider.of<BookmarkBloc>(context)
    //                           .add(IsBookmarked(isBookmarked, _data));
    //                     },
    //                     isBookmarked: isBookmarked,
    //                     bookmark: true,
    //                     time: '',
    //                     model: _data,
    //                   );
    //                 },
    //                 separatorBuilder: (context, index) => const Divider(),
    //               ),
    //             );
    //     } else {
    //       return Padding(
    //         padding: EdgeInsets.symmetric(
    //             horizontal: MediaQuery.of(context).size.width / 4),
    //         child: Center(
    //           child: Column(
    //             mainAxisAlignment: MainAxisAlignment.center,
    //             children: [
    //               const Image(
    //                 image: AssetImage('assets/cloud.png'),
    //                 height: 50,
    //                 width: 50,
    //               ),
    //               Text(
    //                 'Bookmark Property',
    //                 style: Theme.of(context).textTheme.bodyText1,
    //               )
    //             ],
    //           ),
    //         ),
    //       );
    //     }
    //   },
    //   listener: (context, state) {
    //     if (state is BookmarkUnSuccessState) {
    //       ScaffoldMessenger.of(context)
    //           .showSnackBar(SnackBar(content: Text(state.msg)));
    //     }
    //   },
    // );
  }

// Future<void> _onRefresh() {
//   Completer<void> completer = Completer<void>();
//   Timer timer = Timer(const Duration(seconds: 1), () {
//     BlocProvider.of<BookmarkBloc>(context).add(FetchAllBookmarks());
//     completer.complete();
//   });
//
//   return completer.future;
// }
}
