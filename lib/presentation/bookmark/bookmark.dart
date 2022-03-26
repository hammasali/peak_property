import 'package:flutter/material.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_feeds.dart';
import 'package:peak_property/dummy.dart';

class Bookmark extends StatelessWidget {
  const Bookmark({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      itemCount: data.length,
      shrinkWrap: true,
      padding: const EdgeInsets.only(top: 5, bottom: 80),
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
          }, bookmark: true,
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
