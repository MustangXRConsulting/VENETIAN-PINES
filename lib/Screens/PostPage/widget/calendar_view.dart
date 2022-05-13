import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/classes/event_list.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel;
import 'package:intl/intl.dart' show DateFormat;
import 'package:url_launcher/url_launcher.dart';
import 'package:venetian_pines/Models/PostModel.dart';
import 'package:venetian_pines/Screens/Landing/LandingPage.dart';
import 'package:venetian_pines/Screens/ReserveAmenities/ReserveAmenities.dart';

class CalendarView extends StatefulWidget {
  List<PostModel> posts = [];

  CalendarView({this.posts});

  @override
  _CalendarPageState createState() => new _CalendarPageState();
}

class _CalendarPageState extends State<CalendarView> {
  DateTime _currentDate = DateTime.now();
  DateTime _currentDate2 = DateTime.now();
  String _currentMonth = DateFormat.yMMM().format(DateTime.now());
  DateTime _targetDateTime = DateTime.now();

//  List<DateTime> _markedDate = [DateTime(2018, 9, 20), DateTime(2018, 10, 11)];
  static Widget _eventIcon = new Container(
    decoration: new BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(1000)),
        border: Border.all(color: Colors.blue, width: 2.0)),
    child: new Icon(
      Icons.person,
      color: Colors.amber,
    ),
  );

  EventList<Event> _markedDateMap;

  bool isEventDay(DateTime dt) {
    bool contain = false;
    for (PostModel post in widget.posts) {
      if (post.createdOn.year == dt.year &&
          post.createdOn.month == dt.month &&
          post.createdOn.day == dt.day) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  List<PostModel> getEventPostModels(DateTime dt) {
    List<PostModel> models = [];
    for (PostModel post in widget.posts) {
      if (post.createdOn.year == dt.year &&
          post.createdOn.month == dt.month &&
          post.createdOn.day == dt.day) {
        models.add(post);
      }
    }
    return models;
  }

  init() {
    _markedDateMap = new EventList<Event>(
      events: {
        widget.posts[0].createdOn: [
          new Event(
            date: new DateTime(2020, 10, 10),
            title: 'Event 3',
            icon: _eventIcon,
          ),
        ],
      },
    );
    for (PostModel post in widget.posts) {
      _markedDateMap.add(
          post.createdOn,
          new Event(
            date: post.createdOn,
            title: 'Event 5',
            icon: _eventIcon,
          ));
    }
  }

  int getCount(DateTime dt) {
    int count = 0;
    for (PostModel post in widget.posts) {
      if (post.createdOn.year == dt.year &&
          post.createdOn.month == dt.month &&
          post.createdOn.day == dt.day) {
        count = count + 1;
        break;
      }
    }
    return count;
  }

  onPostClick(PostModel post) async {
    if (post.type == '5') {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ReserveAmentities(
              description: post.description,
                  title: post.title,
                  eventDate: post.createdOn,
                  img: post.image,
                  h: MediaQuery.of(context).size.height,
                  w: MediaQuery.of(context).size.width,
                )),
      );
    } else if (post.type == '4') {
      // marketplace
      await canLaunch(post.url)
          ? await launch(post.url)
          : throw 'Could not launch ${post.url}';
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => LandingPage(
                  post: post,
                  type: post.type,
                  w: MediaQuery.of(context).size.width,
                )),
      );
    }
  }

  onClick(DateTime dt) async {
    bool isEvent = isEventDay(dt);
    if (isEvent) {
      List<PostModel> eventPosts = getEventPostModels(dt);
      if (eventPosts.length == 1) {
        PostModel post = eventPosts[0];
        onPostClick(post);
      } else {
        showAllEventsAtDate(eventPosts);
      }
    } else
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("No event available at selected date")));
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  _calendarCarouselNoHeader() => CalendarCarousel<Event>(
        onDayPressed: (date, events) {
          this.setState(() => _currentDate2 = date);
          events.forEach((event) => print(event.title));
        },
        markedDateWidget: Container(),
        daysHaveCircularBorder: true,
        customDayBuilder: (isSelectable, index, isSelectedDay, isToday,
            isPrevMonthDay, textStyle, isNextMonthDay, isThisMonthDay, day) {
          bool isEvent = isEventDay(day);
          return GestureDetector(
            onTap: () {
              print('Hello');
              if (isEvent) print('long pressed date $day');
              onClick(day);
            },
            child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isEvent ? Colors.green : Colors.transparent,
                ),
                child: Center(
                    child: Text(
                  day.day.toString(),
                  style: TextStyle(
                      color: isEvent ? Colors.yellow : Colors.black,
                      fontSize: 16),
                ))),
          );
        },
        weekdayTextStyle: TextStyle(
            color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
        showOnlyCurrentMonthDate: false,
        isScrollable: false,
        weekendTextStyle: TextStyle(color: Colors.black, fontSize: 16),
        selectedDayBorderColor: Colors.grey,
        thisMonthDayBorderColor: Colors.grey,
        weekFormat: false,
        markedDatesMap: _markedDateMap,
        height: 420.0,
        selectedDateTime: _currentDate2,
        targetDateTime: _targetDateTime,
        customGridViewPhysics: NeverScrollableScrollPhysics(),
        markedDateCustomShapeBorder:
            CircleBorder(side: BorderSide(color: Colors.indigo, width: 2)),
        markedDateCustomTextStyle: TextStyle(
          fontSize: 20,
          color: Colors.blue,
        ),
        showHeader: false,
        todayTextStyle: TextStyle(color: Colors.blue, fontSize: 16),
        todayBorderColor: Colors.grey,
        todayButtonColor: Colors.transparent,
        selectedDayTextStyle: TextStyle(color: Colors.black, fontSize: 16),
        selectedDayButtonColor: Colors.transparent,
        minSelectedDate: _currentDate.subtract(Duration(days: 360)),
        maxSelectedDate: _currentDate.add(Duration(days: 360)),
        prevDaysTextStyle: TextStyle(
          fontSize: 18,
          color: Colors.grey,
        ),
        inactiveDaysTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
        onCalendarChanged: (DateTime date) {
          this.setState(() {
            _targetDateTime = date;
            _currentMonth = DateFormat.yMMM().format(_targetDateTime);
          });
        },
        onDayLongPressed: (DateTime date) {
          print('long pressed date $date');
          onClick(date);
        },
      );

  @override
  Widget build(BuildContext context) {
    /// Example Calendar Carousel without header and custom prev & next button

    return new Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(
              top: 30.0,
              bottom: 16.0,
              left: 16.0,
              right: 16.0,
            ),
            child: new Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  _currentMonth,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26.0,
                  ),
                )),
                FlatButton(
                  child: Text('PREV'),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month - 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                ),
                FlatButton(
                  child: Text('NEXT'),
                  onPressed: () {
                    setState(() {
                      _targetDateTime = DateTime(
                          _targetDateTime.year, _targetDateTime.month + 1);
                      _currentMonth = DateFormat.yMMM().format(_targetDateTime);
                    });
                  },
                )
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 16.0),
            child: _calendarCarouselNoHeader(),
          ), //
        ],
      ),
    ));
  }

  showAllEventsAtDate(List<PostModel> posts) {
    AlertDialog alert = AlertDialog(
      title: Text("Events of this date are,"),
      content: Container(
        height: MediaQuery.of(context).size.height * .3,
        child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              PostModel post = posts[index];
              return GestureDetector(
                onTap: () async {
                  onPostClick(post);
                },
                child: Container(
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.lightGreen.withOpacity(.3),
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Row(
                    children: [
                      Text(
                        post.title,
                        style: TextStyle(fontSize: 13),
                      ),
                      Spacer(),
                      Icon(Icons.arrow_forward_rounded),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                ),
              );
            }),
      ),
      actions: [
        TextButton(
          child: Text("OK"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        )
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
