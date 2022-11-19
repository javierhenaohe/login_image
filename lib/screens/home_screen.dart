import 'package:flutter/material.dart';
import 'package:login_image/services/services.dart';
import 'package:login_image/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Hallasgos PTM'),
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) => GestureDetector(
          child: ProductCard(),
          onTap: () => Navigator.pushNamed(
              context, 'product'), //enlace hacia creacion de imagenes
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}
