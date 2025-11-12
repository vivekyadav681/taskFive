import 'package:flutter/material.dart';
//import 'package:taskfive/data/demo_service.dart';
import 'package:taskfive/screens/login/login_screen.dart';

class Introscreen extends StatelessWidget {
  const Introscreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
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
              const SizedBox(height: 100),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton.filled(
                    icon: Icon(Icons.arrow_forward, size: 35),
                    onPressed: () {
                      //print(DemoService.getData());
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (ctx) => LoginScreen()),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
