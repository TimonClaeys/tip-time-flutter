import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './state.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Tip time';
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: appTitle,
        home: Scaffold(
          appBar: AppBar(
            title: const Text(appTitle),
          ),
          body: const MyCustomForm(),
        ),
      ),
    );
  }
}

class MyCustomForm extends StatelessWidget {
  const MyCustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Wrap(
        runSpacing: 10,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(
                child: Text('Calculate Tip', style: TextStyle(fontSize: 24))),
          ),
          NumericTextField(
            text: 'Bill Amount',
            callback: (value) => appState.setBillAmount(double.tryParse(value)),
          ),
          NumericTextField(
            text: 'Tip (%)',
            callback: (value) => appState.setTipAmount(double.tryParse(value)),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Round up tip?'),
              Switch(
                value: appState.roundUp,
                onChanged: (value) => appState.switchRoundUp(value),
              )
            ],
          ),
          Center(
              child: Text(
            'Tip Amount: € ${appState.getTipAmount()}',
            style: const TextStyle(fontSize: 24),
          ))
        ],
      ),
    );
  }
}

class NumericTextField extends StatelessWidget {
  const NumericTextField({
    super.key,
    required this.text,
    required this.callback,
  });

  final String text;

  final void Function(String value) callback;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: text,
        filled: true,
      ),
      keyboardType: TextInputType.number,
      onChanged: callback,
    );
  }
}
