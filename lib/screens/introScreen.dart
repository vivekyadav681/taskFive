import 'package:flutter/material.dart';

class Introscreen extends StatelessWidget {
  const Introscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/Group75.png',
              width: 311,
              height: 308.37,
            ),
            Image.asset('assets/images/Frame59.png'),
          ],
        ),
      ),
    );
  }
}
