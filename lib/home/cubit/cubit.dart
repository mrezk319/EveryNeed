// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:ui';

import 'package:e_commerce/home/home_layout.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/modules/favourite/favourite_product.dart';
import 'package:e_commerce/modules/productDetails/noSql/nosql.dart' as nosql;
import 'package:e_commerce/modules/productDetails/product_details.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/carts/carts_screen.dart';
import 'package:e_commerce/modules/home_page/home_page_screen.dart';
import 'package:e_commerce/modules/settings/settings_screen.dart';
import 'package:e_commerce/shared/network/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

class HomeLayoutCubit extends Cubit<HomeLayoutStates> {
  HomeLayoutCubit() : super(initialHomeLayoutState());

  static HomeLayoutCubit get(context) => BlocProvider.of(context);

  List<Widget> Screens = [
    Home(),
    Carts(),
    Favourite(),
    SettingsScreen(),
  ];

  int currentIndex = 0;

  void changeIndex(index) {
    currentIndex = index;
    emit(changeIndexSuccessfully());
  }

  List<CategoryModel>? categoryModel = [];

  void getCategories() {
    categoryModel = [];
    emit(getCategoriesLoadingState());
    FirebaseFirestore.instance.collection('categories').get().then((value) {
      value.docs.forEach((element) {
        categoryModel!.add(CategoryModel.fromJson(element.data()));
      });
      if (categoryModel!.length == value.docs.length)
        emit(getCategoriesSuccessState());
    }).catchError((e) {
      print(e);
      emit(getCategoriesErrorState());
    });
  }

  List<ProdcutModel>? productModel = [];

  void getProducts() {
    emit(getProductsLoadingState());
    productModel = [];
    emit(getProductsLoadingState());
    FirebaseFirestore.instance.collection('products').get().then((value) {
      value.docs.forEach((element) {
        productModel!.add(ProdcutModel.fromJson(element.data()));
      });
      if (productModel!.length == value.docs.length)
        emit(getProductsSuccessState());
    }).catchError((e) {
      print(e);
      emit(getProductsErrorState());
    });
  }

  List<CartModel>? cartModel = [];

