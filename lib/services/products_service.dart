import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:login_image/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-216e1-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  late Product selectedProduct;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    this.loadProducts();
  }

  //TODO:

  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json');
    final resp = await http.get(url);

    final Map<String, dynamic> productMap = json.decode(resp.body);

    //print(productMap);
    productMap.forEach((key, value) {
      final tempProduct = Product.fromMap(value);
      tempProduct.id = key;
      this.products.add(tempProduct);
    });

    final observarNombre = this.products[0].name;
    print(observarNombre);

    this.isLoading = false;
    notifyListeners();

    return this.products;
  }

  Future saveOrCreateProduct(Product product) async {
    isSaving = true;
    notifyListeners();

    if (product.id == null) {
      //es necesario crear

    } else {
      //actualizar
      await this.upDateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> upDateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json');
    final resp = await http.put(url,
        body: product.toJson()); // put: actualiza base de datos
    final decodeData = resp.body;

    print(decodeData);

//TODO: actualizar el listado de productos

    final index =
        this.products.indexWhere((element) => element.id == product.id);

    this.products[index] = product;
    return product.id!;
  }
}
