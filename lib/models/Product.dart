import 'dart:convert';

import 'package:flutter/material.dart';

const String productId = 'productId';
const String productTitle = 'title';
const String productDescription = 'description';
const String productImages = 'images';
const String productRating = 'rating';
const String productPrice = 'price';
const String productIsFavourite = 'isFavourite';
const String productIsPopular = 'isPopular';

class ProductModel {
  String? id;
  String? title, description, image;
  double? rating, price;
  bool? isFavourite, isPopular;

  ProductModel({
    required this.id,
    required this.image,
    this.rating = 0.0,
    this.isFavourite = false,
    this.isPopular = false,
    required this.title,
    required this.price,
    required this.description,
  });

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{};

    map['${productId}'] = id;
    map['${productTitle}'] = title;
    map['${productDescription}'] = description;
    map['${productRating}'] = rating;
    map['${productPrice}'] = price;
    map['${productIsFavourite}'] = isFavourite;
    map['${productIsPopular}'] = isPopular;
    map['${productImages}'] = image;
    return map;
  }

  ProductModel.fromJson(Map<String, dynamic> map) {
    id = map['${productId}'];
    title = map['${productTitle}'];
    description = map['${productDescription}'];
    image = map['${productImages}'];
    rating = map['${productRating}'];
    price = map['${productPrice}'];
    isFavourite = map['${productIsFavourite}'];
    isPopular = map['${productIsPopular}'];
  }
}

// Our demo Products

List<ProductModel> demoProducts = [
  ProductModel(
    id: 'Diaa',
    image: "assets/images/ps4_console_white_1.png",
    title: "Wireless Controller for PS4™",
    price: 64.99,
    description: description,
    rating: 4.8,
    isFavourite: true,
    isPopular: true,
  ),
];

const String description =
    "Wireless Controller for PS4™ gives you what you want in your gaming from over precision control your games to sharing …";
