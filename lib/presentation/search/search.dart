import 'package:flutter/material.dart';
import 'package:peak_property/core/my_app.dart';
import 'package:peak_property/custom/custom_button.dart';
import 'package:peak_property/presentation/upload/upload.dart';
import 'package:toggle_switch/toggle_switch.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String _selectedAreaUnit = 'Marla';

  var currentIndex = 0;

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
  ];

  // Option 2
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.01,
            ),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.03,
                ),
                IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(
                    Icons.cancel_outlined,
                    size: MyApp.kDefaultPadding * 2,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.27,
                ),
                const Text(
                  "Filter",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Color(0xFF070821),
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
              ],
            ),
            const Divider(),
            propertyType(),
            const Divider(thickness: 2.0),
            priceRange(),
            const Divider(thickness: 2.0),
            propertyArea(),
            const Divider(thickness: 2.0),
            currentIndex == 0 ? bedrooms() : Container(),
            currentIndex == 0 ? const Divider(thickness: 2.0) : Container(),
            currentIndex == 0 ? bathrooms() : Container(),
            Padding(
              padding: const EdgeInsets.all(MyApp.kDefaultPadding),
              child: CustomButton(
                label: 'Search',
                width: MediaQuery.of(context).size.width * 0.4,
                icon: const Icon(
                  Icons.search_sharp,
                  color: Colors.white,
                ),
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
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
        Slider(
          value: currentBed,
          min: minBed,
          max: maxBed,
          divisions: bedDivision,
          // label: unitArea(currentBed.round().toString(), _selectedAreaUnit),
          label: currentBed > 10 ? '10+' : currentBed.round().toString(),
          onChanged: (value) {
            setState(() {
              currentBed = value.roundToDouble();
            });
          },
          activeColor: Colors.black,
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
        Slider(
          value: currentBath,
          min: minBath,
          max: maxBath,
          divisions: bathDivision,
          // label: unitArea(currentBed.round().toString(), _selectedAreaUnit),
          label: currentBath > 10 ? '10+' : currentBath.round().toString(),
          onChanged: (value) {
            setState(() {
              currentBath = value.roundToDouble();
            });
          },
          activeColor: Colors.black,
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
}
