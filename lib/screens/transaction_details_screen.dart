import 'package:flutter/material.dart';
import 'package:qr_payment/screens/dashboard_screen.dart';

enum TransactionType { sent, received }

class TransactionDetailsScreen extends StatefulWidget {
  const TransactionDetailsScreen({super.key});

  @override
  _TransactionDetailsScreenState createState() => _TransactionDetailsScreenState();
}

class _TransactionDetailsScreenState extends State<TransactionDetailsScreen> {
  final List<Transaction> _transactions = [
    Transaction(id: '1', amount: 50.0, date: '2024-07-20', time: '10:30 AM', description: 'Payment to John Doe', type: TransactionType.sent, location: 'New York'),
    Transaction(id: '2', amount: 75.0, date: '2024-07-19', time: '02:15 PM', description: 'Payment from Jane Smith', type: TransactionType.received, location: 'London'),
    Transaction(id: '3', amount: 120.0, date: '2024-07-18', time: '09:00 AM', description: 'Grocery Shopping', type: TransactionType.sent, location: 'Paris'),
    Transaction(id: '4', amount: 30.0, date: '2024-07-17', time: '04:45 PM', description: 'Coffee with friend', type: TransactionType.sent, location: 'Berlin'),
    Transaction(id: '5', amount: 200.0, date: '2024-07-16', time: '11:00 AM', description: 'Online Purchase', type: TransactionType.sent, location: 'Tokyo'),
  ];

  List<Transaction> _filteredTransactions = [];
  final TextEditingController _searchController = TextEditingController();
  int _selectedIndex = 2; // Set initial index for Transactions

  @override
  void initState() {
    super.initState();
    _filteredTransactions = _transactions;
    _searchController.addListener(_filterTransactions);
  }

  void _filterTransactions() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredTransactions = _transactions.where((t) {
        return t.description.toLowerCase().contains(query) ||
            t.date.contains(query) ||
            t.time.toLowerCase().contains(query) || // Include time in search
            t.location.toLowerCase().contains(query) || // Include location in search
            t.amount.toString().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
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
        Navigator.pushReplacementNamed(context, '/qr_hub');
        break;
      case 2:
        // Already on Transactions, do nothing
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transactions'),
        backgroundColor: Colors.lightGreen.shade700,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/dashboard');
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by description, date, time, amount, or location',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide.none,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 16.0),
              ),
            ),
          ),
          Expanded(
            child: _filteredTransactions.isEmpty
                ? const Center(
                    child: Text(
                      'No transactions found.',
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _filteredTransactions.length,
                    itemBuilder: (context, index) {
                      final transaction = _filteredTransactions[index];
                      final color = transaction.type == TransactionType.sent ? Colors.red : Colors.green;
                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: color.withOpacity(0.1),
                            child: Icon(Icons.receipt_long, color: color),
                          ),
                          title: Text(
                            transaction.description,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Date: ${transaction.date} Time: ${transaction.time}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                              Text(
                                'Location: ${transaction.location}',
                                style: const TextStyle(color: Colors.grey),
                              ),
                            ],
                          ),
                          trailing: Text(
                            '${transaction.type == TransactionType.sent ? '-' : '+'}£${transaction.amount.toStringAsFixed(2)}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: color,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
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

class Transaction {
  final String id;
  final double amount;
  final String date;
  final String time;
  final String description;
  final TransactionType type;
  final String location;

  Transaction({required this.id, required this.amount, required this.date, required this.time, required this.description, required this.type, required this.location});
}
