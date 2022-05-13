// import 'package:flutter/material.dart';
// import 'package:jiffy/jiffy.dart';
// import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:venetian_pines/Models/payment_model.dart';
// import 'package:venetian_pines/Providers/payment_provider.dart';
// import 'package:venetian_pines/Screens/ChatPage/Chat.dart';

// class ViewPayment extends StatefulWidget {
//   @override
//   _ViewPaymentState createState() => _ViewPaymentState();
// }

// class _ViewPaymentState extends State<ViewPayment> {
//   double w, h;
//   PaymentProvider paymentProvider;
//   bool loading = true;

//   init() async {
//     paymentProvider = Provider.of<PaymentProvider>(context, listen: false);
//     await paymentProvider.getPaymentHistory();
//     setState(() {
//       loading = false;
//     });
//   }

//   @override
//   void initState() {
//     init();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     h = MediaQuery.of(context).size.height;
//     w = MediaQuery.of(context).size.width;
//     final cp = context.watch<PaymentProvider>();
//     return Scaffold(
//       // extendBodyBehindAppBar: true,
//       // extendBody: true,
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back,
//               color: Colors.white), // set your color here
//           onPressed: () {
//             Navigator.of(context).pop();
//           },
//         ),
//         backgroundColor: Color.fromRGBO(1, 68, 58, 1),
//         title: Row(
//           mainAxisSize: MainAxisSize.max,
//           children: [
//             Text(
//               'Payment Record',
//               style: TextStyle(
//                 fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
//             ),
//             Spacer(),
//             GestureDetector(
//               onTap: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => ChatScreen(
//                               peerId: 'admin@admin.com',
//                               peerAvatar: '',
//                               peerName: 'admin',
//                               mode: 1,
//                             )));
//               },
//               child: Image.asset(
//                 'assets/icons/chat.png',
//                 width: 30,
//                 height: 30,
//               ),
//             )
//           ],
//         ),
//       ),
//       body: Column(
//         children: [Expanded(child: getPayments(cp.payments))],
//       ),
//     );
//   }

//   Widget getPayments(List<PaymentModel> payments) {
//     return !loading
//         ? Container(
//             padding: EdgeInsets.all(8),
//             child: ListView.builder(
//                 shrinkWrap: true,
//                 itemCount: payments.length,
//                 itemBuilder: (context, index) {
//                   return itemView(payments[index]);
//                 }),
//           )
//         : Center(
//             child: progress(),
//           );
//   }

//   Widget itemView(PaymentModel paymentModel) {
//     return Container(
//       width: w,
//       height: h * .1,
//       child: Column(
//         children: [
//           Expanded(
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 5,
//                 ),
//                 amountAvatar(),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisSize: MainAxisSize.max,
//                     children: [
//                       Expanded(
//                         child: Row(
//                           mainAxisSize: MainAxisSize.max,
//                           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                           children: [
//                             Text(
//                               'Payment of \$' + paymentModel.amount,
//                               style: TextStyle(
//                                   color: Color.fromRGBO(1, 68, 58, 1),
//                                   fontWeight: FontWeight.w700,
//                                   fontSize: 18),
//                             ),
//                             Spacer(),
//                             Text(
//                               Jiffy(paymentModel.dateTime).yMMMMd,
//                               style:
//                                   TextStyle(color: Colors.grey, fontSize: 12),
//                             ),
//                             SizedBox(
//                               width: 15,
//                             )
//                           ],
//                         ),
//                       ),
//                       Text(
//                         'Using card ending in ' + paymentModel.cardEnding,
//                         style: TextStyle(
//                             color: Colors.black,
//                             fontWeight: FontWeight.w500,
//                             fontSize: 16),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           Divider()
//         ],
//       ),
//     );
//   }

//   Widget progress() {
//     return Center(
//       child: NutsActivityIndicator(
//           radius: 15,
//           activeColor: Color(0xff447727).withOpacity(.6),
//           inactiveColor: Color(0xff447727).withOpacity(.2),
//           tickCount: 11,
//           startRatio: 0.55,
//           animationDuration: Duration(milliseconds: 500)),
//     );
//   }

//   Widget amountAvatar() {
//     return Container(
//       width: 50,
//       height: 50,
//       decoration: BoxDecoration(color: Colors.green, shape: BoxShape.circle),
//       child: Icon(
//         Icons.attach_money,
//         color: Colors.white,
//       ),
//     );
//   }
// }
