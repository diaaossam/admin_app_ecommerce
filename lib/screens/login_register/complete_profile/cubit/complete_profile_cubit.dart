import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:admin_app_ecommerce/models/user_model.dart';
import 'package:admin_app_ecommerce/shared/helper/constants.dart';
import 'complete_profile_state.dart';

class CompleteProfileCubit extends Cubit<CompleteProfileState> {
  CompleteProfileCubit() : super(CompleteProfileInitial());

  static CompleteProfileCubit get(context) => BlocProvider.of(context);

  final List<String?> errors = [];

  void setErrors(String error) {
    errors.add(error);
    emit(SetErrorsCompleteProfile());
  }

  void removeErrors(String error) {
    errors.remove(error);
    emit(RemoveErrorsCompleteProfile());
  }

  void setUserInfo({required UserModel userModel}) async {
    emit(LoadingUploadUserInfoCompleteProfile());
    CollectionReference reference =
    FirebaseFirestore.instance.collection(USERS);

    await reference
        .doc(getLoggedInUser().uid)
        .set(userModel.toMap())
        .then((value) {
      emit(SucessUploadUserInfoCompleteProfile());
    }).catchError((error) {
      emit(ErrorUploadUserInfoCompleteProfile(error.toString()));
    });
  }

  User getLoggedInUser() {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }
}
