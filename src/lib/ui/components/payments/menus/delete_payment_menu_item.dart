import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:logger/logger.dart';
import 'package:pokinia_lending_manager/providers/payment_provider.dart';
import 'package:pokinia_lending_manager/services/logger.dart';
import 'package:provider/provider.dart';

class DeletePaymentMenuItem extends StatelessWidget {
  final Logger _logger = getLogger('DeletePaymentPopupMenuButton');
  final String paymentId;

   DeletePaymentMenuItem({super.key, required this.paymentId});


  void _deletePayment(BuildContext context, String paymentId) {
    _logger.i('_deletePayment - id: $paymentId');

    var paymentProvider = Provider.of<PaymentProvider>(context, listen: false);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete payment'),
          content: const Text('Are you sure you want to delete this payment?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                // Add your deletion logic here
                var response = await paymentProvider.deletePayment(
                    paymentId, 'Deleted by user from payment page');

                if (response.succeeded) {
                  Navigator.of(context).pop();
                } else {
                  Fluttertoast.showToast(
                      msg: response.message,
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 1,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuItem<int>(
      onTap: () => _deletePayment(context, paymentId),
      child: const Column(
        children: [
          Row(
            children: [
              Icon(
                Icons.delete,
                color: Colors.red,
              ),
              SizedBox(width: 12.0),
              Text(
                "Delete payment",
              )
            ],
          ),
        ],
      ),
    );
  }
}

