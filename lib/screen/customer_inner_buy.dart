import 'package:flutter/material.dart';

class CustomerInnerBuy extends StatefulWidget {
  const CustomerInnerBuy({super.key});

  @override
  State<CustomerInnerBuy> createState() => _CustomerInnerBuyState();
}

class _CustomerInnerBuyState extends State<CustomerInnerBuy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('구매 내역'),
      ),
      body: Column(
        children: [
          Text('구매중'),
        ],
      ),
    );
  }
}
