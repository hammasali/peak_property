import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_timer_countdown/flutter_timer_countdown.dart';
import 'package:peak_property/business_logic/bloc/bid_bloc/bid_bloc.dart';
import 'package:peak_property/business_logic/cubit/carouselCubit/carousel_cubit.dart';
import 'package:peak_property/business_logic/cubit/edit_profile_cubit/edit_profile_cubit.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/curved.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/services/models/args.dart';
import 'package:peak_property/services/models/upload_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

class BidDetails extends StatefulWidget {
  final UploadModel model;

  const BidDetails({Key? key, required this.model}) : super(key: key);

  @override
  State<BidDetails> createState() => _BidDetailsState();
}

class _BidDetailsState extends State<BidDetails>
    with SingleTickerProviderStateMixin {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  String? image;
  late String? _currentUserImage;
  String? name;
  final _currentId = FirebaseRepo.instance.getCurrentUser()?.uid;
  late final DateTime endingTime;
  bool timerFinished = false;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<BidBloc>(context).add(GetBidUrls(widget.model));

    BlocProvider.of<EditProfileCubit>(context)
        .getUserProfile(widget.model.uid.toString());

    _getCurrentUserProfilePic();

    endingTime = DateTime.parse(widget.model.endingTime as String);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      appBar: AppBar(
        leading: Container(
          decoration: BoxDecoration(
              shape: BoxShape.circle, color: Colors.white.withOpacity(0.6)),
          child: IconButton(
              iconSize: 25.0,
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_rounded)),
        ),
        centerTitle: true,
        title: Container(
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Container(
            margin: const EdgeInsets.all(10),
            child: BlocBuilder<EditProfileCubit, EditProfileState>(
              builder: (context, state) {
                if (state is UserProfileSuccessState) {
                  image = state.userInfoModel!.image;
                  name = state.userInfoModel!.name;
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            NetworkImage(state.userInfoModel!.image as String),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        flex: 12,
                        child: Text(
                          state.userInfoModel!.name as String,
                          style: Theme.of(context).textTheme.bodyText1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                }

                return const Text("Loading...");
              },
            ),
          ),
        ),
        actions: [
          _currentId == widget.model.uid
              ? Container()
              : IconButton(
                  icon: const Icon(
                    Icons.chat_rounded,
                    size: MyApp.kDefaultIconSize,
                    color: Colors.black87,
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(Routes.conversationScreen,
                        arguments: ChatArgs(
                          name as String,
                          image as String,
                          widget.model.uid as String,
                        ));
                  },
                ),
          const SizedBox(width: 12.0)
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 25.0),
          child: BlocConsumer<BidBloc, BidState>(
            listener: (BuildContext context, Object? state) {
              if (state is BidUnSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.msg.toString())));
              }
            },
            builder: (context, state) {
              if (state is BidLoading) {
                return SizedBox(
                    height: MediaQuery.of(context).size.width,
                    child: Center(child: getCircularProgress()));
              }
              if (state is BidSuccess) {
                return _screen(state.url);
              }
              return const Center(child: Text('Loading...'));
            },
          ),
        ),
      ),
    );
  }

  Widget _screen(List<String> url) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// ----------- Image Slider ------------
        CarouselSlider.builder(
          itemCount: url.length,
          options: CarouselOptions(
              height: 200,
              aspectRatio: 16 / 9,
              viewportFraction: 0.8,
              initialPage: 0,
              enableInfiniteScroll: true,
              reverse: false,
              autoPlay: true,
              autoPlayInterval: const Duration(seconds: 5),
              autoPlayAnimationDuration: const Duration(seconds: 2),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              scrollDirection: Axis.horizontal,
              onPageChanged: (index, reason) {
                BlocProvider.of<CarouselCubit>(context).currentSlide(index);
                _current = context.read<CarouselCubit>().state;
              }),
          itemBuilder: (ctx, index, realIdx) {
            if (url.isEmpty) {
              return Container();
            }

            return Container(
              height: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(30.0),
              ),
              margin: const EdgeInsets.all(1.0),
              child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(5.0)),
                  child: Stack(
                    children: <Widget>[
                      Image.network(
                        url[index],
                        fit: BoxFit.cover,
                        height: 400,
                        width: 300,
                        scale: 0.8,
                        colorBlendMode: BlendMode.darken,
                      ),
                    ],
                  )),
            );
          },
        ),

        BlocBuilder<CarouselCubit, int>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: url.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 12.0,
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(_current == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            );
          },
        ),
        const SizedBox(height: 20.0),

        /// ----------- TIMER ------------

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Bid time :',
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        const SizedBox(height: 5.0),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black, width: 2.0, style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(12.0)),
            child: TimerCountdown(
              format: CountDownTimerFormat.daysHoursMinutesSeconds,
              endTime: endingTime,
              onEnd: () {
                print("Timer finished");
                timerFinished = true;
              },
              timeTextStyle: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              colonsTextStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
              ),
              descriptionTextStyle: const TextStyle(
                color: Colors.red,
                fontSize: 18,
              ),
              daysDescription: "day",
              hoursDescription: "hr",
              minutesDescription: "min",
              secondsDescription: "sec",
              spacerWidth: 20.0,
              enableDescriptions: true,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        const Divider(
          indent: 60,
          endIndent: 60,
          thickness: 2,
        ),
        const SizedBox(
          height: 15,
        ),

        /// ----------- Data Layer ------------

        // Text(
        //   'Atttributes',
        //   style: Theme.of(context).textTheme.headline5,
        // ),

        Container(
          color: Colors.white,
          child: Column(
            children: [
              CurvedListItem(
                title: 'TITLE',
                subtitle: widget.model.title as String,
                color: Colors.teal,
                nextColor: Colors.red,
              ),
              CurvedListItem(
                title: 'DESCRIPTION',
                subtitle: widget.model.description as String,
                color: Colors.red,
                nextColor: Colors.brown,
              ),
              CurvedListItem(
                title: 'CATEGORY',
                subtitle: widget.model.category as String,
                title2: 'TYPE',
                subtitle2: widget.model.type as String,
                color: Colors.brown,
                nextColor: Colors.blue,
              ),
              CurvedListItem(
                title: 'AREA Range',
                subtitle: widget.model.areaRange as String,
                title2: 'AREA TYPE',
                subtitle2: widget.model.areaType as String,
                color: Colors.blue,
                nextColor: Colors.green,
              ),
              CurvedListItem(
                title: 'BEDROOMS & BATHROOMS',
                subtitle: 'Bedrooms: ${widget.model.bedrooms as String} \n'
                    'Bathrooms: ${widget.model.bathrooms as String}',
                color: Colors.green,
                nextColor: Colors.deepOrangeAccent,
              ),
              CurvedListItem(
                title: 'BID TIMEFRAME',
                subtitle: widget.model.bidTime as String,
                color: Colors.deepOrangeAccent,
                nextColor: Colors.pink,
              ),
              CurvedListItem(
                title: 'LOCATION',
                subtitle: '${widget.model.city}, ${widget.model.state}',
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
        Container(
          color: Colors.purpleAccent,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Center(
                child: CustomButton(
              label: 'Place a bid',
              onTap: () {
                Navigator.of(context).pushNamed(Routes.placeBid,
                    arguments: BidArgs(_currentUserImage, widget.model.docId,
                        widget.model.uid, timerFinished));
              },
            )),
          ),
        )
      ],
    );
  }

  void _getCurrentUserProfilePic() async {
    _currentUserImage = await FirebaseRepo.instance
        .getUserProfilePic(FirebaseRepo.instance.getCurrentUser()!.uid);
  }
}
