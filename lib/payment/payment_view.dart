import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:payment_method/widget/widget_view.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Payment")),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            processPayment(context);
          },
          child: const Text("Pay Now"),
        ),
      ),
    );
  }

  void processPayment(BuildContext context) async {
    try {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Processing Payment...")),
      );

      const clientSecret = 'your-client-secret';

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: const SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: 'Demo Shop',
        ),
      );

      await Stripe.instance.presentPaymentSheet();

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SuccessScreen()),
      );
    } catch (e) {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => ErrorScreen(error: e.toString())),
      );
    }
  }
}
