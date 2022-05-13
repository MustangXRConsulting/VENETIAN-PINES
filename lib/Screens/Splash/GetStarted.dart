// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:provider/provider.dart';
// import 'package:venetian_pines/Providers/UserProvider.dart';
// import 'package:venetian_pines/Screens/Login/LoginPage.dart';

// class GetStarted extends StatefulWidget {
//   @override
//   _GetStartedState createState() => _GetStartedState();
// }

// class _GetStartedState extends State<GetStarted> {
//   @override
//   Widget build(BuildContext context) {
//     var h = MediaQuery.of(context).size.height;
//     var w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         child: Stack(
//           children: [
//             Image.asset(
//               'assets/bg.png',
//               height: double.infinity,
//               width: double.infinity,
//               fit: BoxFit.fill,
//             ),
//             Image.asset('assets/newGrad.png',
//                 height: double.infinity,
//                 width: double.infinity,
//                 fit: BoxFit.fill),
//             Positioned(
//               top: h * 0.06,
//               left: w * 0.8,
//               child: GestureDetector(
//                 onTap: () async {
//                   await Provider.of<UserProvider>(context, listen: false)
//                       .welcomedUser();
//                   Navigator.of(context).pushReplacement(
//                     MaterialPageRoute(builder: (_) => LoginPage()),
//                   );
//                 },
//                 child: Row(
//                   children: [
//                     Text(
//                       'Skip',
//                       style: TextStyle(
//                           color: Color.fromRGBO(1, 68, 58, 1),
//                           fontWeight: FontWeight.bold,fontSize: 16),
//                     ),
//                     Icon(
//                       Icons.arrow_right_alt,
//                       color: Color.fromRGBO(1, 68, 58, 1),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//                 top: h * 0.3,
//                 child: Container(
//                   width: w,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset(
//                         'assets/bottom_nav/logo.svg',
//                         width: w * .4,
//                         height: w * .4,
//                         semanticsLabel: 'Close',
//                       )
//                     ],
//                   ),
//                 )),
//             Positioned(
//               top: h * 0.55,
//               child: Container(
//                 width: w,
//                 child: Row(
//                   mainAxisSize: MainAxisSize.max,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Center(
//                       child: Text(
//                         'Find Homeowner services',
//                         style: TextStyle(
//                             color: Color(0xff01443A),
//                             fontWeight: FontWeight.w600,
//                             fontSize: 24),
//                       ),
//                     )
//                   ],
//                 ),
//               ),
//             ),
//             Positioned(
//                 top: h * 0.6,
//                 child: Container(
//                   width: w,
//                   child: Row(
//                     mainAxisSize: MainAxisSize.max,
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Center(
//                         child: Text(
//                           'Lorem ipsum dolor sit amet,\nconsectetur adipiscing elit. Nunc\nrutrum lobortis in est nibh eget\ncongue semper. Fringilla ut at.',
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                               color: Color(0xff01443A),
//                               fontWeight: FontWeight.w600,
//                               fontSize: 18),
//                         ),
//                       )
//                     ],
//                   ),
//                 )),
//             Positioned(
//                 top: h * 0.8,
//                 left: w * 0.07,
//                 child: GestureDetector(
//                   onTap: () async {
//                     await Provider.of<UserProvider>(context, listen: false)
//                         .welcomedUser();
//                     Navigator.of(context).pushReplacement(
//                       MaterialPageRoute(builder: (_) => LoginPage()),
//                     );
//                   },
//                   child: Container(
//                     height: h * 0.08,
//                     width: w * 0.86,
//                     decoration: BoxDecoration(
//                       color: Color(0xff01443A),
//                       borderRadius: BorderRadius.circular(4),
//                     ),
//                     child: Center(
//                       child: Text(
//                         'Get Started',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontSize: 20,
//                             fontWeight: FontWeight.w600),
//                       ),
//                     ),
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
