import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:login_image/models/models.dart';

class ProductsService extends ChangeNotifier {
  final String _baseUrl = 'flutter-varios-216e1-default-rtdb.firebaseio.com';

  final List<Product> products = [];

  late Product selectedProduct;

  final storage = new FlutterSecureStorage();

  File? newPictureFile;

  bool isLoading = true;
  bool isSaving = false;

  ProductsService() {
    this.loadProducts();
  }

  //TODO:

  Future<List<Product>> loadProducts() async {
    this.isLoading = true;
    notifyListeners();
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
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
      await this.createProduct(product);
    } else {
      //actualizar
      await this.upDateProduct(product);
    }

    isSaving = false;
    notifyListeners();
  }

  Future<String> upDateProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products/${product.id}.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.put(url, body: product.toJson());
    // put: actualiza base de datos
    final decodeData = resp.body;

    print(decodeData);

//TODO: actualizar el listado de productos

    final index =
        this.products.indexWhere((element) => element.id == product.id);

    this.products[index] = product;
    return product.id!;
  }

  Future<String> createProduct(Product product) async {
    final url = Uri.https(_baseUrl, 'products.json',
        {'auth': await storage.read(key: 'token') ?? ''});
    final resp = await http.post(url, body: product.toJson());
    // post: postea la informacion de la base de datos
    final decodeData = json.decode(resp.body);

    //print(decodeData);
    product.id = decodeData['name'];

    this.products.add(product);
    return product.id!;
  }

  void upDateSeletedProductImage(String path) {
    this.selectedProduct.picture = path;
    this.newPictureFile = File.fromUri(Uri(path: path));
    notifyListeners();
  }

  Future<String?> uploadImage() async {
    if (this.newPictureFile == null) return null;

    this.isSaving = true;
    notifyListeners();

    final url = Uri.parse(
        'https://api.cloudinary.com/v1_1/drlkmlusa/image/upload?upload_preset=ghsgddya');

    final imageUploadRequest = http.MultipartRequest('POST', url);

    final file =
        await http.MultipartFile.fromPath('file', newPictureFile!.path);

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send();

    final resp = await http.Response.fromStream(streamResponse);

    if (resp.statusCode != 200 && resp.statusCode != 201) {
      print('Algo salio mal!!');
      print(resp.body);
      return null;
    }
    this.newPictureFile = null;
    final decodeData = json.decode(resp.body);
    return decodeData['secure_url'];
    //print(resp.body);
  }
}
