import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_payment/screens/profile_screen.dart';
import 'package:qr_payment/screens/transaction_details_screen.dart';

class DashboardScreen extends StatefulWidget {
  final int selectedIndex;
  const DashboardScreen({super.key, this.selectedIndex = 0});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  late int _selectedIndex;
  String? _imagePath;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    if (_selectedIndex == index) return;
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Already on the dashboard, do nothing
        break;
      case 1:
        Navigator.pushReplacementNamed(context, '/qr_hub');
        break;
      case 2:
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const TransactionDetailsScreen()));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(237, 255, 255, 255), // Changed background color to light green
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight), // Default AppBar height
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.lightGreen.shade400, Colors.lightGreen.shade800],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.green, // Make AppBar transparent to show gradient
            elevation: 0, // Remove shadow
            title: const Text('WalletPay'),
            toolbarTextStyle: TextStyle(),
            actions: [
              IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  // Handle search
                },
              ),
              IconButton(
                icon: const Icon(Icons.notifications),
                onPressed: () {
                  // Handle notifications
                },
              ),
              GestureDetector(
                onTap: () async {
                  final result = await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ProfileScreen()),
                  );
                  if (result != null) {
                    setState(() {
                      _imagePath = result as String?;
                    });
                  }
                },
                child: CircleAvatar(
                  radius: 20,
                  backgroundImage: _imagePath != null ? FileImage(File(_imagePath!)) : null,
                  child: _imagePath == null
                      ? const Icon(Icons.account_circle, size: 40)
                      : null,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                elevation: 4.0,
                margin: const EdgeInsets.only(bottom: 20.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Wallet Balance:',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '£2000.6',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                ),
              ),
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  // Row 1: Load Money
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/load_money');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(4),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.account_balance_wallet, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Load Money', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  // Row 2: Scan QR, Generate Static QR, Request Payment
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/qr_scanner');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.qr_code_scanner, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Scan QR', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/receive_payment');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.qr_code, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Generate Static QR', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ],
              ),
              const SizedBox(height: 20.0),
              const Text(
                'Future Works', // Changed from 'Separator'
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20.0), // Added spacing
              GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 3, // 3 items per row
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle Bus Ticket
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.directions_bus, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Bus Ticket', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Tube Ticket
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.train, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('National Railway', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Airplane Ticket
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.flight, size:40,color: Colors.green),
                        SizedBox(height: 8),
                        Text('Airplane Ticket', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Water Bill
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.water_drop, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Water Bill', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Electricity Bill
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.lightbulb, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Electricity Bill', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Internet Bill
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.wifi, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Internet Bill', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Bank Transfer
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.account_balance, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Bank Transfer', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Send Money
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.send, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Send Money', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Request Payment
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.request_quote, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Request Payment', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle E-Learning
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.school, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('E-Learning', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Credit Card
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.credit_card, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Credit Card', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      // Handle Vacancy
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.all(8),
                      textStyle: const TextStyle(fontSize: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: const Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.work, size: 40, color: Colors.green),
                        SizedBox(height: 8),
                        Text('Vacancy', textAlign: TextAlign.center),
                      ],
                    ),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle FAB press
          print('Floating Action Button pressed!');
        },
        child: const Icon(Icons.add),
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