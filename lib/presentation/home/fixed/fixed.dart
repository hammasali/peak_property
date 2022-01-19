import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_feeds.dart';
import 'package:peak_property/dummy.dart';

class Fixed extends StatelessWidget {
  const Fixed({Key? key}) : super(key: key);

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