import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_feeds.dart';
import 'package:peak_property/custom/custom_fixed.dart';
import 'package:peak_property/dummy.dart';

//TODO: INTERCHANGE BID SYSTEM INTO FIXED SYSTEM i.e.
//TODO: change files name or copy the code from bid to fix and fix to bid
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
          hero: _data.image[index],
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.fixedDetails, arguments: _data.image);
          },
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
