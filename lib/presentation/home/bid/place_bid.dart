import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peak_property/business_logic/bloc/bid_bloc/bid_bloc.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/services/models/args.dart';
import 'package:peak_property/services/models/bider_model.dart';
import 'package:peak_property/services/repository/firebase_repo.dart';

class PlaceBidScreen extends StatefulWidget {
  final BidArgs args;

  const PlaceBidScreen({Key? key, required this.args}) : super(key: key);

  @override
  State<PlaceBidScreen> createState() => _PlaceBidScreenState();
}

class _PlaceBidScreenState extends State<PlaceBidScreen> {
  final TextEditingController amount = TextEditingController();

  late final Stream<QuerySnapshot> _stream;
  final _currentId = FirebaseRepo.instance.getCurrentUser()?.uid;

  BidersModel? starBider;

  @override
  void initState() {
    super.initState();
    _stream = FirebaseRepo.instance
        .getBiders(widget.args.docId, widget.args.uid)
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2.8;
    final double itemWidth = size.width / 2;
    final double result = (itemWidth / itemHeight);

    return Scaffold(
      backgroundColor: const Color(0xfff1f1f1),
      appBar: AppBar(
        backgroundColor: const Color(0xfff1f1f1),
        elevation: 0.0,
        leading: Container(
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
          ),
          child: IconButton(
              iconSize: 25.0,
              color: Colors.black,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios_rounded)),
        ),
        actions: [
          widget.args.timerFinished
              ? const Image(
                  image: AssetImage('assets/pp.png'),
                  fit: BoxFit.scaleDown,
                  height: 100)
              : TextButton(
                  onPressed: () => _showDialog(context),
                  child: Text(
                    'Place a bid',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        ?.copyWith(fontSize: 16.0, letterSpacing: 1.1),
                  )),
          const SizedBox(width: 24.0)
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Center(child: Text('Something went wrong'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: getCircularProgress());
            } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text(
                'No one has bid yet, Place your bid.',
                style: Theme.of(context)
                    .textTheme
                    .headline5
                    ?.copyWith(fontSize: 16),
              ));
            } else {
              var _starBider = snapshot.data!.docs;
              if (_starBider.isNotEmpty) {
                _starBider.sort((a, b) => int.parse(a.get('price'))
                    .compareTo(int.parse(b.get('price'))));
                starBider = BidersModel.fromMap(
                    _starBider.last.data() as Map<String, dynamic>);
              }

              return SingleChildScrollView(
                child: Column(
                  children: [
                    /// ----------- Star Biders -------------

                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Text(
                        'Star Bider',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    FadedScaleAnimation(
                      fadeCurve: Curves.linearToEaseOut,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 50.0),
                        padding: const EdgeInsets.only(top: 4.0, bottom: 2.0),
                        child: Column(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12.0),
                              child: Image.network(
                                starBider!.image as String,
                                width: 100,
                                height: 100,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        starBider!.price as String,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ),
                                ),
                                widget.args.timerFinished &&
                                        _currentId != starBider!.uid
                                    ? InkWell(
                                        onTap: () {
                                          FirebaseRepo.instance
                                              .getUserProfile(
                                                  starBider!.uid.toString())
                                              .get()
                                              .then((value) {
                                            Navigator.of(context).pushNamed(
                                                Routes.conversationScreen,
                                                arguments: ChatArgs(
                                                  value.get('name'),
                                                  starBider!.image as String,
                                                  starBider!.uid as String,
                                                ));
                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.only(
                                              left: 8.0, right: 8.0, top: 8.0),
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              color: Colors.black,
                                              border: Border.all(width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(12.0)),
                                          child: Center(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              child: Text(
                                                'Message',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText1!
                                                    .copyWith(
                                                        color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : Container()
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const Divider(),

                    /// ----------- Biders -------------

                    GridView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: MyApp.kDefaultPadding / 2),
                      physics: const BouncingScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          childAspectRatio: result,
                          crossAxisCount: 3,
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 20.0),
                      children:
                          snapshot.data!.docs.map((DocumentSnapshot document) {
                        BidersModel model = BidersModel.fromMap(
                            document.data()! as Map<String, dynamic>);

                        return FadedScaleAnimation(
                          fadeCurve: Curves.linearToEaseOut,
                          child: Container(
                            padding:
                                const EdgeInsets.only(top: 4.0, bottom: 2.0),
                            decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1.0, color: Colors.grey),
                                borderRadius: BorderRadius.circular(12.0)),
                            child: Column(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: Image.network(
                                    model.image as String,
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  padding: const EdgeInsets.all(8.0),
                                  decoration: BoxDecoration(
                                      border: Border.all(width: 2.0),
                                      borderRadius:
                                          BorderRadius.circular(12.0)),
                                  child: Center(
                                    child: FittedBox(
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        model.price as String,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    )
                  ],
                ),
              );
            }
          }),
    );
  }

  _showDialog(context) {
    return showDialog(
        context: context,
        builder: (context) {
          return FadedScaleAnimation(
            fadeCurve: Curves.slowMiddle,
            child: AlertDialog(
              title: const Text('Enter the amount'),
              content: Container(
                height: 80,
                width: 150,
                padding: const EdgeInsets.symmetric(
                    horizontal: MyApp.kDefaultPadding),
                child: Center(
                  child: TextFormField(
                    controller: amount,
                    maxLength: 9,
                    keyboardType: TextInputType.number,
                    cursorColor: Colors.black,
                    decoration: const InputDecoration(
                      fillColor: Colors.black,
                      isDense: true,
                      hintText: '0',
                      hintStyle: TextStyle(color: Colors.grey),
                      focusColor: Colors.black,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ),
              alignment: Alignment.center,
              actions: <Widget>[
                BlocConsumer<BidBloc, BidState>(
                  listener: (context, state) {
                    if (state is BidSuccess) {
                      Navigator.of(context).pop(true);
                    } else if (state is BidUnSuccess) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.msg.toString())));
                    }
                  },
                  builder: (context, state) {
                    if (state is BidLoading) {
                      return getCircularProgress();
                    }

                    return CustomButton(
                      label: "OK",
                      color: MyApp.kDefaultBackgroundColorWhite,
                      textColor: MyApp.kDefaultTextColorBlack,
                      onTap: () {
                        if (amount.text.isNotEmpty) {
                          BlocProvider.of<BidBloc>(context).add(PlaceBid(
                              amount.text,
                              widget.args.currentUserImage as String,
                              widget.args.docId as String,
                              widget.args.uid as String));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Place your bid.')));
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          );
        });
  }
}
