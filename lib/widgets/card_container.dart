import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  final Widget child; //CHILD**

  const CardContainer({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 30), //DEFINE EL BORDE DE CARDCONTAINER
      child: Container(
        width: double.infinity,

        decoration: _createCardShape(),
        child: child, //CHILD**
      ),
    );
  }

  BoxDecoration _createCardShape() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25), //REDONDEA EL BORDE A LA CARD
        boxShadow: [
          BoxShadow(
            //DEFINE LA SOMBRA DE LA CARD
            color: Colors.black12,
            blurRadius: 15, //ESPARCIR EL BLUR O DIFUMINADO
            offset: Offset(0, 5), // POSICION DE LA SONBRA O DIFUMINADO
          ),
        ],
      );
}
