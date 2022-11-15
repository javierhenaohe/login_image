import 'package:flutter/material.dart';
import 'package:login_image/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground( //SOLICITA EL CHILD* DEL AUTH_BACKGROUND.DART
      child: Container(
        width: double.infinity,
        height: 300,
        color: Colors.red,
      ),
    ));
  }
}
