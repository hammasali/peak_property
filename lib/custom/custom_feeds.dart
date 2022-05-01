import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/services/models/upload_model.dart';

class CustomFeeds extends StatelessWidget {
  final String title, subtitle, description, time, image;
  final onTap, onBookmarktap;
  final bool bookmark;
  final UploadModel? model;

  CustomFeeds(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.description,
      required this.image,
      required this.time,
      required this.bookmark,
      this.model,
      this.onTap,
      this.onBookmarktap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            ///   =========== LEADING ============
            Expanded(
              child: Hero(
                tag: image,
                child: Image.network(
                  image,
                  fit: BoxFit.cover,
                  width: 150,
                  height: 200,
                ),
              ),
            ),
            const SizedBox(
              width: 15.0,
            ),

            ///   =========== CONTENT ============
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20.0),
                SizedBox(
                  width: 150,
                  child: AutoSizeText(
                    title,
                    style: Theme.of(context).textTheme.headline4,
                    maxLines: 3,
                    minFontSize: 15.0,
                    maxFontSize: 25.0,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                  ),
                ),
                const SizedBox(height: 15.0),
                SizedBox(
                    width: 150,
                    child: AutoSizeText(
                      subtitle,
                      style: Theme.of(context).textTheme.bodyText1,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      minFontSize: 14.0,
                    )),
                const SizedBox(height: 8.0),
                SizedBox(
                    width: 150,
                    child: AutoSizeText(
                      description,
                      style: Theme.of(context).textTheme.bodyText2,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      softWrap: true,
                      minFontSize: 14.0,
                    )),
                const SizedBox(height: 8.0),
              ],
            ),

            ///   =========== TIME ===============
            bookmark
                ? Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.6)),
                    child: IconButton(
                        iconSize: 30.0,
                        color: Colors.black,
                        onPressed: onBookmarktap,
                        icon: const Icon(Icons.bookmark)),
                  )
                : FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      time,
                      style: const TextStyle(fontSize: 12.0),
                    ))
          ],
        ),
      ),
    );
  }
}
