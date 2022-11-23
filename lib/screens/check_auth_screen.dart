import 'package:flutter/material.dart';
import 'package:login_image/screens/screens.dart';
import 'package:login_image/services/services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    return Scaffold(
      body: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData)
            return Padding(
              padding: const EdgeInsets.only(top: 350),
              child: Column(
                children: [
                  Center(
                    child: LinearProgressIndicator(),
                  ),
                  SizedBox(height: 70),
                  Text(
                    'Espere...',
                    style: TextStyle(
                        fontSize: 30,
                        letterSpacing: 5,
                        fontStyle: FontStyle.italic),
                  ),
                ],
              ),
            );

          if (snapshot.data == '') {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => LoginScreen(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
            );
          } else {
            Future.microtask(
              () {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) => HomeScreen(),
                    transitionDuration: Duration(seconds: 0),
                  ),
                );
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
