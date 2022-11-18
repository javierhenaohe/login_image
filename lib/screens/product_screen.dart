import 'package:flutter/material.dart';
import 'package:login_image/ui/input_decorations.dart';

import '../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProducImage(),
                Positioned(
                  top: 50,
                  left: 20,
                  child: IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.arrow_back_ios_new,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
                Positioned(
                  top: 50,
                  right: 20,
                  child: IconButton(
                    onPressed: () {
                      //TODO: camara o galeria
                    },
                    icon: Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
            _ProductForm(),
            SizedBox(height: 100),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save_outlined),
        onPressed: () {},
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {
  //const _ProductForm({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _builBoxDecoration(), //detalles de la decoracion
        child: Form(
          child: Column(
            children: [
              SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.multiline,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Describa el Hallazgo',
                  hintText: 'Describa brevemente el hallazgo',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                keyboardType: TextInputType.multiline,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Ubicacion Tecnica',
                  hintText: 'PPTMXX00',
                ),
              ),
              SizedBox(height: 20),
              SwitchListTile.adaptive(
                activeColor: Colors.indigo,
                inactiveTrackColor: Colors.red,
                value: false,
                title: Text('Recordatorio Aviso SAP'),
                onChanged: (value) {
                  //TODO: pendiente establecer
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _builBoxDecoration() => BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(25),
            bottomLeft: Radius.circular(25),
          ),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withOpacity(0.05),
                offset: Offset(0, 5),
                blurRadius: 5),
          ]);
}
