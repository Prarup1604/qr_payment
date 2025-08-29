import 'package:flutter/material.dart';
import 'package:qr_payment/screens/qr_scanner_screen.dart';
import 'package:qr_payment/screens/receive_payment_screen.dart';

class QrHubScreen extends StatefulWidget {
  const QrHubScreen({super.key});

  @override
  State<QrHubScreen> createState() => _QrHubScreenState();
}

class _QrHubScreenState extends State<QrHubScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedIndex = 1; // Set initial index for Scan and Pay

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        Navigator.pushReplacementNamed(context, '/dashboard');
        break;
      case 1:
        // Already on Scan and Pay, do nothing
        break;
      case 2:
        Navigator.pushReplacementNamed(context, '/transaction_details');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF6B8E23);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan and Pay'),
        backgroundColor: primaryColor,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(icon: Icon(Icons.qr_code_scanner)),
            Tab(icon: Icon(Icons.qr_code)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          QrScannerScreen(),
          ReceivePaymentScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        iconSize: 30.0, // Increased icon size
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code_scanner),
            label: 'Scan and Pay',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey, // Changed unselected item color
        onTap: _onItemTapped,
      ),
    );
  }
}
