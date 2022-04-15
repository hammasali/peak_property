import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:peak_property/core/my_app.dart';

class CustomFixed extends StatelessWidget {
  final String image, city, startPrice,endPrice,title;

  const CustomFixed({
    Key? key,
    required this.image,
    required this.city,
    required this.endPrice,
    required this.startPrice,
    required this.title
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10.0),
      width: 210,
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          ///   ============ DESCRIPTION =============
          Positioned(
            bottom: 15.0,
            child: Container(
              height: 110.0,
              width: 200.0,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: Colors.black)),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 150,
                      child: AutoSizeText(
                        '$startPrice - $endPrice' ,
                        style: Theme.of(context).textTheme.headline4,
                        maxLines: 2,
                        minFontSize: 15.0,
                        maxFontSize: 22.0,
                        overflow: TextOverflow.ellipsis,
                        softWrap: true,
                      ),
                    ),
                    SizedBox(
                      width: 150,
                      child: AutoSizeText(
                        "PKR",
                        style: Theme.of(context).textTheme.bodyText2,
                        maxLines: 1,
                      ),
                    ),
                    const SizedBox(
                      height: 4.0,
                    ),
                  ],
                ),
              ),
            ),
          ),

          ///   ============ IMAGE =============
          Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20.0),
                boxShadow: const [
                  BoxShadow(
                      color: Colors.black87,
                      offset: Offset(0.0, 2.0),
                      blurRadius: 6.0)
                ]),
            child: Stack(
              children: [
                Hero(
                  tag: image,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image(
                      image: NetworkImage(image),
                      height: 180.0,
                      width: 180.0,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  left: 10.0,
                  bottom: 10.0,
                  child: Container(
                    width: 180.0,
                    height: 55.0,
                    padding: const EdgeInsets.symmetric(
                        horizontal: MyApp.kDefaultPadding, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.7),
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0))),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                         SizedBox(
                          width: 150,
                          child: AutoSizeText(
                            title,
                            maxLines: 2,
                            minFontSize: 11.0,
                            maxFontSize: 14.0,
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          children:  [
                            const Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 8.0,
                              color: Colors.white54,
                            ),
                            const SizedBox(
                              width: 5.0,
                            ),
                            Text(
                              city,
                              style: const TextStyle(
                                  color: Colors.white54, fontSize: 12),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
