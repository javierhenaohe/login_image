import 'package:flutter/material.dart';
import 'package:login_image/ui/input_decorations.dart';
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
              ),

              SizedBox(height: 50),
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
              decoration: InputDecorations.authInputDecoration(
                hintText: 'correo@sk.com',
                labelText: 'Correo electronico',
                prefixIcon: Icons.alternate_email_rounded,
              ),
            ),
            SizedBox(height: 30),
            TextFormField(
              autocorrect: false,
              obscureText: true,
              keyboardType: TextInputType.number,
              decoration: InputDecorations.authInputDecoration(
                hintText: '******',
                labelText: 'Contraseña',
                prefixIcon: Icons.lock_outline,
              ),
            ),
            SizedBox(height: 30),
            MaterialButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              disabledColor: Colors.grey,
              elevation: 0,
              color: Colors.deepPurple,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                child: Text(
                  'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: () {
                //TODO:LOGIN FORM
              },
            ),
          ],
        ),
      ),
    );
  }
}
