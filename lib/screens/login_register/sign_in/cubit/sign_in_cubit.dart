import 'package:admin_app_ecommerce/screens/login_register/sign_in/cubit/sign_in_state.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../models/token_model.dart';
import '../../../../shared/helper/constants.dart';


class SignInCubit extends Cubit<SignInState> {
  SignInCubit() : super(SignInInitial());

  static SignInCubit get(context) => BlocProvider.of(context);

  bool isPasswordVisible = false;

  void changePasswordVisibaltySignIn() {
    isPasswordVisible = !isPasswordVisible;
    emit(ChangePasswordVisibilty());
  }

  final List<String?> errors = [];

  void setErrors(String error) {
    errors.add(error);
    emit(SetErrors());
  }

  void removeErrors(String error) {
    errors.remove(error);
    emit(RemoveErrors());
  }

  void signInWithGoogle() async {
    emit(SignInLoadingState());
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential).then((value) {
      genrateToken(value.user!.uid);
      checkUserInfo();
    }).catchError((error) {
      emit(SignInFailuerState(error.toString()));
    });
  }

  Future signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    emit(SignInLoadingState());
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) {
      genrateToken(value.user!.uid);
      checkUserInfo();
    }).catchError((error) {
      print(error.toString());
      emit(SignInFailuerState(error.toString()));
    });
  }

  void signInWithFacebook() async {
    emit(SignInLoadingState());

    final LoginResult loginResult = await FacebookAuth.instance.login();

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);
    FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) {
      genrateToken(value.user!.uid);
      checkUserInfo();
    }).catchError((error) {
      emit(SignInFailuerState(error.toString()));
    });
  }

  void genrateToken(String uid) {
    FirebaseMessaging.instance.getToken().then((token) {
      TokenModel tokenModel =
          TokenModel(uid: uid, token: token, isAdmin: false);
      //  FirebaseDatabase.instance.ref(TOKENS).child(uid).set(tokenModel.toMap());
      FirebaseFirestore.instance
          .collection(TOKENS)
          .doc(uid)
          .set(tokenModel.toMap());
    });
  }

  void checkUserInfo() {
    String uid = FirebaseAuth.instance.currentUser!.uid;

    FirebaseFirestore.instance.collection(USERS).doc(uid).get().then((value) {
      if (value.exists) {
        emit(SignInSuccessStateMainLayout());
      } else {
        emit(SignInSuccessStateCompletetProfile());
      }
    });
  }
}
