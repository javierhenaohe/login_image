import 'package:flutter/material.dart';
import 'package:login_image/models/models.dart';
import 'package:login_image/screens/screens.dart';
import 'package:login_image/services/services.dart';
import 'package:login_image/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);
    final authService = Provider.of<AuthService>(context, listen: false);

    if (productsService.isLoading) return LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hallazgos PTM'),
        actions: [
          IconButton(
            onPressed: () {
              authService.logout();
              Navigator.pushReplacementNamed(context, 'login');
            },
            icon: Icon(Icons.login_outlined),
          ),
        ],
        //MUESTRA ICONO EN LADO IZQUIERDO
        //leading: IconButton(onPressed: () {  authService.logout(); }, icon: Icon(Icons.login_outlined)),
      ),
      body: ListView.builder(
        itemCount: productsService.products.length,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
            child: ProductCard(
              product: productsService.products[index],
            ),
            onTap: () {
              productsService.selectedProduct =
                  productsService.products[index].copy();
              Navigator.pushNamed(context, 'product');
            } //enlace hacia creacion de imagenes
            ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct = Product(
            available: true,
            name: '',
            ubTecnica: '',
          );
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
