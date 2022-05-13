// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/credit_card_brand.dart';
// import 'package:flutter_credit_card/credit_card_form.dart';
// import 'package:flutter_credit_card/credit_card_model.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:nuts_activity_indicator/nuts_activity_indicator.dart';
// import 'package:provider/provider.dart';
// import 'package:toast/toast.dart';
// import 'package:venetian_pines/Providers/payment_provider.dart';
// import 'package:venetian_pines/constant.dart';

// class CreditCardPage extends StatefulWidget {
//   @override
//   State<StatefulWidget> createState() {
//     return CreditCardPageState();
//   }
// }

// class CreditCardPageState extends State<CreditCardPage> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String amount;
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   bool useGlassMorphism = false;
//   bool useBackgroundImage = false;
//   OutlineInputBorder border;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//   double w, h;
//   bool submit = false;

//   @override
//   void initState() {
//     border = OutlineInputBorder(
//       borderSide: BorderSide(
//         color: Colors.grey.withOpacity(0.7),
//         width: 2.0,
//       ),
//     );
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     w = MediaQuery.of(context).size.width;
//     h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       appBar: AppBar(
//         brightness: Brightness.dark,
//         title: Text(
//           'Pay My HOA',
//           style: TextStyle(
//                 fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
//         ),
//         backgroundColor: Color.fromRGBO(1, 68, 58, 1),
//         elevation: 0,
//         iconTheme: IconThemeData(color: Colors.white),
//       ),
//       resizeToAvoidBottomInset: true,
//       body: SingleChildScrollView(
//         child: Container(
//           width: w,
//           height: h,
//           child: SafeArea(
//             child: Column(
//               children: <Widget>[
//                 // const SizedBox(
//                 //   height: 5,
//                 // ),
//                 // CreditCardWidget(
//                 //   glassmorphismConfig:
//                 //       useGlassMorphism ? Glassmorphism.defaultConfig() : null,
//                 //   cardNumber: cardNumber,
//                 //   expiryDate: expiryDate,
//                 //   cardHolderName: cardHolderName,
//                 //   cvvCode: cvvCode,
//                 //   showBackView: isCvvFocused,
//                 //   obscureCardNumber: true,
//                 //   obscureCardCvv: true,
//                 //   isHolderNameVisible: true,
//                 //   cardBgColor: Colors.green,
//                 //   backgroundImage:
//                 //       useBackgroundImage ? 'assets/card_bg.png' : null,
//                 //   isSwipeGestureEnabled: true,
//                 //   onCreditCardWidgetChange:
//                 //       (CreditCardBrand creditCardBrand) {},
//                 // ),
//                 Expanded(
//                   child: Column(
//                      mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       // CreditCardForm(
//                       //   formKey: formKey,
//                       //   obscureCvv: true,
//                       //   obscureNumber: true,
//                       //   cardNumber: cardNumber,
//                       //   cvvCode: cvvCode,
//                       //   isHolderNameVisible: true,
//                       //   isCardNumberVisible: true,
//                       //   isExpiryDateVisible: true,
//                       //   cardHolderName: cardHolderName,
//                       //   expiryDate: expiryDate,
//                       //   themeColor: Colors.blue,
//                       //   textColor: Colors.black,
//                       //   cardNumberDecoration: InputDecoration(
//                       //     labelText: 'Card Number',
//                       //     hintText: 'XXXX XXXX XXXX XXXX',
//                       //     hintStyle: TextStyle(
//                       //         color: Colors.grey, fontFamily: 'crimsonpro',fontSize: 16),
//                       //     labelStyle: TextStyle(
//                       //         color: Colors.grey,
//                       //         fontSize: 16,
//                       //         fontWeight: FontWeight.bold,
//                       //         fontFamily: 'crimsonpro'),
//                       //     focusedBorder: border,
//                       //     enabledBorder: border,
//                       //   ),
//                       //   expiryDateDecoration: InputDecoration(
//                       //     labelText: 'Expiry',
//                       //     hintText: 'XX/XX',
//                       //     hintStyle: TextStyle(
//                       //         color: Colors.grey, fontFamily: 'crimsonpro',fontSize: 16),
//                       //     labelStyle: TextStyle(
//                       //         color: Colors.grey,
//                       //         fontWeight: FontWeight.bold,
//                       //         fontFamily: 'crimsonpro',fontSize: 16),
//                       //     focusedBorder: border,
//                       //     enabledBorder: border,
//                       //   ),
//                       //   cvvCodeDecoration: InputDecoration(
//                       //     labelText: 'CVV',
//                       //     hintText: 'XXX',
//                       //     hintStyle: TextStyle(
//                       //         color: Colors.grey, fontFamily: 'crimsonpro',fontSize: 16),
//                       //     labelStyle: TextStyle(
//                       //         color: Colors.grey,
//                       //         fontWeight: FontWeight.bold,
//                       //         fontFamily: 'crimsonpro',fontSize: 16),
//                       //     focusedBorder: border,
//                       //     enabledBorder: border,
//                       //   ),
//                       //   cardHolderDecoration: InputDecoration(
//                       //     labelText: 'Card Holder',
//                       //     hintText: 'Your Name',
//                       //     hintStyle: TextStyle(
//                       //         color: Colors.grey, fontFamily: 'crimsonpro',fontSize: 16),
//                       //     labelStyle: TextStyle(
//                       //         color: Colors.grey,
//                       //         fontWeight: FontWeight.bold,
//                       //         fontFamily: 'crimsonpro',fontSize: 16),
//                       //     focusedBorder: border,
//                       //     enabledBorder: border,
//                       //   ),
//                       //   onCreditCardModelChange: onCreditCardModelChange,
//                       // ),
//                       // const SizedBox(
//                       //   height: 10,
//                       // ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * .95,
//                         height: 60,
//                         margin: EdgeInsets.only(left: 18, right: 18, top: 5),
//                         padding: EdgeInsets.all(10),
//                         decoration: BoxDecoration(
//                           color: Colors.white,
//                           border: Border.all(
//                               color: Colors.grey
//                                   .withOpacity(.7), // set border color
//                               width: 2), // set border width
//                           borderRadius: BorderRadius.all(Radius.circular(
//                               4.0)), // set rounded corner radius
//                         ),
//                         child: TextField(
//                           keyboardType: TextInputType.number,
//                           onChanged: (val) {
//                             amount = val;
//                           },
//                           decoration: InputDecoration(
//                             hintText: "Enter amount",
//                             border: InputBorder.none,
//                             labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,fontSize: 16),
//                             hintStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontWeight: FontWeight.bold,fontSize: 16),
//                           ),
//                         ),
//                       ),
//                       const SizedBox(
//                         height: 20,
//                       ),
//                       GestureDetector(
//                         onTap: () async {
//                           FocusScope.of(context).unfocus();
//                           setState(() {
//                             submit = true;
//                           });
//                           await pay();
//                           setState(() {
//                             submit = false;
//                           });
//                         },
//                         child: Container(
//                           height: h * 0.08,
//                           margin: EdgeInsets.symmetric(horizontal: 18),
//                           width: double.infinity,
//                           decoration: BoxDecoration(
//                             color: Color(0xff01443A),
//                             borderRadius: BorderRadius.circular(4),
//                           ),
//                           child: !submit
//                               ? Row(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   children: [
//                                     Text(
//                                       'Checkout',
//                                       style: TextStyle(
//                                           color: Colors.white,
//                                           fontSize: 20,
//                                           fontWeight: FontWeight.w600),
//                                     ),
//                                     SizedBox(
//                                       width: 20,
//                                     ),
//                                     Icon(
//                                       Icons.arrow_forward_ios_rounded,
//                                       color: Colors.white,
//                                     )
//                                   ],
//                                 )
//                               : progress(),
//                         ),
//                       )
//                       // !submit
//                       //     ? ElevatedButton(
//                       //         style: ElevatedButton.styleFrom(
//                       //           shape: RoundedRectangleBorder(
//                       //             borderRadius: BorderRadius.circular(8.0),
//                       //           ),
//                       //           primary: Color(0xff447727),
//                       //         ),
//                       //         child: Container(
//                       //           margin: const EdgeInsets.all(12),
//                       //           child: const Text(
//                       //             'Checkout',
//                       //             style: TextStyle(
//                       //                 color: Colors.white,
//                       //                 fontSize: 18,
//                       //                 letterSpacing: .9,
//                       //                 fontWeight: FontWeight.bold),
//                       //           ),
//                       //         ),
//                       //         onPressed: () async {
//                       //           setState(() {
//                       //             submit = true;
//                       //           });
//                       //           await pay();
//                       //           setState(() {
//                       //             submit = false;
//                       //           });
//                       //         },
//                       //       )
//                       //     : progress(),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
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

//   pay() async {
//     // if (int.parse(amount) < 1) {
//     //   Toast.show('Pay amount can\'t be less than 1\$!', context);
//     //   return;
//     // }
//     // if (cvvCode.isEmpty ||
//     //     cardNumber.isEmpty ||
//     //     cardHolderName.isEmpty ||
//     //     expiryDate.isEmpty) {
//     //   Toast.show('All fields are required!', context);
//     //   return;
//     // }

//     if(!isNumeric(amount)) return Toast.show("Invalid amount", context);

//     if(double.parse(amount)<1) return Toast.show("Minimum amount is 1\$", context);
    
//     bool res = await Provider.of<PaymentProvider>(context, listen: false)
//         .makePayment(amount, cardHolderName, cvvCode, cardNumber, expiryDate);
//     if (res) {
//       // save to history
//       Toast.show("Payment Successful!", context);
//       Navigator.pop(context);
//     } else {
//       Toast.show("Payment UnSuccessful!", context);
//     }
//   }

//   void onCreditCardModelChange(CreditCardModel creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }
// }
