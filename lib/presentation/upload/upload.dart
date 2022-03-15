import 'package:animation_wrappers/animation_wrappers.dart';
import 'package:chips_choice_null_safety/chips_choice_null_safety.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  String _selectedAreaUnit = 'Marla';

  int _groupValue = 0;

  var currentIndex = 0;

  int bedTag = 5;
  int bathTag = 1;

  double currentTime = 3;
  double minTime = 1;
  double maxTime = 9;
  int timeDivision = 8;

  double currentBed = 3;
  double minBed = 1;
  double maxBed = 11;
  int bedDivision = 10;

  double currentBath = 2;
  double minBath = 1;
  double maxBath = 11;
  int bathDivision = 10;

  double currentArea = 300;
  double minArea = 0;
  double maxArea = 1000;
  int areaDivision = 20;

  double _starValue = 90000;
  double _endValue = 800000;
  double minValue = 0.0;
  double maxValue = 1000000.0;

  String? countryValue;
  String? stateValue;
  String? cityValue;

  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController tittleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


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
  final List<String> _areaUnit = [
    'Square Feet (sq.ft.)',
    'Square Meters (sq.m.)',
    'Square Yards (sq.yd.)',
    'Marla',
    'Kanal'
  ]; // Option 2

  final List<String> options = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '10+',
  ];

  @override
  void initState() {
    super.initState();
    startController.addListener(_setStartValue);
    endController.addListener(_setEndValue);
    areaController.addListener(_setAreaValue);
  }

  @override
  void dispose() {
    startController.dispose();
    endController.dispose();
    areaController.dispose();
    addressController.dispose();
    tittleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

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
          Icons.arrow_back_ios_outlined,
          size: MyApp.kDefaultPadding * 2,
        ),
      ),
      elevation: 0,
    );

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: myAppBar,
        backgroundColor: MyApp.kDefaultBackgroundColorWhite,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              propertyPhoto(),
              const Divider(thickness: 2.0),
              location(),
              const Divider(thickness: 2.0),
              preference(),
              const Divider(thickness: 2.0),
              information(),
              const Divider(thickness: 2.0),
              propertyType(),
              const Divider(thickness: 2.0),
              _groupValue == 0 ? priceRange() : timeframe(),
              const Divider(thickness: 2.0),
              propertyArea(),
              const Divider(thickness: 2.0),
              currentIndex == 0 ? bedrooms() : Container(),
              currentIndex == 0 ? const Divider(thickness: 2.0) : Container(),
              currentIndex == 0 ? bathrooms() : Container(),
              const Padding(
                padding: EdgeInsets.all(MyApp.kDefaultPadding),
                child: CustomButton(
                  label: 'Upload',
                  width: double.infinity,
                  icon: Icon(
                    Icons.cloud_upload,
                    color: Colors.white,
                  ),
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ///  =======================  PROPERTY PHOTO  ======================
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

  ///  =======================  LOCATION ======================
  location() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText('Location'),
        Padding(
          padding: const EdgeInsets.only(
              left: MyApp.kDefaultPadding,
              right: MyApp.kDefaultPadding,
              bottom: MyApp.kDefaultPadding),
          child: CSCPicker(
            showStates: true,
            showCities: true,
            flagState: CountryFlag.ENABLE,

            ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
            dropdownDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(color: Colors.grey.shade300, width: 1)),

            ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
            disabledDropdownDecoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                color: Colors.grey.shade300,
                border: Border.all(color: Colors.grey.shade300, width: 1)),

            ///placeholders for dropdown search field
            countrySearchPlaceholder: "Country",
            stateSearchPlaceholder: "State",
            citySearchPlaceholder: "City",

            ///labels for dropdown
            countryDropdownLabel: "*Country",
            stateDropdownLabel: "*State",
            cityDropdownLabel: "*City",

            ///Default Country
            defaultCountry: DefaultCountry.Pakistan,

            ///Disable country dropdown (Note: use it with default country)
            disableCountry: true,

            ///selected item style [OPTIONAL PARAMETER]
            selectedItemStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///DropdownDialog Heading style [OPTIONAL PARAMETER]
            dropdownHeadingStyle: const TextStyle(
                color: Colors.black, fontSize: 17, fontWeight: FontWeight.bold),

            ///DropdownDialog Item style [OPTIONAL PARAMETER]
            dropdownItemStyle: const TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///Dialog box radius [OPTIONAL PARAMETER]
            dropdownDialogRadius: 10.0,

            ///Search bar radius [OPTIONAL PARAMETER]
            searchBarRadius: 10.0,

            ///triggers once country selected in dropdown
            onCountryChanged: (value) {
              setState(() {
                ///store value in country variable
                countryValue = value;
              });
            },

            ///triggers once state selected in dropdown
            onStateChanged: (value) {
              setState(() {
                ///store value in state variable
                stateValue = value;
              });
            },

            ///triggers once city selected in dropdown
            onCityChanged: (value) {
              setState(() {
                ///store value in city variable
                cityValue = value;
              });
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: MyApp.kDefaultPadding,
            right: MyApp.kDefaultPadding,
          ),
          child: TextFormField(
            controller: addressController,
            cursorHeight: 25.0,
            maxLength: 100,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              label: Text('* Address'),
              fillColor: Colors.black,
              isDense: true,
              hintStyle: TextStyle(color: Colors.grey),
              focusColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }

  /// =============  PREFERENCE ================
  preference() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText('Preference'),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _myRadioButton(
              title: "Fixed Price",
              value: 0,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
            _myRadioButton(
              title: "Bid Price",
              value: 1,
              onChanged: (newValue) => setState(() => _groupValue = newValue),
            ),
          ],
        ),
      ],
    );
  }

  /// =============  INFORMATION ================
  information() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText('Info'),
        Padding(
          padding: const EdgeInsets.only(
            left: MyApp.kDefaultPadding,
            right: MyApp.kDefaultPadding,
          ),
          child: TextFormField(
            controller: tittleController,
            cursorHeight: 25.0,
            maxLength: 100,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              label: Text('* Title'),
              fillColor: Colors.black,
              isDense: true,
              hintStyle: TextStyle(color: Colors.grey),
              focusColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            left: MyApp.kDefaultPadding,
            right: MyApp.kDefaultPadding,
          ),
          child: TextFormField(
            controller: descriptionController,
            cursorHeight: 25.0,
            maxLength: 200,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            cursorColor: Colors.black,
            decoration: const InputDecoration(
              label: Text('* Description'),
              fillColor: Colors.black,
              isDense: true,
              hintStyle: TextStyle(color: Colors.grey),
              focusColor: Colors.black,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(10.0)),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.black),
              ),
            ),
          ),
        )
      ],
    );
  }

  ///  =======================  PROPERTY TYPE  ======================
  propertyType() {
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
              setState(() {
                currentIndex = index;
              });
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

  ///  =======================  PRICE RANGE  ======================
  priceRange() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            customText('Price Range'),
            const Text(
              '(PKR)',
              style: TextStyle(fontSize: 12.0),
            )
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: startController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    isDense: true,
                    hintText: '0',
                    hintStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text('TO', style: Theme.of(context).textTheme.bodyText2),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  controller: endController,
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  cursorColor: Colors.black,
                  decoration: const InputDecoration(
                    fillColor: Colors.black,
                    isDense: true,
                    hintText: 'Any',
                    hintStyle: TextStyle(color: Colors.grey),
                    focusColor: Colors.black,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10.0),
        RangeSlider(
          values: RangeValues(_starValue, _endValue),
          min: minValue,
          max: maxValue,
          divisions: 200,
          labels: RangeLabels(
            range(_starValue.round()),
            range(_endValue.round()),
          ),
          onChanged: (RangeValues values) {
            setState(() {
              _starValue = values.start.roundToDouble();
              _endValue = values.end.roundToDouble();
              startController.text = values.start.round().toString();
              endController.text = values.end.round().toString();
            });
          },
          activeColor: Colors.black,
        ),
      ],
    );
  }

  ///  =======================  TIME FRAME ======================
  timeframe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            customText('Time Frame'),
            Text('(${timeframeRange(currentTime.round())})')
          ],
        ),
        Slider(
          value: currentTime,
          min: minTime,
          max: maxTime,
          divisions: timeDivision,
          label: timeframeRange(currentTime.round()),
          onChanged: (value) {
            setState(() {
              currentTime = value.roundToDouble();
            });
          },
          activeColor: Colors.black,
        ),
      ],
    );
  }

  ///  =======================  PROPERTY AREA  ======================
  propertyArea() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            customText('Area Range'),
            const Spacer(),
            PopupMenuButton(
                onSelected: (value) {
                  setState(() {
                    _selectedAreaUnit = value.toString();
                  });
                },
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                initialValue: _areaUnit[3],
                itemBuilder: (context) {
                  return _areaUnit
                      .map(
                        (value) => PopupMenuItem(
                          value: value,
                          child: Text(value),
                        ),
                      )
                      .toList();
                },
                offset: const Offset(1, 40),
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.brown),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(10))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_selectedAreaUnit,
                          style: const TextStyle(fontSize: 14.0)),
                      const SizedBox(
                        width: 3,
                      ),
                      const Icon(
                        Icons.arrow_downward,
                        size: 16.0,
                      ),
                    ],
                  ),
                )),
            const SizedBox(width: 10.0)
          ],
        ),
        Container(
          height: 80,
          width: 150,
          padding:
              const EdgeInsets.symmetric(horizontal: MyApp.kDefaultPadding),
          child: Center(
            child: TextFormField(
              controller: areaController,
              maxLength: 10,
              keyboardType: TextInputType.number,
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                fillColor: Colors.black,
                isDense: true,
                hintText: '0',
                hintStyle: TextStyle(color: Colors.grey),
                focusColor: Colors.black,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),
        ),
        Slider(
          value: currentArea,
          min: minArea,
          max: maxArea,
          divisions: 500,
          label: unitArea(currentArea.round().toString(), _selectedAreaUnit),
          // label: '${currentArea.round().toString()} Marla',
          onChanged: (value) {
            setState(() {
              currentArea = value.roundToDouble();
              areaController.text = value.round().toString();
            });
          },
          activeColor: Colors.black,
        ),
      ],
    );
  }

  ///  =======================  BEDROOMS ======================
  bedrooms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText('Bedrooms'),
        // Slider(
        //   value: currentBed,
        //   min: minBed,
        //   max: maxBed,
        //   divisions: bedDivision,
        //   label: currentBed > 10 ? '10+' : currentBed.round().toString(),
        //   onChanged: (value) {
        //     setState(() {
        //       currentBed = value.roundToDouble();
        //     });
        //   },
        //   activeColor: Colors.black,
        // ),
        Center(
          child: ChipsChoice<int>.single(
            wrapped: true,
            spacing: 50.0,
            runSpacing: 15.0,
            value: bedTag,
            onChanged: (val) => setState(() => bedTag = val),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
            choiceStyle: const C2ChoiceStyle(
              padding: EdgeInsets.all(12.0),
              borderShape: CircleBorder(),
              color: MyApp.kDefaultButtonColorBlack,
            ),
          ),
        ),
      ],
    );
  }

  ///  =======================  BATHROOMS ======================
  bathrooms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        customText('Bathrooms'),
        // Slider(
        //   value: currentBath,
        //   min: minBath,
        //   max: maxBath,
        //   divisions: bathDivision,
        //   // label: unitArea(currentBed.round().toString(), _selectedAreaUnit),
        //   label: currentBath > 10 ? '10+' : currentBath.round().toString(),
        //   onChanged: (value) {
        //     setState(() {
        //       currentBath = value.roundToDouble();
        //     });
        //   },
        //   activeColor: Colors.black,
        // ),
        Center(
          child: ChipsChoice<int>.single(
            wrapped: true,
            spacing: 50.0,
            runSpacing: 15.0,
            value: bathTag,
            onChanged: (val) => setState(() => bathTag = val),
            choiceItems: C2Choice.listFrom<int, String>(
              source: options,
              value: (i, v) => i,
              label: (i, v) => v,
            ),
            choiceStyle: const C2ChoiceStyle(
              padding: EdgeInsets.all(12.0),
              borderShape: CircleBorder(),
              color: MyApp.kDefaultButtonColorBlack,
            ),
          ),
        ),
        const Divider(thickness: 2.0),
      ],
    );
  }

  ///  =================  WIDGETS  ===========================
  customText(String text) {
    return Padding(
      padding: const EdgeInsets.all(MyApp.kDefaultPadding),
      child: Text(text, style: Theme.of(context).textTheme.headline6),
    );
  }

  _setStartValue() {
    if (startController.text == '' || endController.text == '') return;
    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        _starValue = double.parse(startController.text).roundToDouble();
      });
    }
  }

  _setEndValue() {
    if (startController.text == '' || endController.text == '') return;

    if (double.parse(startController.text).roundToDouble() <=
            double.parse(endController.text).roundToDouble() &&
        double.parse(startController.text).roundToDouble() >= minValue &&
        double.parse(endController.text).roundToDouble() >= minValue &&
        double.parse(startController.text).roundToDouble() <= maxValue &&
        double.parse(endController.text).roundToDouble() <= maxValue) {
      setState(() {
        _endValue = double.parse(endController.text).roundToDouble();
      });
    }
  }

  _setAreaValue() {
    if (areaController.text == '') return;
    setState(() {
      currentArea = double.parse(areaController.text).roundToDouble();
    });
  }

  range(int price) {
    if (price == 0) {
      return 'PKR 0';
    } else if (price < 10000) {
      // 10 Thousand
      return 'PKR 5 Thousand';
    } else if (price < 100000) {
      // 1 Lac
      return 'PKR ${price.toString().substring(0, 2)} Thousand';
    } else if (price < 1000000) {
      // 10 Lac
      final x = int.parse(price.toString().substring(0, 2)) / 10;
      if (x.toString().split('.')[1] == '0') {
        return 'PKR ${x.toInt()} Lac';
      }
      return 'PKR $x Lac';
    } else {
      return 'Any';
    }
  }

  unitArea(String value, String unit) {
    if (int.parse(value) >= 1000) {
      return 'Any';
    } else if (int.parse(value) == 0) {
      return '0';
    } else {
      switch (unit) {
        case 'Marla':
          return '$value Marla';
        case 'Square Feet (sq.ft.)':
          return '$value sq.ft.';
        case 'Square Meters (sq.m.)':
          return '$value sq.m.';
        case 'Square Yards (sq.yd.)':
          return '$value sq.yd.';
        case 'Kanal':
          return '$value Kanal';
      }
    }
  }

  _myRadioButton({String? title, int? value, onChanged}) {
    return RadioListTile(
      activeColor: MyApp.kDefaultButtonColorBlack,
      value: value,
      groupValue: _groupValue,
      onChanged: onChanged,
      title: Text(
        title!,
        style: Theme.of(context).textTheme.bodyText1,
      ),
      subtitle: Text(value == 0
          ? 'Where you can set price range of your property and negotiate with dealer'
          : 'Here you can specify the amount of time and dealer will bid within time frame'),
      dense: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  timeframeRange(int value) {
    switch (value) {
      case 1:
        return '6 hr';
      case 2:
        return '12 hr';
      case 3:
        return '1 day';
      case 4:
        return '2 days';
      case 5:
        return '3 days';
      case 6:
        return '4 days';
      case 7:
        return '5 days';
      case 8:
        return '6 days';
      case 9:
        return '1 week';
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
          spacing: 8.0,
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
