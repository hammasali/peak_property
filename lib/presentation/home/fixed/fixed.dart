import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/routes.dart';
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

        return InkWell(
          onTap: () {
            Navigator.of(context)
                .pushNamed(Routes.fixedDetails, arguments: _data.image);
          },
          child: Card(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                ///   =========== LEADING ============
                Expanded(
                  child: Hero(
                    tag: _data.image,
                    child: Image.asset(
                      _data.image,
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
                        _data.title,
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
                          _data.subtitle,
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
                          _data.description,
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
                FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      _data.time,
                      style: TextStyle(fontSize: 12.0),
                    ))
              ],
            ),
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(),
    );
  }
}
