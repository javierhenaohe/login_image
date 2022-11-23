import 'package:flutter/material.dart';
import 'package:login_image/providers/login_form_provider.dart';
import 'package:login_image/services/services.dart';
import 'package:login_image/ui/input_decorations.dart';
import 'package:login_image/widgets/widgets.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatelessWidget {
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
                    Text('Crear usuario PTM',
                        style: Theme.of(context).textTheme.headline4),
                    SizedBox(height: 30),

                    //instancia del provider colocada en el built
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    ),
                    SizedBox(height: 30),
                  ],
                ),
              ), //CHILD**
              SizedBox(height: 50),

              TextButton(
                onPressed: () =>
                    Navigator.pushReplacementNamed(context, 'login'),
                style: ButtonStyle(
                  overlayColor:
                      MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
                  shape: MaterialStateProperty.all(const StadiumBorder()),
                ),
                child: Text(
                  'Ingresa con tu cuenta',
                  style: TextStyle(
                      fontSize: 18,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black87),
                ),
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
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Container(
      child: Form(
        key: loginForm.formKey, //key asociado del provider
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
              onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
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
              onChanged: (value) => loginForm.password = value,
              validator: (value) {
                return (value != null && value.length >= 6)
                    ? null
                    : 'La contraseña debe tener 6 digitos';
              },
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
                  loginForm.isLoading ? 'Cargando...' : 'Ingresar',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              onPressed: loginForm.isLoading // condicion que desactiva el boton
                  ? null
                  : () async {
                      //LOGIN FORM

                      FocusScope.of(context).unfocus();

                      final authService =
                          Provider.of<AuthService>(context, listen: false);

                      if (!loginForm.isValidForm()) return;

                      loginForm.isLoading = true;

                      //TODO:VALIDAR SI EL LOGIN ES CORRECTO

                      final String? errorMessage = await authService.createUser(
                          loginForm.email, loginForm.password);

                      if (errorMessage == null) {
                        Navigator.pushReplacementNamed(context, 'login');
                      } else {
                        //TODO: mostrar error en pantalla

                        print(errorMessage);
                      }

                      loginForm.isLoading = false;

                      // activar esta pausa hace que el navigator genere advertencia
                      // await Future.delayed(Duration(seconds: 2));
                      //loginForm.isLoading = false;
                    },
            ),
          ],
        ),
      ),
    );
  }
}
