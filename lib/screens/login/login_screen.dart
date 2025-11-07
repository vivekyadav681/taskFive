import 'package:flutter/material.dart';
import 'package:taskfive/screens/login/sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png'),
              TextFormField(
                decoration: InputDecoration(label: Text('Enter login email')),
              ),
              TextFormField(
                decoration: InputDecoration(label: Text('password')),
              ),
              ElevatedButton(onPressed: () {}, child: Text('Login')),
              TextButton(
                onPressed: () {
                  Navigator.of(
                    context,
                  ).push(MaterialPageRoute(builder: (ctx) => SignUpScreen()));
                },
                child: Text('sign up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
