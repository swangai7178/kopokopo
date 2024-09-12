import 'package:flutter/material.dart';
import 'package:transaction_management_app/business/model/transactionmodel.dart';
import 'package:transaction_management_app/business/service/transactionservice.dart';
import 'package:transaction_management_app/screens/transaction_form.dart';

class TransactionList extends StatefulWidget {
  const TransactionList({super.key});

  @override
  State<TransactionList> createState() => _TransactionListState();
}

class _TransactionListState extends State<TransactionList> {
  final TransactionService transactionService = TransactionService();
  late Future<List<Transactions>> transactionsFuture;

  @override
  void initState() {
    super.initState();
    transactionsFuture = transactionService.getTransactions();
  }

  Future<void> _refreshTransactions() async {
    setState(() {
      transactionsFuture = transactionService.getTransactions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transaction List')),
      
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height*.36,
            child: TransactionForm(),
            
          ),

          SizedBox(
            height: MediaQuery.of(context).size.height*.55,
            child: RefreshIndicator(
              onRefresh: _refreshTransactions,
              child: FutureBuilder<List<Transactions>>(
                future: transactionsFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text('No transactions found'));
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.all(8.0),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final transaction = snapshot.data![index];
                        return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8.0),
                          elevation: 4.0,
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(16.0),
                            leading: Icon(
                              Icons.attach_money,
                              color: Colors.green[700],
                            ),
                            title: Text(transaction.accountId.toString(), style: const TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('Amount: ${transaction.amount}', style: TextStyle(color: Colors.grey[700])),
                            trailing: Icon(Icons.chevron_right, color: Colors.grey[600]),
                            onTap: () {
                              // Handle item tap if needed
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
