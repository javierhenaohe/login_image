import 'package:flutter/material.dart';
import 'package:login_image/models/models.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: EdgeInsets.only(top: 30, bottom: 50),
        width: double.infinity,
        height: 400,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(url: product.picture),
            _ProducDetails(
              title: product.name,
              subTitle: product.id!,
            ),
            //se ve la imagen de fondo
            Positioned(
              top: 0,
              right: 0,
              child: _ubTecnicaTag(
                ubTecnica: product.ubTecnica!,
              ), // muestra datos en esquina superior derecha
            ),

            //TODO: mostrar de manera condicional
// esta condicion permite visualizar la etiqueta de falta de aviso, color amarillo
            if (product.available)
              Positioned(
                top: 0,
                left: 0,
                child:
                    _NotAvailable(), // muestra datos en esquina superior izquierda
              )
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 7),
            blurRadius: 10,
          )
        ],
      );
}

class _NotAvailable extends StatelessWidget {
  //const _NotAvailable({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Sin Aviso',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    );
  }
}

class _ubTecnicaTag extends StatelessWidget {
  //const _PirceTag({Key? key,}) : super(key: key);

//TODO: esta escrito como numero (double) para precio, cambiar para ubicacion tecnica (String)
  final String ubTecnica;

  const _ubTecnicaTag({
    super.key,
    required this.ubTecnica,
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      // ignore: sort_child_properties_last
      child: FittedBox(
        // permite adaptar el texto en la caja superior derecha
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            //TODO: al cambiar de double a string se puede quitar el signo $ y usar el formato PPTMXX00, TENER EN CUENTA QUE TAMBIEN SE DEBE CAMBIAR EN product.dart
            ubTecnica.toUpperCase(), //'\$PPTMXXXX',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
      ),
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        ),
      ),
    );
  }
}

class _ProducDetails extends StatelessWidget {
  //const _producDetails({Key? key,}) : super(key: key);

  final String title;
  final String subTitle;

  const _ProducDetails({
    super.key,
    required this.title,
    required this.subTitle,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        height: 70,
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              subTitle,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
        color: Colors.indigo,
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
      );
}

class _BackgroundImage extends StatelessWidget {
  //const _BackgroundImage({Key? key,}) : super(key: key);

  final String? url;

  const _BackgroundImage({
    super.key,
    this.url,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      child: Container(
        width: double.infinity,
        height: 400,
        child: url == null
            ? Image(
                image: AssetImage('assets/no-image.png'),
                fit: BoxFit.cover,
              )
            : FadeInImage(
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/jar-loading.gif'),
                image: NetworkImage(url!),
              ),
      ),
    );
  }
}
