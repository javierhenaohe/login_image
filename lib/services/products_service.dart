import 'package:flutter/material.dart';
import 'package:login_image/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-216e1-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  //TODO: Hacer el fecth de productos
}
