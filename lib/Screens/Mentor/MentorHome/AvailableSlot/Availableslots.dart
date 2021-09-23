import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rehnuma_mentor/CustomWidgets/CustomLoading.dart';
import 'package:rehnuma_mentor/CustomWidgets/Custombutton.dart';
import 'package:rehnuma_mentor/CustomWidgets/Loading.dart';
import 'package:rehnuma_mentor/Screens/Mentor/MentorHome/mentorhome.dart';
import 'package:rehnuma_mentor/SharedFunctions.dart';
import 'package:rehnuma_mentor/models/slotModel.dart';
import 'package:rehnuma_mentor/services/DBservice.dart';
import 'package:rehnuma_mentor/services/Providers/MentorProvider.dart';

import '../../../../Global.dart';

class AvailableSlots extends StatefulWidget {
  @override
  _AvailableSlotsState createState() => _AvailableSlotsState();
}

class _AvailableSlotsState extends State<AvailableSlots> {
  List<SlotModel> monSlots = [],
      tuesSlots = [],
      wedSlots = [],
      thursSlots = [],
      friSlots = [];
  bool loading = false;
  bool slotChanging = false;
  // List<SlotModel> selectedSlots = [];
  MentorProvider mentorProvider;
  getAllSlots() async {
    setState(() {
      loading = true;
    });
    await DBService().getSlotsList().then((slots) {
      if (slots.length != 0) {
        for (int i = 0; i < slots.length; i++) {
          setState(() {
            if (slots[i].day.toLowerCase() == "monday") monSlots.add(slots[i]);
            if (slots[i].day.toLowerCase() == "tuesday")
              tuesSlots.add(slots[i]);
            if (slots[i].day.toLowerCase() == "wednesday")
              wedSlots.add(slots[i]);
            if (slots[i].day.toLowerCase() == "thursday")
              thursSlots.add(slots[i]);
            if (slots[i].day.toLowerCase() == "friday") friSlots.add(slots[i]);
          });
        }
        print("Monday Length :" + monSlots.length.toString());
        print("Tuesday Length :" + tuesSlots.length.toString());
        print("Wednesday Length :" + wedSlots.length.toString());
        print("Thursday Length :" + thursSlots.length.toString());
        print("friday Length :" + friSlots.length.toString());
      }
    });
    setState(() {
      loading = false;
    });
  }

