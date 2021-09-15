import 'package:flutter/material.dart';
import 'package:rehnuma_mentor/models/slotModel.dart';
import 'package:rehnuma_mentor/services/DBservice.dart';

import '../../../../Global.dart';

class AvailableSlots extends StatefulWidget {
  @override
  _AvailableSlotsState createState() => _AvailableSlotsState();
}

class _AvailableSlotsState extends State<AvailableSlots> {
  List<SlotModel> slotList = [];

  List<SlotModel> monSlots = [],
      tuesSlots = [],
      wedSlots = [],
      thursSlots = [],
      friSlots = [];

  getAllSlots() async {
    await DBService().getSlotsList().then((slots) {
      if (slots.length != 0) {
        for (int i = 0; i < slots.length; i++) {
          if (slots[i].day.toLowerCase() == "monday") monSlots.add(slots[i]);
          if (slots[i].day.toLowerCase() == "tuesday") tuesSlots.add(slots[i]);
          if (slots[i].day.toLowerCase() == "wednesday") wedSlots.add(slots[i]);
          if (slots[i].day.toLowerCase() == "thursday")
            thursSlots.add(slots[i]);
          if (slots[i].day.toLowerCase() == "friday") friSlots.add(slots[i]);
        }
        print("Monday Length :" + monSlots.length.toString());
        print("Tuesday Length :" + tuesSlots.length.toString());
        print("Wednesday Length :" + wedSlots.length.toString());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    getAllSlots();
  }

  int _radioValue = 0;
  final timeSlots = [
    "10:00-10:30",
    "10:30-11:00",
    "11:00-11:30",
    "11:30-12:00",
    "12:00-12:30",
    "12:30-13:00",
    "13:00-13:30",
    "13:30-14:00",
    "14:00-14:30",
    "14:30-15:00",
  ];

  /*  final List<Map> timeSlot = [
    {"slot": "10:00 AM -10:45 AM", "slotID": 0},
    {"slot": "11:00 AM -11:45 AM", "slotID": 1},
    {"slot": "12:00 AM -12:45 AM", "slotID": 2},
    {"slot": "13:00 AM -13:45  AM", "slotID": 3},
    {"slot": "14:00 AM -14:45  AM", "slotID": 4},
    {"slot": "15:00 AM -15:45  AM", "slotID": 5},
    {"slot": "16:00 AM -16:45  AM", "slotID": 6},
  ];
 */
  // final days = ["Monday", "Tuesday", "Wednesday", "Thursday", "Friday"];

  List<RadioGroup> useList = [];
  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;
      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
        case 3:
          break;
        case 4:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: primaryColor,
          /* leading: Icon(
          Icons.menu,
          color: secondaryColor,
        ), */
          title: Text(
            'Set your available slots',
            style: TextStyle(
                fontSize: 17,
                color: secondaryColor,
                fontWeight: FontWeight.bold),
          ),
        ),
        body: Container(
          color: secondaryColor,
          padding: EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  'When are you available?',
                  style: TextStyle(
                      fontSize: 20,
                      color: primaryColor,
                      fontWeight: FontWeight.w600),
                ),
                Text('Choose your available slots for this week'),
                SizedBox(
                  height: 10,
                ),
                Text(
                  ' 1. Monday - 1 JAN 2021',
                  style: TextStyle(
                      fontSize: 14,
                      color: buttonColor,
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                    ),
                    itemCount: 2,
                    itemBuilder: (BuildContext context, int index) {
                      return Container();
                    },
                  ),
                ),
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 1,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              Text('11:00 -11:30'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 2,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              Text('12:00 -12:30'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 3,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              Text('01:00 -01:30'),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Row(
                            children: [
                              Radio(
                                value: 4,
                                groupValue: 1,
                                onChanged: null,
                              ),
                              Text('11:00 -11:30'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 5,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              Text('12:00 -12:30'),
                            ],
                          ),
                          Row(
                            children: [
                              Radio(
                                value: 6,
                                groupValue: _radioValue,
                                onChanged: _handleRadioValueChange,
                              ),
                              Text('01:00 -01:30'),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            ' 1. Tuesday - 2 JAN 2021',
                            style: TextStyle(
                                fontSize: 14,
                                color: buttonColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 1,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('11:00 -11:30'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 2,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('12:00 -12:30'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 3,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('01:00 -01:30'),
                                  ],
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Row(
                                  children: [
                                    Radio(
                                      value: 4,
                                      groupValue: 1,
                                      onChanged: null,
                                    ),
                                    Text('11:00 -11:30'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 5,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('12:00 -12:30'),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Radio(
                                      value: 6,
                                      groupValue: _radioValue,
                                      onChanged: _handleRadioValueChange,
                                    ),
                                    Text('01:00 -01:30'),
                                  ],
                                ),
                              ],
                            ),
                            /* SizedBox(
                      width: 40,
                      height: 40,
                      child: 
                      RadioListTile(
                          title: Text('10:00 - 10:30'),
                          value: 1,
                          groupValue: 1,
                          onChanged: null),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: RadioListTile(
                          title: Text('10:00 - 10:30'),
                          value: 1,
                          groupValue: 1,
                          onChanged: null),
                    ),
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: RadioListTile(
                          title: Text('10:00 - 10:30'),
                          value: 1,
                          groupValue: 1,
                          onChanged: null),
                    ), */
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}

class CardforSlots extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RadioGroup extends StatefulWidget {
  @override
  RadioGroupWidget createState() => RadioGroupWidget();
}

class TimeList {
  String name;
  int index;
  TimeList({this.name, this.index});
}

class RadioGroupWidget extends State {
  // Default Radio Button Item
  String radioItem = 'Mango';

  // Group Value for Radio Button.
  int id = 1;

  List<TimeList> tList = [
    TimeList(
      index: 1,
      name: "10:00-10:30",
    ),
    TimeList(
      index: 2,
      name: "10:30-11:00",
    ),
    TimeList(
      index: 3,
      name: "11:00-11:30",
    ),
    TimeList(
      index: 4,
      name: "11:30-12:00",
    ),
    TimeList(
      index: 4,
      name: "12:00-12:30",
    ),
    TimeList(
      index: 4,
      name: "12:30-13:00",
    ),
    TimeList(
      index: 4,
      name: "13:00-13:30",
    ),
  ];

  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.all(14.0),
            child: Text('$radioItem', style: TextStyle(fontSize: 15))),
        Expanded(
            child: Container(
          height: 350.0,
          child: Column(
            children: tList
                .map((data) => RadioListTile(
                      title: Text("${data.name}"),
                      groupValue: id,
                      value: data.index,
                      onChanged: (val) {
                        setState(() {
                          radioItem = data.name;
                          id = data.index;
                        });
                      },
                    ))
                .toList(),
          ),
        )),
      ],
    );
  }
}
