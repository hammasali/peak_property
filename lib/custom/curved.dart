import 'package:flutter/material.dart';

class CurvedListItem extends StatelessWidget {
  const CurvedListItem({
    Key? key,
    required this.subtitle,
    required this.title,
    this.subtitle2,
    this.title2,
    this.icon,
    this.color,
    this.nextColor,
  }) : super(key: key);

  final String title;
  final String subtitle;
  final String? title2;
  final String? subtitle2;
  final IconData? icon;
  final Color? color;
  final Color? nextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: nextColor,
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(80.0),
          ),
        ),
        padding: const EdgeInsets.only(
          left: 32,
          top: 80.0,
          bottom: 50,
          right: 32,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      title,
                      style: const TextStyle(color: Colors.white, fontSize: 12),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      subtitle,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                  ]),
            ),
            title2 != null
                ? Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            title2 ?? '',
                            style: const TextStyle(
                                color: Colors.white, fontSize: 12),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            subtitle2 ?? '',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ]),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
