import 'package:flutter/material.dart';
import 'package:login_image/widgets/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AuthBackground(
      //SOLICITA EL CHILD* DEL AUTH_BACKGROUND.DART
      child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
                height:
                    250), // SEPARACION DESDE LA PARTE SUPERIOR DE LA PANTALLA HASTA EL CARDCONTAINER
            CardContainer(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text('Login PTM',
                      style: Theme.of(context).textTheme.headline4),
                  SizedBox(height: 30),
                  Text('FORMULARIO'),
                ],
              ),
            ), //CHILD**
          ],
        ),
      ),
    ));
  }
}
