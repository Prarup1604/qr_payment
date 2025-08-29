import 'package:flutter/material.dart';
import 'package:qr_payment/screens/dashboard_screen.dart';
import 'package:qr_payment/screens/login_screen.dart';
import 'package:qr_payment/screens/registration_screen.dart';
import 'package:qr_payment/screens/welcome_screen.dart';
import 'package:qr_payment/screens/qr_scanner_screen.dart';
import 'package:qr_payment/screens/transaction_details_screen.dart';
import 'package:qr_payment/screens/profile_screen.dart';
import 'package:qr_payment/screens/receive_payment_screen.dart';
import 'package:qr_payment/screens/load_money_screen.dart';
import 'package:qr_payment/screens/qr_hub_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'QR Payment',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegistrationScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/qr_scanner': (context) => const QrScannerScreen(),
        '/transaction_details': (context) => const TransactionDetailsScreen(),
        '/profile': (context) => ProfileScreen(),
        '/receive_payment': (context) => const ReceivePaymentScreen(),
        '/load_money': (context) => const LoadMoneyScreen(),
        '/qr_hub': (context) => const QrHubScreen(),
      },
    );
  }
}