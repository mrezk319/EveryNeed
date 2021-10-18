import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/home/home_layout.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/login/cubit/states.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/network/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInCubit extends Cubit<LoginStates> {

  LogInCubit() : super(initialLoginState());

  static LogInCubit get(context) => BlocProvider.of(context);

  FirebaseAuth auth = FirebaseAuth.instance;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  FacebookLogin facebookLogin = FacebookLogin();

  Future loginWithGoogle(context) async {
    emit(LogInLoadingState());
    GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
    var cradintials = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    auth.signInWithCredential(cradintials).then((value) {
      userModel = UserModel(email: value.user!.email,
          name: value.user!.displayName,
          pic: value.user!.photoURL,
          uid: value.user!.uid);

      FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(
          userModel!.toMap()).then((value) {
        emit(LogInSuccessState());
        CacheHelper.saveData(key: "isLogged", value: true);
        Toast(text: "Login Successfully",
            color: Colors.green,
            context: context);
        Get.offAll(HomeLayout());
      }).catchError((e) {
        print(e.toString());
        emit(LogInErrorState());
        Toast(text: e.toString(), color: Colors.red, context: context);
      });
    }).catchError((e) {
      emit(LogInErrorState());
      print(e.toString());
      Toast(text: e.toString(), color: Colors.red, context: context);
    });
  }

  UserModel? userModel;

  void logInWithFacebook(context) async {
    emit(LogInLoadingState());
    var result = await facebookLogin.logIn(permissions: [
      FacebookPermission.email,
      FacebookPermission.publicProfile
    ]);
    final accessToken = result.accessToken!.token;

    if (result.status == FacebookLoginStatus.success) {
      var facebookCradintial = FacebookAuthProvider.credential(accessToken);
      auth.signInWithCredential(facebookCradintial).then((value) {
        userModel = UserModel(email: value.user!.email,
            name: value.user!.displayName,
            pic: value.user!.photoURL,
            uid: value.user!.uid);

        FirebaseFirestore.instance.collection('users').doc(value.user!.uid).set(
            userModel!.toMap()).then((value) {
          emit(LogInSuccessState());
          CacheHelper.saveData(key: "isLogged", value: true);
          Toast(text: "Login Successfully",
              color: Colors.green,
              context: context);
          Get.offAll(HomeLayout());
        }).catchError((e) {
          print(e.toString());
        });
      }).catchError((e){
        emit(LogInErrorState());
        print(e.toString());
        Toast(text: e.toString(),color: Colors.red);
        });
      }
          }

          void loginWithEmailAndPassword(
          {required email,required password,context})
      {
        emit(LogInLoadingState());
        auth.signInWithEmailAndPassword(email: email, password: password).then((
            value) {
          emit(LogInSuccessState());
          CacheHelper.saveData(key: "isLogged", value: true);
          Toast(text: "Login Successfully",
              color: Colors.green,
              context: context);
          Get.offAll(HomeLayout());
        }).catchError((e) {
          emit(LogInErrorState());
          print(e.toString());
          Toast(text: e.toString(), color: Colors.red, context: context);
        });
      }
    }
