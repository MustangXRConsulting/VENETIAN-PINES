import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:venetian_pines/Providers/UserProvider.dart';
import 'package:venetian_pines/Providers/document_provider.dart';
import 'package:venetian_pines/Providers/maintenance_provider.dart';
import 'package:venetian_pines/Providers/payment_provider.dart';
import 'package:venetian_pines/Providers/post_provider.dart';
import 'package:venetian_pines/Screens/Splash/SplashPage.dart';

double devHeight;
double devWidth;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // Stripe.publishableKey =
  //     "pk_test_51JlqkXES1zWd1wiHC86XXrxtFR26rtChDHNg3mMnPWkoQDoeUstxC7MyxX9DKhLnfRPiLNnawt3Ghkhv80dJuIpw00IevkbhYu";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider<UserProvider>(
            create: (_) => UserProvider(),
          ),
          ChangeNotifierProvider<PostProivder>(
            create: (_) => PostProivder(),
          ),
          ChangeNotifierProvider<MaintenanceProvider>(
            create: (_) => MaintenanceProvider(),
          ),
          ChangeNotifierProvider<DocumentProvider>(
            create: (_) => DocumentProvider(),
          ),
          // ChangeNotifierProvider<PaymentProvider>(
          //   create: (_) => PaymentProvider(),
          // )
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'VENETIAN PINES',
          theme:
              ThemeData(primarySwatch: Colors.blue, fontFamily: 'crimsonpro'),
          home: SplashPage(),
        ));
  }
}
