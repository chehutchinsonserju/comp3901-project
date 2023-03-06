import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class _ProfileScreenState extends StatefulWidget {
  const _ProfileScreenState({super.key});

  @override
  State<_ProfileScreenState> createState() => __ProfileScreenStateState();
}

class __ProfileScreenStateState extends State<_ProfileScreenState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("This is your home page"),
      ),
    );
  }
}
