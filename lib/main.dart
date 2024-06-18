import 'package:flutter/material.dart';
import 'package:flutter_applepay/pay_widget.dart';
import 'package:flutter_stripe/flutter_stripe.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = 'pk_test_51P7C4c00NkCHMLbt8sy1dlUCjACR1wmnnFDrJjYR3UjSrkMBgKjhTviEXCqw0sr7hxIXccuHAgwYRzoxgg3CHKsk00g0gGi3jM'; 
  Stripe.merchantIdentifier = 'merchant.info.gassho';
  await Stripe.instance.applySettings();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: PayWidget(),
        ),
      ),
    );
  }
}

