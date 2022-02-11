import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/core/routes.dart';
import 'package:peak_property/custom/custom_feeds.dart';
import 'package:peak_property/custom/custom_fixed.dart';
import 'package:peak_property/dummy.dart';



class Fixed extends StatelessWidget {
  const Fixed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 80),
          customType('Homes', context),
          customList(),
          customType('Plots', context),
          customList(),
          customType('Commercials', context),
          customList(),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  customType(String s, BuildContext context) => Container(
    margin: const EdgeInsets.only(
      left: MyApp.kDefaultPadding,
      bottom: MyApp.kDefaultPadding,
    ),
    child: Text(
      s,
      style: Theme.of(context).textTheme.headline4,
    ),
  );

  customList() => SizedBox(
    height: 300.0,
    child: ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: data.length,
      itemBuilder: (BuildContext context, int index) {
        final _data = data[index];
        return GestureDetector(
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.fixedDetails, arguments: _data.image);
          },
          child: CustomFixed(
              image: _data.image,
              city: 'Lahore',
              price: '10,000 to 1Lac',
              title: 'Title'),
        );
      },
    ),
  );

}
