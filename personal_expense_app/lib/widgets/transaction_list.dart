import 'package:flutter/material.dart';
import '../models/transaction.dart';
import 'transaction_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    print('Ratio: ' + MediaQuery.of(context).devicePixelRatio.toString());
    return transactions.isEmpty
        ? LayoutBuilder(builder: (bCtx, constraints) {
            return Column(
              children: [
                Text(
                  'Nothing here ...',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: 20),
                Container(
                  height: constraints.maxHeight * 0.5,
                  child:
                      Image.asset('assets/images/avg.png', fit: BoxFit.cover),
                ),
              ],
            );
          })
        : ListView(
            children: transactions
                .map(
                  (tx) => TransactionItem(
                    key: ValueKey(tx.id),
                    transaction: tx,
                    deleteTx: deleteTx,
                  ),
                )
                .toList(),
          );
  }
}
