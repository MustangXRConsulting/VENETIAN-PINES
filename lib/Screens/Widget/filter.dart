import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:venetian_pines/Providers/post_provider.dart';

class Filters extends StatefulWidget {
  bool darkMode;
  Filters({this.darkMode});
  @override
  _FiltersState createState() => _FiltersState();
}

class _FiltersState extends State<Filters> {
  double w, h;
  PostProivder postProivder;
  String month = 'Month', year = 'Year', topic = 'Topic';
  init() async {
    postProivder = Provider.of<PostProivder>(context, listen: false);
    final response = await FirebaseFirestore.instance
        .collection("communityCalendarTopics")
        .orderBy("date", descending: true)
        .get();

    for (DocumentSnapshot doc in response.docs) topics.add(doc["name"]);

    setState(() {});
  }

  List<String> topics = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    Color color = widget.darkMode != null && widget.darkMode
        ? Color(0xff585858)
        : Colors.white;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      // crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Filter by:',
          style: TextStyle(
              color: color, fontWeight: FontWeight.w600, fontSize: 18),
        ),
        Container(
            height: h * 0.034,
            width: w * .2,
            padding: EdgeInsets.only(left: 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: DropdownButton<String>(
                isExpanded: true,
                underline: Container(),
                iconEnabledColor: color,
                iconSize: 20,
                hint: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    month,
                    style: TextStyle(fontSize: 14, color: color),
                  ),
                ),
                items: <String>[
                  'Jan',
                  'Feb',
                  'Mar',
                  'Apr',
                  'May',
                  'Jun',
                  'Jul',
                  'Aug',
                  'Sep',
                  'Oct',
                  'Nov',
                  'Dec'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    month = newValue;
                  });
                  postProivder.filterByMonth(getMonth(newValue));
                },
              ),
            )),
        Container(
            height: h * 0.034,
            width: w * .2,
            padding: EdgeInsets.only(left: 2),
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: DropdownButton<String>(
                underline: Container(),
                iconSize: 20,
                iconEnabledColor: color,
                hint: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    year,
                    style: TextStyle(fontSize: 15, color: color),
                  ),
                ),
                items: <String>[
                  '2010',
                  '2011',
                  '2012',
                  '2013',
                  '2014',
                  '2015',
                  '2016',
                  '2017',
                  '2018',
                  '2019',
                  '2020',
                  '2021',
                  '2022'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList().reversed.toList(),
                onChanged: (newValue) {
                  setState(() {
                    year = newValue;
                  });
                  postProivder.filterByYear(int.parse(newValue));
                },
              ),
            )),
        Container(
            height: h * 0.034,
            width: w * 0.2,
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(3),
            ),
            child: Center(
              child: DropdownButton<String>(
                iconSize: 20,
                underline: Container(),
                iconEnabledColor: color,
                isExpanded: true,
                hint: Container(
                  margin: EdgeInsets.only(left: 5),
                  child: Text(
                    topic,
                    style: TextStyle(fontSize: 15, color: color),
                  ),
                ),
                items: topics.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    topic = newValue;
                  });
                  postProivder.filterByTopic(topic);
                },
              ),
            )),
      ],
    );
  }

  int getMonth(String val) {
    if (val == 'Jan')
      return 1;
    else if (val == 'Feb')
      return 2;
    else if (val == 'Mar')
      return 3;
    else if (val == 'Apr')
      return 4;
    else if (val == 'May')
      return 5;
    else if (val == 'Jun')
      return 6;
    else if (val == 'Jul')
      return 7;
    else if (val == 'Aug')
      return 8;
    else if (val == 'Sep')
      return 9;
    else if (val == 'Oct')
      return 10;
    else if (val == 'Nov')
      return 11;
    else if (val == 'Dec') return 12;
  }
}