  Future onCheckboxChanged(bool changed, SlotModel slot) async {
    MentorProvider mentorProvider =
        Provider.of<MentorProvider>(context, listen: false);
    if (mentorProvider.isCurrMentorAvailable()) {
      if (changed) {
        setState(() {
          slotChanging = true;
        });
        await DBService()
            .addSlot(mentorProvider.currMentor.mentorId, slot.slotId)
            .then((value) {
          if (value) {
            mentorProvider.addSlots(slot.slotId);
            setState(() {});
          }
        });
      } else {
        setState(() {
          slotChanging = true;
        });
        await DBService()
            .removeSlot(mentorProvider.currMentor.mentorId, slot.slotId)
            .then((value) {
          if (value) {
            mentorProvider.removeSlot(slot.slotId);
            setState(() {});
          }
        });
      }
      setState(() {
        slotChanging = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    mentorProvider = Provider.of<MentorProvider>(context, listen: false);

    getAllSlots();
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
        body: loading
            ? Loading()
            : Consumer<MentorProvider>(builder: (_, mentorProv, __) {
                return Stack(
                  children: [
                    Container(
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  '1. Monday (September 27,2021)',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: buttonColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            monSlots.length > 0
                                ? Container(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 8 / 2,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 0,
                                      ),
                                      itemCount: monSlots.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Row(
                                          children: [
                                            Checkbox(
                                              value: mentorProv.currMentor.slots
                                                  .contains(monSlots[i].slotId),
                                              onChanged: (bool changed) async {
                                                onCheckboxChanged(
                                                  changed,
                                                  monSlots[i],
                                                );
                                              },
                                            ),
                                            Text(
                                              getSlotTimeString(
                                                  end: monSlots[i].endTime,
                                                  start: monSlots[i].startTime),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child:
                                        Text("No slots available for this day"),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  ' 2. Tuesday (September 28, 2021) ',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: buttonColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            tuesSlots.length > 0
                                ? Container(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 8 / 2,
                                        mainAxisSpacing: 0,
                                        crossAxisSpacing: 0,
                                      ),
                                      itemCount: tuesSlots.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Row(
                                          children: [
                                            Checkbox(
                                              value: mentorProv.currMentor.slots
                                                  .contains(
                                                      tuesSlots[i].slotId),
                                              onChanged: (bool changed) async {
                                                onCheckboxChanged(
                                                    changed, tuesSlots[i]);
                                              },
                                            ),
                                            Text(
                                              getSlotTimeString(
                                                  end: tuesSlots[i].endTime,
                                                  start:
                                                      tuesSlots[i].startTime),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child:
                                        Text("No slots available for this day"),
                                  ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  ' 3. Wednesday (September 29,2021)',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: buttonColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            wedSlots.length > 0
                                ? Container(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 4 / 2,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 0,
                                      ),
                                      itemCount: wedSlots.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Row(
                                          children: [
                                            Checkbox(
                                              value: mentorProv.currMentor.slots
                                                  .contains(wedSlots[i].slotId),
                                              onChanged: (bool changed) async {
                                                onCheckboxChanged(
                                                    changed, wedSlots[i]);
                                              },
                                            ),
                                            Text(
                                              getSlotTimeString(
                                                  end: wedSlots[i].endTime,
                                                  start: wedSlots[i].startTime),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child:
                                        Text("No slots available for this day"),
                                  ),
                            //Thursday
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  ' 4. Thursday (September 30,2021)',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: buttonColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            thursSlots.length > 0
                                ? Container(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 4 / 2,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 0,
                                      ),
                                      itemCount: thursSlots.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Row(
                                          children: [
                                            Checkbox(
                                              value: mentorProv.currMentor.slots
                                                  .contains(
                                                      thursSlots[i].slotId),
                                              onChanged: (bool changed) async {
                                                onCheckboxChanged(
                                                    changed, thursSlots[i]);
                                              },
                                            ),
                                            Text(
                                              getSlotTimeString(
                                                  end: thursSlots[i].endTime,
                                                  start:
                                                      thursSlots[i].startTime),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child:
                                        Text("No slots available for this day"),
                                  ),
                            //Friday
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  ' 5. Friday (October 01,2021)',
                                  style: TextStyle(
                                      fontSize: 17,
                                      color: buttonColor,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                            friSlots.length > 0
                                ? Container(
                                    child: GridView.builder(
                                      shrinkWrap: true,
                                      primary: false,
                                      gridDelegate:
                                          SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        childAspectRatio: 4 / 2,
                                        mainAxisSpacing: 5,
                                        crossAxisSpacing: 0,
                                      ),
                                      itemCount: friSlots.length,
                                      itemBuilder:
                                          (BuildContext context, int i) {
                                        return Row(
                                          children: [
                                            Checkbox(
                                              value: mentorProv.currMentor.slots
                                                  .contains(friSlots[i].slotId),
                                              onChanged: (bool changed) async {
                                                onCheckboxChanged(
                                                    changed, friSlots[i]);
                                              },
                                            ),
                                            Text(
                                              getSlotTimeString(
                                                  end: friSlots[i].endTime,
                                                  start: friSlots[i].startTime),
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  )
                                : Container(
                                    height: 40,
                                    width: MediaQuery.of(context).size.width,
                                    alignment: Alignment.center,
                                    child:
                                        Text("No slots available for this day"),
                                  ),

                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: CustomButton(
                                  title: 'Update',
                                  onPressed: () {
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                MentorHome()));
                                  },
                                  height: 40,
                                  width: 120,
                                  buttoncolor: Colors.green),
                            )

                            // Container(
                            //   child: Column(
                            //     mainAxisAlignment: MainAxisAlignment.start,
                            //     children: [
                            //       Row(
                            //         children: [
                            //           Row(
                            //             children: [
                            //               Radio(
                            //                 value: 1,
                            //                 groupValue: _radioValue,
                            //                 onChanged: _handleRadioValueChange,
                            //               ),
                            //               Text('11:00 -11:30'),
                            //             ],
                            //           ),
                            //           Row(
                            //             children: [
                            //               Radio(
                            //                 value: 2,
                            //                 groupValue: _radioValue,
                            //                 onChanged: _handleRadioValueChange,
                            //               ),
                            //               Text('12:00 -12:30'),
                            //             ],
                            //           ),
                            //           Row(
                            //             children: [
                            //               Radio(
                            //                 value: 3,
                            //                 groupValue: _radioValue,
                            //                 onChanged: _handleRadioValueChange,
                            //               ),
                            //               Text('01:00 -01:30'),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //       Row(
                            //         children: [
                            //           Row(
                            //             children: [
                            //               Radio(
                            //                 value: 4,
                            //                 groupValue: 1,
                            //                 onChanged: null,
                            //               ),
                            //               Text('11:00 -11:30'),
                            //             ],
                            //           ),
                            //           Row(
                            //             children: [
                            //               Radio(
                            //                 value: 5,
                            //                 groupValue: _radioValue,
                            //                 onChanged: _handleRadioValueChange,
                            //               ),
                            //               Text('12:00 -12:30'),
                            //             ],
                            //           ),
                            //           Row(
                            //             children: [
                            //               Radio(
                            //                 value: 6,
                            //                 groupValue: _radioValue,
                            //                 onChanged: _handleRadioValueChange,
                            //               ),
                            //               Text('01:00 -01:30'),
                            //             ],
                            //           ),
                            //         ],
                            //       ),
                            //       SizedBox(
                            //         height: 10,
                            //       ),
                            //       Row(
                            //         mainAxisAlignment: MainAxisAlignment.start,
                            //         children: [
                            //           Text(
                            //             ' 1. Tuesday - 2 JAN 2021',
                            //             style: TextStyle(
                            //                 fontSize: 14,
                            //                 color: buttonColor,
                            //                 fontWeight: FontWeight.bold),
                            //           ),
                            //         ],
                            //       ),
                            //       Container(
                            //         child: Column(
                            //           mainAxisAlignment: MainAxisAlignment.start,
                            //           children: [
                            //             Row(
                            //               children: [
                            //                 Row(
                            //                   children: [
                            //                     Radio(
                            //                       value: 1,
                            //                       groupValue: _radioValue,
                            //                       onChanged: _handleRadioValueChange,
                            //                     ),
                            //                     Text('11:00 -11:30'),
                            //                   ],
                            //                 ),
                            //                 Row(
                            //                   children: [
                            //                     Radio(
                            //                       value: 2,
                            //                       groupValue: _radioValue,
                            //                       onChanged: _handleRadioValueChange,
                            //                     ),
                            //                     Text('12:00 -12:30'),
                            //                   ],
                            //                 ),
                            //                 Row(
                            //                   children: [
                            //                     Radio(
                            //                       value: 3,
                            //                       groupValue: _radioValue,
                            //                       onChanged: _handleRadioValueChange,
                            //                     ),
                            //                     Text('01:00 -01:30'),
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //             Row(
                            //               children: [
                            //                 Row(
                            //                   children: [
                            //                     Radio(
                            //                       value: 4,
                            //                       groupValue: 1,
                            //                       onChanged: null,
                            //                     ),
                            //                     Text('11:00 -11:30'),
                            //                   ],
                            //                 ),
                            //                 Row(
                            //                   children: [
                            //                     Radio(
                            //                       value: 5,
                            //                       groupValue: _radioValue,
                            //                       onChanged: _handleRadioValueChange,
                            //                     ),
                            //                     Text('12:00 -12:30'),
                            //                   ],
                            //                 ),
                            //                 Row(
                            //                   children: [
                            //                     Radio(
                            //                       value: 6,
                            //                       groupValue: _radioValue,
                            //                       onChanged: _handleRadioValueChange,
                            //                     ),
                            //                     Text('01:00 -01:30'),
                            //                   ],
                            //                 ),
                            //               ],
                            //             ),
                            //             /* SizedBox(
                            //       width: 40,
                            //       height: 40,
                            //       child:
                            //       RadioListTile(
                            //           title: Text('10:00 - 10:30'),
                            //           value: 1,
                            //           groupValue: 1,
                            //           onChanged: null),
                            //     ),
                            //     SizedBox(
                            //       width: 40,
                            //       height: 40,
                            //       child: RadioListTile(
                            //           title: Text('10:00 - 10:30'),
                            //           value: 1,
                            //           groupValue: 1,
                            //           onChanged: null),
                            //     ),
                            //     SizedBox(
                            //       width: 40,
                            //       height: 40,
                            //       child: RadioListTile(
                            //           title: Text('10:00 - 10:30'),
                            //           value: 1,
                            //           groupValue: 1,
                            //           onChanged: null),
                            //     ), */
                            //           ],
                            //         ),
                            //       ),
                            //     ],
                            //   ),
                            // ),
                          ],
                        ),
                      ),
                    ),
                    slotChanging ? CustomLoading() : Container()
                  ],
                );
              }));
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
