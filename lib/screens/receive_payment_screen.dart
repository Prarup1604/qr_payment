
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ReceivePaymentScreen extends StatelessWidget {
  const ReceivePaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // In a real app, you would fetch the user's ID from your authentication service
    const String userId = "12345"; 
    const String qrData = '{"user_id": "$userId"}';

    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Code Share'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.account_balance_wallet, size: 100, color: Colors.green),
            SizedBox(height: 20),
            Text(
              'Please scan a code to',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            QrImageView(
              data: qrData,
              version: QrVersions.auto,
              size: 200.0,
            ),
            SizedBox(height: 20),
            Text(
              'Transfer fund ',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
