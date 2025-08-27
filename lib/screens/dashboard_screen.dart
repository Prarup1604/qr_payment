import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        // Handle Home navigation
        break;
      case 1:
        // No navigation for My Payment as per user request
        break;
      case 2:
        // Handle Transactions navigation
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
              IconButton(
                icon: const Icon(Icons.account_circle),
                onPressed: () {
                  Navigator.pushNamed(context, '/profile');
                },
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
                      // Handle Load Money
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
                      padding: const EdgeInsets.all(8),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.payment),
            label: 'My Payment',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt_long),
            label: 'Transactions',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),
    );
  }
}