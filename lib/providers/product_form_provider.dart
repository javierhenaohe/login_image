import 'package:flutter/material.dart';
import 'package:login_image/models/models.dart';

class ProductFromProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = new GlobalKey<FormState>();

  Product product;

  ProductFromProvider(this.product);

  upDateAvailability(bool value) {
    print(value);
    this.product.available = value;
    notifyListeners();
  }

  bool isValidForm() {
    return formKey.currentState?.validate() ?? false;
  }
}
