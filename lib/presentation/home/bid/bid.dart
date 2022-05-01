import 'package:flutter/material.dart';

import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_feeds.dart';
import 'package:peak_property/dummy.dart';

//TODO: CREATE BID DETAIL SCREEN

class Bid extends StatelessWidget {
  const Bid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      shrinkWrap: true,
      padding: const EdgeInsets.symmetric(vertical: 80),
      itemBuilder: (context, index) {
        final _data = data[index];

        return CustomFeeds(
          title: _data.title,
          subtitle: _data.subtitle,
          description: _data.description,
          time: _data.time,
          image: _data.image,
          onTap: () {
            Navigator.of(context).pushNamed(Routes.bidDetails);
          },
          bookmark: false,
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
