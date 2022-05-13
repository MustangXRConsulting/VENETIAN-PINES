import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:venetian_pines/Models/maintenance_model.dart';
import 'package:venetian_pines/Providers/maintenance_provider.dart';

class TrackOrderList extends StatefulWidget {
  @override
  _TrackOrderListState createState() => _TrackOrderListState();
}

class _TrackOrderListState extends State<TrackOrderList> {
  double w, h;
  MaintenanceProvider maintenanceProvider;
  List<MaintenanceModel> requests = [];
  bool loading = true;

  init() async {
    SharedPreferences sharedPref = await SharedPreferences.getInstance();
    maintenanceProvider =
        Provider.of<MaintenanceProvider>(context, listen: false);
    await maintenanceProvider.getAllRequests(sharedPref.getString('user'));
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final cp = context.watch<MaintenanceProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Track Requests',
          style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)
        ),
        backgroundColor: Color.fromRGBO(1, 68, 58, 1),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: !loading
            ? ListView.builder(
                itemCount: cp.maintenances.length,
                itemBuilder: (context, index) {
                  return itemView(cp.maintenances[index]);
                })
            : progress(),
      ),
    );
  }

  Widget itemView(MaintenanceModel maintenanceModel) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
          color: Color(0x30447727), borderRadius: BorderRadius.circular(10)),
      child: Row(
        children: [
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "Issue/Work Order",
                      style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),
                    ),
                    Spacer(),
                    Container(
                      width: 15,
                      height: 15,
                      decoration: BoxDecoration(
                          color: Colors.green, shape: BoxShape.circle),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      maptoStatus(maintenanceModel.status),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                  ],
                ),
                SingleChildScrollView(
                    child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(maintenanceModel.issue),
                )),
                Row(
                  children: [
                    Text(
                      "Date Requested : ",
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      Jiffy(maintenanceModel.dateCreated).yMMMMd,
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
                Row(
                  children: [
                    Text(
                      "Last Updated : ",
                      style: TextStyle(fontSize: 13),
                    ),
                    Text(
                      Jiffy(maintenanceModel.lastUpdated).yMMMMd,
                      style: TextStyle(fontSize: 13),
                    ),
                    SizedBox(
                      width: 15,
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  String maptoStatus(String val) {
    if (val == '0') {
      return 'Requested';
    } else if (val == '1') {
      return 'Viewed';
    } else if (val == '2') {
      return 'In Progress';
    } else if (val == '3') {
      return 'Closed';
    }
  }

  Widget progress() {
    return Center(
      child: NutsActivityIndicator(
          radius: 15,
          activeColor: Color(0xff447727).withOpacity(.6),
          inactiveColor: Color(0xff447727).withOpacity(.2),
          tickCount: 11,
          startRatio: 0.55,
          animationDuration: Duration(milliseconds: 500)),
    );
  }
}
