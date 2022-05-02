import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:peak_property/business_logic/bloc/bid_bloc/bid_bloc.dart';
import 'package:peak_property/core/my_app.dart';

import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_feeds.dart';

class Bid extends StatefulWidget {
  const Bid({Key? key}) : super(key: key);

  @override
  State<Bid> createState() => _BidState();
}

class _BidState extends State<Bid> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<BidBloc>(context).add(FetchBids());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: Colors.black,
      displacement: 80,
      onRefresh: _onRefresh,
      child: BlocConsumer<BidBloc, BidState>(listener: (context, state) {
        if (state is BidUnSuccess) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.msg.toString())));
        }
      }, builder: (context, state) {
        if (state is BidLoading) {
          return Center(child: getCircularProgress());
        } else if (state is BidSuccess) {
          return ListView.separated(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics()
            ),
            itemCount: state.model.isEmpty ? 1 : state.model.length,
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(vertical: 80),
            itemBuilder: (context, index) {
              if (state.model.isEmpty) {
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
                          'Not Available at this moment',
                          style: Theme.of(context).textTheme.bodyText1,
                        )
                      ],
                    ),
                  ),
                );
              }

              final _data = state.model[index];

              return CustomFeeds(
                title: _data.title as String,
                subtitle: _data.description.toString(),
                description: _data.address.toString(),
                image: _data.thumbnail.toString(),
                time: '.',
                onTap: () {
                  Navigator.of(context)
                      .pushNamed(Routes.bidDetails, arguments: _data);
                },
                bookmark: false,
              );
            },
            separatorBuilder: (context, index) => const Divider(),
          );
        } else {
          return const Text('Something went wrong');
        }
      }),
    );
  }

  Future<void> _onRefresh() {
    Completer<void> completer = Completer<void>();
    Timer(const Duration(seconds: 1), () {
      BlocProvider.of<BidBloc>(context).add(FetchBids());
      completer.complete();
    });
    return completer.future;
  }
}
