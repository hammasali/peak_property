import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  final types = {
    'Homes': [
      'House',
      'Flat',
      'Upper Portion',
      'Lower Portion',
      'Farm House',
      'Room',
      'Penthouse'
    ],
    'Plots': [
      'Residential Plot',
      'Commercial Plot',
      'Agricultural Land',
      'Industrial Land',
      'Plot File',
      'Plot Form'
    ],
    'Commercial': [
      'Office',
      'Shop',
      'Warehouse',
      'Factory',
      'Building',
    ]
  };
  var currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mediaQuery = MediaQuery.of(context);

    final myAppBar = AppBar(
      centerTitle: true,
      title: Text(
        MyApp.kAppTitle,
        style: theme.textTheme.headline6,
      ),
      leading: IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: const Icon(
          Icons.cancel_outlined,
          size: MyApp.kDefaultPadding * 2,
        ),
      ),
      elevation: 0,
    );

    final bheight = mediaQuery.size.height -
        mediaQuery.padding.top -
        myAppBar.preferredSize.height;

    return Scaffold(
      appBar: myAppBar,
      backgroundColor: MyApp.kDefaultBackgroundColorWhite,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            propertyPhoto(),
            const Divider(thickness: 2.0),
            properType(),
            const Divider(thickness: 2.0),
            customText('Price Range'),


          ],
        ),
      ),
    );
  }

  customText(String text) {
    return Padding(
      padding: const EdgeInsets.all(MyApp.kDefaultPadding),
      child: Text(text, style: Theme.of(context).textTheme.headline6),
    );
  }

  propertyPhoto() {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      customText("Property Photo"),
      GridView.builder(
          padding: const EdgeInsets.only(
              left: MyApp.kDefaultPadding, right: MyApp.kDefaultPadding),
          physics: const BouncingScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1 / 1.57,
          ),
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'assets/dummy/img_3.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Positioned(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    right: 0.0,
                    top: 0.0,
                  ),
                ],
              );
            }
            if (index == 1) {
              return Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: 100,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      clipBehavior: Clip.hardEdge,
                      child: Image.asset(
                        'assets/dummy/img_4.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Positioned(
                    child: Icon(
                      Icons.cancel,
                      color: Colors.red,
                    ),
                    right: 0.0,
                    top: 0.0,
                  ),
                ],
              );
            }
            return Stack(
              children: [
                Container(
                  height: 150,
                  width: 100,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border:
                          Border.all(color: Theme.of(context).primaryColor)),
                  child: const Icon(
                    Icons.add_business,
                    color: Colors.grey,
                  ),
                ),
                const Positioned(
                  child: Icon(
                    Icons.cancel,
                    color: Colors.transparent,
                  ),
                  right: 0.0,
                  top: 0.0,
                ),
              ],
            );
          }),
    ]);
  }

  properType() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText("Property Type"),
        Center(
          child: ToggleSwitch(
            initialLabelIndex: currentIndex,
            totalSwitches: 3,
            minHeight: 50.0,
            minWidth: 100.0,
            animate: true,
            animationDuration: 500,
            labels: [...types.keys],
            onToggle: (index) {
              setState(() {});
              currentIndex = index;
            },
          ),
        ),
        generateTags(currentIndex),
      ],
    );
  }

  generateTags(int key) {
    switch (key) {
      case 0:
        return CustomChip(title: types.values.first.toList());
      case 2:
        return CustomChip(title: types.values.last.toList());
      default:
        return CustomChip(title: types.values.elementAt(1).toList());
    }
  }
}

class CustomChip extends StatefulWidget {
  final List<String> title;

  const CustomChip({Key? key, required this.title}) : super(key: key);

  @override
  _CustomChipState createState() => _CustomChipState();
}

class _CustomChipState extends State<CustomChip> {
  int? defaultChoiceIndex;

  @override
  void initState() {
    super.initState();
    defaultChoiceIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return FadedSlideAnimation(
      child: Padding(
        padding: const EdgeInsets.all(MyApp.kDefaultPadding),
        child: Wrap(
          spacing: 8.0, // gap between adjacent chips
          runSpacing: 4.0,
          children: List.generate(widget.title.length, (index) {
            return ChoiceChip(
              labelPadding: const EdgeInsets.all(2.0),
              labelStyle: Theme.of(context)
                  .textTheme
                  .bodyText2!
                  .copyWith(color: const Color(0xff807d7d), fontSize: 14),
              label: Text(widget.title[index]),
              selected: defaultChoiceIndex == index,
              selectedColor: Colors.black87,
              visualDensity: VisualDensity.adaptivePlatformDensity,

              shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.black, width: 1),
                borderRadius: BorderRadius.circular(10),
              ),
              onSelected: (value) {
                setState(() {
                  defaultChoiceIndex = value ? index : defaultChoiceIndex;
                });
              },
              // backgroundColor: color,
              elevation: 1,
              padding:
                  const EdgeInsets.symmetric(horizontal: MyApp.kDefaultPadding),
            );
          }),
        ),
      ),
      beginOffset: const Offset(0, 0.3),
      endOffset: const Offset(0, 0),
      slideCurve: Curves.linearToEaseOut,
    );
  }
}

// Padding(
//   padding: const EdgeInsets.all(MyApp.kDefaultPadding),
//   child: Wrap(
//     spacing: 8.0, // gap between adjacent chips
//     runSpacing: 4.0,
//     children: [...generateTags(currentIndex)],
//   ),
// ),

// switch (key) {
//   case 0:
//     return types.values.first.map((e) => customChip(e)).toList();
//   case 2:
//     return types.values.last.map((e) => customChip(e)).toList();
//   default:
//     return types.values.elementAt(1).map((e) => customChip(e)).toList();
// }

// customChip(String title) {
//   bool isActive = false;
//
//   return FadedSlideAnimation(
//     child: ChoiceChip(
//       selected: isActive,
//       selectedColor: Colors.grey[300],
//       disabledColor: Colors.transparent,
//       label: Text(title,
//           style: TextStyle(
//             color: isActive ? Colors.black : Colors.grey,
//           )),
//       backgroundColor: Colors.grey[300],
//       visualDensity: VisualDensity.adaptivePlatformDensity,
//       shape: RoundedRectangleBorder(
//         side: BorderSide(
//             color: isActive ? Colors.black : Colors.transparent,
//             width: isActive ? 1 : 0),
//         borderRadius: BorderRadius.circular(10),
//       ),
//       onSelected: (bool value) {
//         setState(() {
//           isActive = value;
//         });
//       },
//     ),
//     beginOffset: const Offset(0, 0.3),
//     endOffset: const Offset(0, 0),
//     slideCurve: Curves.linearToEaseOut,
//   );
// }