  getAllCarts() {
    cartModel = [];
    emit(getCartsLoadingState());
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        cartModel!.add(CartModel.fromJson(element.data()));
      });
      if (cartModel!.length == value.docs.length) emit(getCartsSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(getCartsErrorState());
    });
  }

  List<int> numper = [];
  int? sum;

  getTotalPrice() {
    sum = 0;
    int x = 0;
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        numper.add(element.data()['howMany']);
        x = element.data()['price'] * element.data()['howMany'];
        sum = (sum! + x);
      });
      emit(getCartsSuccessState());
      print(sum.toString());
    }).catchError((e) {
      print(e.toString());
      emit(getCartsErrorState());
    });
  }

  void increaseUi(index) {
    numper[index]++;
    emit(increaseUiState());
  }

  void decreaseUi(index) {
    if (numper[index] != 1) numper[index]--;
    emit(decreaseUiState());
  }

  void increaseInFire(id, index) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .doc(id)
        .update({
      'howMany': numper[index],
    }).then((value) {
      getTotalPrice();
      emit(increaseUiState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  void decreaseInFire(id, index) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .doc(id)
        .update({
      'howMany': numper[index],
    }).then((value) {
      getTotalPrice();
      emit(increaseUiState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  deleteFromCart(id, index) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('cart')
        .doc(id)
        .delete()
        .then((value) {
      emit(deleteState());
    }).catchError((e) {
      print(e.toString());
    });
  }

  getUserdata() {
    emit(saveUserDataLoadingState());

    FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      CacheHelper.saveData(key: "Name", value: value.data()!['name']);

      CacheHelper.saveData(key: "Picture", value: value.data()!['pic']);
      CacheHelper.saveData(key: "Email", value: value.data()!['email'] ?? "");
      CacheHelper.saveData(key: "Uid", value: value.data()!['uid']);
      emit(saveUserDataSuccessState());
    }).catchError((e) {
      print(e.toString());
      emit(saveUserDataErrorState());
    });
  }

  String? value;

  changeradio(val) {
    value = val;
    print(value);
    emit(changedState());
  }

  File? profileImage;
  final picker = ImagePicker();

  Future getProfileImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      profileImage = File(pickedFile.path);
      emit(getProfileImagePickerSuccessState());
    } else {
      print('No image selected.');
      emit(getProfileImagePickerErrorState());
    }
  }

   updateData(
      {required TextEditingController emailController,
      required TextEditingController nameController}) {
     emit(LoadingUpdateState());
    if(profileImage == null) {
      emit(LoadingUpdateState());
      return FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .update({
        'email': emailController.text,
        'name': nameController.text,
      }).then((value) {
        FirebaseAuth.instance.currentUser!
            .updateEmail(emailController.text);
        FirebaseAuth.instance.currentUser!
            .updateDisplayName(nameController.text);
        emit(SuccessUpdateState());
        CacheHelper.saveData(key: "Name", value: nameController.text);
        CacheHelper.saveData(key: "Email", value: emailController.text);
        Get.offAll(HomeLayout());
        profileImage = null;
      }).catchError((e) {
        print(e.toString());
        emit(ErrorUpdateState());
      });
    }
    else {
      emit(LoadingUpdateState());
      return firebase_storage.FirebaseStorage.instance
          .ref()
          .child(
          'usersImages/${Uri
              .file(profileImage!.path)
              .pathSegments
              .last}')
          .putFile((profileImage as File))
          .then((val) {
        emit(LoadingUpdateState());
        val.ref.getDownloadURL().then((valuee) {
          emit(LoadingUpdateState());
          FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .update({
            'email': emailController.text,
            'name': nameController.text,
            'pic': valuee,
          }).then((value) {
            FirebaseAuth.instance.currentUser!
                .updateEmail(emailController.text);
            FirebaseAuth.instance.currentUser!
                .updateDisplayName(nameController.text);
            emit(SuccessUpdateState());
            CacheHelper.saveData(key: "Name", value: nameController.text);
            CacheHelper.saveData(key: "Email", value: emailController.text);
            CacheHelper.saveData(key: "Picture", value: valuee);
            Get.offAll(HomeLayout());
            profileImage = null;
          }).catchError((e) {
            print(e.toString());
            emit(ErrorUpdateState());
          });
        });
      });
    }
  }
  List<OrderModel> orders = [];
  getAllAddress(){
    orders = [];
    emit(getOrdersLoadingState());
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').get().then((value) {
      value.docs.forEach((element) {
        orders.add(OrderModel.fromJson(element.data()));
      });
      emit(getOrdersSuccessState());
    }).catchError((e){
      emit(getOrdersErrorState());
    });
  }
  deleteOrder(context,model){
    FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').doc(model.orderId).delete().then((value) {
      getAllAddress();
      emit(deletedSuccessfullyState());
      Toast(text: "Deleted Successfully".tr, color: Colors.green,context: context);
    });
  }

  void onPressFav({
  required String name,
  required String id,
  required String details,
  required String disc,
  required String pic,
  required int price,
  required String color,
  required String size,
    context
  }) async {
    var favBox = Hive.box<nosql.ProdcutModel>('fov');
    if (favBox.containsKey(id)) {
      favBox.delete(id).then((value) {
        Toast(text: "Removed from favourite successfully".tr,color: Colors.green,context: context);
        emit(removedFromFavSuccess());
      }).catchError((e) {
        print(e.toString());
        emit(removedFromFavError());
      });
    } else {
      favBox.put(
          id,nosql.ProdcutModel(name: name,disc: disc,pic: pic,price: price,color: color,size: size,details: details,id: id)
      );
      Toast(text: "Added to favourite successfully".tr,color: Colors.green,context: context);
      emit(addFavState());
    }

  }
  Color? col;
  changeColor(id,favBox){
    if(favBox.containsKey(id)) {
      col = Colors.red;
      emit(changed());
    }
    else {
      col = Colors.grey;
      emit(changed());
    }
  }
}