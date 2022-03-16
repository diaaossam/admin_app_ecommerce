import 'dart:io';
import 'package:admin_app_ecommerce/screens/main_screens/add_product/add_product_screen.dart';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../models/user_model.dart';
import '../../screens/main_screens/orders_history/orders_history.dart';
import '../../shared/helper/constants.dart';
import '../../screens/main_screens/dashboard/dash_board_screen.dart';
import '../../screens/main_screens/settings_screen/settings_screen.dart';
import 'main_layout_state.dart';

class MainLayoutCubit extends Cubit<MainLayoutState> {
  MainLayoutCubit() : super(MainLayoutInitial());
  List<UserModel> list = [];
  UserModel? userModel;

  static MainLayoutCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  void setScreen(int index) {
    this.currentIndex = index;
    emit(SetScreenState());
  }

  List<Widget> screen = [
    DashBoardScreen(),
    AddNewProductScreen(),
    OrdersHistoryScreen(),
    SettingsScreen(),
    SettingsScreen(),
    SettingsScreen(),
  ];

  void getAllUsers() async {
    GetAllUserLoading();
    FirebaseFirestore.instance
        .collection(USERS)
        .where('isAdmin', isEqualTo: false)
        .get()
        .then((value) {
      value.docs.forEach((users) {
        list.add(UserModel.fromJson(users.data()));
      });
      emit(GetAllUserSucess(list));
    }).catchError((error) {
      emit(GetAllUserError(error: error.toString()));
    });
  }

  void getCurrentUser() async {
    FirebaseFirestore.instance
        .collection(USERS)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      userModel = UserModel.fromJson(value.data()!);
      getAllUsers();
    }).catchError((error) {
      print(error.toString());
    });
  }

  var picker = ImagePicker();
  File? profileImage;

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      uploadProfileImage();
      emit(SelectImageStateSucess());
    } else {
      print('No Image Selected');
      emit(SelectImageStateFaluire());
    }
  }

  void uploadProfileImage() {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    firebase_storage.FirebaseStorage.instance
        .ref()
        .child(
            '${USERS}/profile/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        FirebaseFirestore.instance
            .collection(USERS)
            .doc(uid)
            .update({'image': value});
      });
    }).catchError((error) {
      print(error.toString());
    });
  }




}
