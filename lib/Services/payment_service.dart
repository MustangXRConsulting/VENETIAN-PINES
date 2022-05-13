import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:venetian_pines/Models/payment_model.dart';

class StripeTransactionResponse {
  String message;
  bool success;
  StripeTransactionResponse({this.message, this.success});
}

class StripeService {
  static String apiBase = 'https://api.stripe.com/v1';
  static String paymentApiUrl = '${StripeService.apiBase}/payment_intents';
  static String secret =
      'sk_test_51JlqkXES1zWd1wiHjPRzXm6rdjoCww1UCBwUC8FuKrxDEhIm7wwk4gXZdPQ8U1KkipZF8z10YUY9Z9yHPEK9mEy900TmziKQvN';
  static Map<String, String> headers = {
    'Authorization': 'Bearer ${StripeService.secret}',
    'Content-Type': 'application/x-www-form-urlencoded'
  };
  static init() {
    // StripePayment.setOptions(StripeOptions(
    //     publishableKey:
    //         "pk_test_51JlqkXES1zWd1wiHC86XXrxtFR26rtChDHNg3mMnPWkoQDoeUstxC7MyxX9DKhLnfRPiLNnawt3Ghkhv80dJuIpw00IevkbhYu",
    //     merchantId: "Test",
    //     androidPayMode: 'test'));
  }

  static Future<StripeTransactionResponse> payWithNewCard(
      {String amount,
      String currency,
      String cvc,
      String number,
      String expMonth,
      String expYear,
      String name}) async {
    try {
      // var paymentMethod = await StripePayment.paymentRequestWithCardForm(
      //     CardFormPaymentRequest());
      // var paymentMethod = await StripeService.createPaymentMethod(
      //     PaymentMethodRequest(
      //         billingAddress: BillingAddress(name: name),
      //         card: CreditCard(
      //             expMonth: int.parse(expMonth),
      //             expYear: int.parse(expYear),
      //             number: number,
      //             name: name,
      //             cvc: cvc)));
      // var paymentIntent =
      //     await StripeService.createPaymentIntent(amount, currency);
      // var response = await StripePayment.confirmPaymentIntent(PaymentIntent(
      //     clientSecret: paymentIntent['client_secret'],
      //     paymentMethodId: paymentMethod.id));
      // if (response.status == 'succeeded') {
      //   return new StripeTransactionResponse(
      //       message: 'Transaction successful', success: true);
      // } else {
      //   return new StripeTransactionResponse(
      //       message: 'Transaction failed', success: false);
      // }
    } on PlatformException catch (err) {
      return StripeService.getPlatformExceptionErrorResult(err);
    } catch (err) {
      return new StripeTransactionResponse(
          message: 'Transaction failed: ${err.toString()}', success: false);
    }
  }

  static getPlatformExceptionErrorResult(err) {
    String message = 'Something went wrong';
    if (err.code == 'cancelled') {
      message = 'Transaction cancelled';
    }

    return new StripeTransactionResponse(message: message, success: false);
  }

  static Future<Map<String, dynamic>> createPaymentIntent(
      String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': amount+"00",
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(Uri.parse(StripeService.paymentApiUrl),
          body: body, headers: StripeService.headers);
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
    return null;
  }
}

class PaymentService {
  // pay with card
  Future<bool> payingWithCard(String amount, String cardHolderName,
      String cvvCode, String cardNumber, String expiryDate) async {
    StripeService.init();
    StripeTransactionResponse res = await StripeService.payWithNewCard(
        amount: amount,
        currency: 'usd',
        name: cardHolderName,
        cvc: cvvCode,
        number: cardNumber,
        expYear: expiryDate.split('/')[1],
        expMonth: expiryDate.split('/')[0]);
    if (res.success) {
      int cl = cardNumber.length;
      await saveToHistory(cardHolderName, amount, cardNumber.substring(cl - 4));
    }
    return res.success;
  }

  // save to history
  Future<void> saveToHistory(
      String cardHolderName, String amount, String cardEnd) async {
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      String email = sharedPref.getString('user');
      var uuid = Uuid();
      String id = uuid.v1();
      Map<String, dynamic> data = {
        'payId': id,
        'title': cardHolderName,
        'email': email,
        'cardEnding': cardEnd,
        'amount': amount,
        'dateTime': DateTime.now()
      };
      await FirebaseFirestore.instance.collection('PaymentHistory').add(data);
    } catch (e) {
      print("Error saving payment to history $e");
    }
  }

  // get payment history
  Future<List<PaymentModel>> getPaymentHistory() async {
    List<PaymentModel> payHistory = [];
    try {
      SharedPreferences sharedPref = await SharedPreferences.getInstance();
      String email = sharedPref.getString('user');
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('PaymentHistory')
          .where('email', isEqualTo: email)
          .get();
      if (snapshot.docs.length > 0) {
        for (DocumentSnapshot ds in snapshot.docs) {
          payHistory.add(PaymentModel.fromJson(ds.data()));
        }
      }
      return payHistory;
    } catch (e) {
      print("Error getting payment history");
      return payHistory;
    }
  }
}