import 'dart:ffi';

import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:login_image/providers/product_form_provider.dart';
//import 'package:login_image/screens/screens.dart';
import 'package:login_image/services/services.dart';
import 'package:login_image/ui/input_decorations.dart';
import 'package:provider/provider.dart';
import 'package:image_picker/image_picker.dart';

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
    final productForm = Provider.of<ProductFromProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
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
                    onPressed: () async {
                      //TODO: camara o galeria

                      final picker = new ImagePicker();
                      final XFile? pickedFile = await picker.pickImage(
                        imageQuality: 100,
                        source: ImageSource.camera,
                        //source: ImageSource.gallery,
                      );

                      if (pickedFile == null) {
                        print('No seleccionó nada');
                        return;
                      }
                      print('Tenemos Imagen ${pickedFile.path}');
                      productService.upDateSeletedProductImage(pickedFile.path);
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
        child: productService.isSaving
            ? CircularProgressIndicator.adaptive()
            : Icon(Icons.save_outlined),
        onPressed: productService.isSaving
            ? null
            : () async {
                if (!productForm.isValidForm()) return;
                final String? imageUrl = await productService.uploadImage();

                if (imageUrl != null) productForm.product.picture = imageUrl;
                await productService.saveOrCreateProduct(productForm.product);
                //Navigator.pop(context, 'home'); //TODO: implementacion para guardar y retornar a la pagina hallazgos
              },
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
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              SizedBox(height: 5),
              TextFormField(
                //keyboardType: TextInputType.multiline,
                initialValue: product.name,
                onChanged: (value) => product.name = value,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Descripcion Breve Requerida';
                },
                decoration: InputDecorations.authInputDecoration(
                  labelText: 'Describa el Hallazgo',
                  hintText: 'Describa brevemente el hallazgo',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                autocorrect: true,
                initialValue: product.ubTecnica,
                // !.toUpperCase(), //+++permite poner texto en mayuscula+++

                //TODO: validacion con expresion regular PPTMXX00, ORGANIZAR ESTA PARTE Y TOMAR COMOM EJEMPLO LO HECHO EL LOGIN

                onChanged: (value) => product.ubTecnica = value,
                validator: (value) {
                  String pattern = r'^(PPTM)\w{2}(\d{2})?\s?$';
                  RegExp regExp = RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'Requiere Ubicacion Tecnica, Ej: PPTMXX00';
                },

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
                onChanged: productForm.upDateAvailability,
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


/* LOGIN
onChanged: (value) => loginForm.email = value,
              validator: (value) {
                String pattern =
                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                RegExp regExp = new RegExp(pattern);

                return regExp.hasMatch(value ?? '')
                    ? null
                    : 'El valor ingresado no luce como un correo';
              },
*/

/* UBICACION TECNICA

                validator: (value) {
                  String pattern = r'^(pptm)\w{2}(\d{2})?\s?$';
                  RegExp regExp = RegExp(pattern);

                  return regExp.hasMatch(value ?? '')
                      ? null
                      : 'No es formato de Ubicacion Tecnica';
                },

                validator: (value) {
                  if (value == null || value.length < 1)
                    return 'Ubicacion Tecnica Requerida';
                },

                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                    RegExp(r'^(pptm)\w{2}(\d{2})?\s?$'),
                  )
                  //r'^(\d+)?\.?\d{0,2}'
                ],
*/