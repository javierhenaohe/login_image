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
                    Text('Usuario PTM',
                        style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 30),
                    _LoginForm(),
                    SizedBox(height: 30),
                  ],
                ),
              ), //CHILD**
              SizedBox(height: 50),

              Text(
                'Crear una nueva cuenta',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// esta clase tendra solo el formulario
class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        //TODO: MANTENER LA REFERENCIA AL KEY
        child: Column(
          children: [
            TextFormField(
              autocorrect: false,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.purple,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.deepPurple,
                    width: 2,
                  ),
                ),
                hintText: 'ptm@sk.com.co',
                labelText: 'Correo electronico',
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
                prefixIcon: Icon(
                  Icons.alternate_email_sharp,
                  color: Colors.deepPurple,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
