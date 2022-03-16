import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import '../../../../models/Product.dart';
import '../../../../shared/helper/constants.dart';

part 'add_product_state.dart';

class AddProductCubit extends Cubit<AddProductState> {
  AddProductCubit() : super(AddProductInitial());

  static AddProductCubit get(BuildContext context) => BlocProvider.of(context);


  var picker = ImagePicker();
  File? productImage;

  Future getproductImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      productImage = File(pickedFile.path);
      emit(UploadProductSuccessState());
    } else {
      emit(UploadProductFailerState('No Image Selected'));
    }
  }

  String? categoryText;

  List<String> categoryList = [
    '${Phone}',
    '${Computers}',
    '${Fashion}',
    '${Vedio_Games}',
    '${Home_Kitchen}'
  ];

  void changeCategory(String text) {
    this.categoryText = text;
    emit(CategoryChangeListState());
  }


  bool isPopuler = false;

  void changePopuler() {
    isPopuler = !isPopuler;
    print(isPopuler);
    emit(PopulerChangeListState());
  }



  void uploadProduct(
      {required String type, required Map<String ,dynamic> map}) {
    if (productImage != null) {
      emit(UploadProductLoadingState());
      FirebaseFirestore.instance
          .collection(Categoriers)
          .doc(Categoriers)
          .collection(type)
          .add(map)
          .then((value) {
        _uploadProductImage(id: value.id, type: type);
      }).catchError((error) {
        print(error.toString());
      });
    } else {
      emit(UploadProductFailerState('No Image Selected'));
    }
  }

  void _updateProductId(
      {required String id, required String type, required String image}) {
    FirebaseFirestore.instance
        .collection(Categoriers)
        .doc(Categoriers)
        .collection(type)
        .doc(id)
        .update({'${productId}': id, '${productImages}': image});
  }

  void _uploadProductImage({required String id, required String type}) {
    firebase_storage.FirebaseStorage.instance
        .ref("ProductImages")
        .child(id)
        .putFile(productImage!)
        .then((image) {
      image.ref.getDownloadURL().then((value) {
        _updateProductId(type: type, id: id, image: value.toString());
      });
    });
  }
}
