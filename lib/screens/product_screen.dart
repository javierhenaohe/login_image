import 'package:flutter/material.dart';
import 'package:login_image/providers/product_form_provider.dart';
import 'package:login_image/services/services.dart';
import 'package:login_image/ui/input_decorations.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productService = Provider.of<ProductsService>(context);
    return ChangeNotifierProvider(
      create: (_) => ProductFromProvider(productService.selectedProduct),
      child: _ProductScreenBody(productService: productService),
    );
  }
}

class _ProductScreenBody extends StatelessWidget {
  const _ProductScreenBody({
    Key? key,
    required this.productService,
  }) : super(key: key);

  final ProductsService productService;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                ProducImage(url: productService.selectedProduct.picture),
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
    final productForm = Provider.of<ProductFromProvider>(context);

    final product = productForm.product;

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
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'La descripcion es obligatoria';
                },
                keyboardType: TextInputType.multiline,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Describa el Hallazgo',
                  hintText: 'Describa brevemente el hallazgo',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: product.ubTecnica!
                    .toUpperCase(), //+++permite poner texto en mayuscula+++
                onChanged: (value) => product.ubTecnica = value,
                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'La UBICACION es obligatoria';
                },
                //TODO: validacion con expresion regular PPTMXX00
                /*
                validator: (value) {
                  String pattern = r'^(pptm)\w{2}(\d{2})?\s?$';
                  RegExp regExp = new RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'No es formato de Ubicacion Tecnica';
                },
                */
                keyboardType: TextInputType.name,
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Ubicacion Tecnica',
                  hintText: 'PPTMXX00',
                ),
              ),
              SizedBox(height: 20),
              SwitchListTile.adaptive(
                activeColor: Colors.indigo,
                inactiveTrackColor: Colors.red,
                value: product.available,
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
