import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'adaptive_text_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;

  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  void _submitData() {
    final enteredTitle = _titleController.text.trim();
    final enteredAmount = double.tryParse(_amountController.text) ?? -1;

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      // ScaffoldMessenger.of(context)
      //     .showSnackBar(SnackBar(content: Text('Added to favorite')));
      return;
    }

    widget.addTx(
      _titleController.text,
      double.parse(_amountController.text),
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) return;
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData(),
              ),
              TextField(
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                onSubmitted: (_) => _submitData(),
              ),
              Container(
                height: 75,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    AdaptiveTextButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: _submitData,
                child: Text(
                  'Add Transaction',
                  style: Theme.of(context).textTheme.button,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
