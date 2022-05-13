// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:venetian_pines/Models/payment_model.dart';
// import 'package:venetian_pines/Services/payment_service.dart';

// class PaymentProvider extends ChangeNotifier {
//   List<PaymentModel> payments = [];
//   PaymentService ps = new PaymentService();
//   StripeService stripeService = StripeService();

//   // make payment
//   Future<bool> makePayment(String amount, String cardHolderName, String cvvCode,
//       String cardNumber, String expiryDate) async {
//     try {
//       final paymentIntent =
//           await StripeService.createPaymentIntent(amount, "USD");

//       if (paymentIntent == null || paymentIntent["client_secret"] == null)
//         return false;
//       await Stripe.instance.initPaymentSheet(
//           paymentSheetParameters: SetupPaymentSheetParameters(
//               paymentIntentClientSecret: paymentIntent["client_secret"],
//               style: ThemeMode.light,
//               merchantDisplayName: "Venetian Pines"));

//       await Stripe.instance.presentPaymentSheet(
//         parameters: PresentPaymentSheetParameters(
//             clientSecret: paymentIntent["client_secret"], confirmPayment: true),
//       );
//       return true;
//     } catch (e) {
//       print(e);
//       return false;
//     }
//   }

//   // get payment history
//   Future<void> getPaymentHistory() async {
//     payments = await ps.getPaymentHistory();
//     payments.sort((a, b) => a.dateTime.compareTo(b.dateTime));
//     payments = payments.reversed.toList();
//     notifyListeners();
//   }
// }