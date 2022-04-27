import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peak_property/business_logic/cubit/bookmark_cubit/bookmark_cubit.dart';
import 'package:peak_property/business_logic/cubit/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:peak_property/business_logic/cubit/fixed_detail_cubit/fixed_detail_cubit.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/custom/curved.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

class FixedDetailScreen extends StatelessWidget {
  final UploadModel model;

  const FixedDetailScreen({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => FixedDetailCubit(),
        ),
        BlocProvider(
          create: (context) => BookmarkCubit(),
        ),
      ],
      child: _FixedDetailScreen(model: model),
    );
  }
}

class _FixedDetailScreen extends StatefulWidget {
  final UploadModel model;

  const _FixedDetailScreen({Key? key, required this.model}) : super(key: key);

  @override
  State<_FixedDetailScreen> createState() => _FixedDetailScreenState();
}

class _FixedDetailScreenState extends State<_FixedDetailScreen> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<FixedDetailCubit>(context).getUrls(widget.model);
    BlocProvider.of<EditProfileCubit>(context)
        .getUserProfile(widget.model.uid.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      appBar: AppBar(toolbarHeight: 0),
      body: Column(
        children: [
          Stack(
            children: [

              ///  ============= Header ================

              BlocConsumer<FixedDetailCubit, FixedDetailState>(
                builder: (context, state) {
                  if (state is FixedDetailLoading) {
                    return SizedBox(
                        height: MediaQuery
                            .of(context)
                            .size
                            .width,
                        child: Center(child: getCircularProgress()));
                  }
                  if (state is FixedDetailSuccess) {
                    return CarouselSlider.builder(
                      itemCount: state.url.length,
                      options: CarouselOptions(
                          aspectRatio: 2.0,
                          enlargeCenterPage: true,
                          autoPlay: true,
                          reverse: true,
                          height: MediaQuery
                              .of(context)
                              .size
                              .width),
                      itemBuilder: (ctx, index, realIdx) {
                        return Container(
                          decoration: BoxDecoration(
                              color: Colors.black87,
                              borderRadius: BorderRadius.circular(30.0),
                              boxShadow: const [
                                BoxShadow(
                                    color: Colors.black87,
                                    offset: Offset(0.0, 2.0),
                                    blurRadius: 6.0)
                              ]),
                          child: Hero(
                            tag: widget.model.thumbnail.toString(),
                            child: ClipRRect(
                              // borderRadius: BorderRadius.circular(30.0),
                              child: Image(
                                image: NetworkImage(
                                  state.url[index],
                                ),
                                height: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                width: MediaQuery
                                    .of(context)
                                    .size
                                    .width,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: Text('Wait'));
                },
                listener: (BuildContext context, Object? state) {
                  if (state is FixedDetailUnSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.msg.toString())));
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white.withOpacity(0.6)),
                      child: IconButton(
                          iconSize: 25.0,
                          color: Colors.black,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_ios_rounded)),
                    ),
                    FutureBuilder<bool>(
                        future: FirebaseRepo.instance
                            .getBookmark(widget.model.docId),
                        builder: (context, snapshot) {
                          isBookmarked = snapshot.data ?? false;

                          return BlocBuilder<BookmarkCubit, BookmarkState>(
                            builder: ((context, state) {
                              if (state is BookmarkSuccessState) {
                                isBookmarked = state.isBookmarked;
                              }
                              return Container(
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white.withOpacity(0.6)),
                                child: IconButton(
                                    iconSize: 30.0,
                                    color: Colors.black,
                                    onPressed: () {
                                      BlocProvider.of<BookmarkCubit>(context)
                                          .isBookmarked(
                                          isBookmarked, widget.model);
                                    },
                                    icon: Icon(isBookmarked
                                        ? Icons.bookmark_added
                                        : Icons.bookmark_add_outlined)),
                              );
                            }),
                          );
                        }),
                  ],
                ),
              ),
              Positioned(
                left: 20.0,
                bottom: 20.0,
                child: Container(
                  width: MediaQuery
                      .of(context)
                      .size
                      .width,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.6),
                      borderRadius: const BorderRadiusDirectional.only(
                          topStart: Radius.circular(12.0))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 6.0),
                        child: SizedBox(
                          width: 250,
                          child: AutoSizeText(
                            widget.model.title as String,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            maxLines: 2,
                            minFontSize: 15.0,
                            style: const TextStyle(
                              fontSize: 23.0,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(
                            FontAwesomeIcons.locationArrow,
                            size: 10.0,
                            color: Colors.black87,
                          ),
                          const SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            '${widget.model.city as String}, ${widget.model
                                .state as String}',
                            style: const TextStyle(
                                fontSize: 15.0, color: Colors.black87),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const Positioned(
                  right: 20.0,
                  bottom: 20.0,
                  child: Icon(
                    Icons.location_on,
                    size: 20.0,
                    color: Colors.black87,
                  ))
            ],
          ),

          /// ============= Profile ===================

          Container(
            decoration: const BoxDecoration(
              color: Color(0xfff1f1f1),
            ),
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: BlocBuilder<EditProfileCubit, EditProfileState>(
                    builder: (context, state) {
                      if (state is UserProfileSuccessState) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                              NetworkImage(state.model.image as String),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              flex: 12,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    state.model.name as String,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    state.model.username as String,
                                    style: Theme
                                        .of(context)
                                        .textTheme
                                        .bodyText1!
                                        .copyWith(
                                        color: Colors.grey, fontSize: 11),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            const Spacer(),
                            const Icon(
                              Icons.chat_outlined,
                              size: MyApp.kDefaultIconSize,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 10),
                          ],
                        );
                      }
                      return const Text("Loading...");
                    },
                  ),
                ),
              ],
            ),
          ),

          ///============= Attributes ==============

          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  CurvedListItem(
                    title: 'DESCRIPTION',
                    subtitle: widget.model.description as String,
                    color: Colors.red,
                    nextColor: Colors.green,
                  ),
                  CurvedListItem(
                    title: 'CATEGORY',
                    subtitle: widget.model.category as String,
                    title2: 'TYPE',
                    subtitle2: widget.model.type as String,
                    color: Colors.green,
                    nextColor: Colors.blue,
                  ),
                  CurvedListItem(
                    title: 'AREA Range',
                    subtitle: widget.model.areaRange as String,
                    title2: 'AREA TYPE',
                    subtitle2: widget.model.areaType as String,
                    color: Colors.blue,
                    nextColor: Colors.brown,
                  ),
                  CurvedListItem(
                    title: 'BEDROOMS & BATHROOMS',
                    subtitle: 'Bedrooms: ${widget.model.bedrooms as String} \n'
                        'Bathrooms: ${widget.model.bathrooms as String}',
                    color: Colors.brown,
                    nextColor: Colors.pink,
                  ),
                  CurvedListItem(
                    title: 'PRICE RANGE',
                    subtitle: '${widget.model.startPrice as String} - ${widget.model.endPrice as String}',
                    color: Colors.pink,
                    nextColor: Colors.purpleAccent,
                  ),
                  CurvedListItem(
                    title: 'ADDRESS',
                    subtitle: widget.model.address as String,
                    color: Colors.purpleAccent,
                    nextColor: Colors.purpleAccent,
                  ),

                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}