import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/home/home_layout.dart';
import 'package:e_commerce/models/user_model.dart';
import 'package:e_commerce/modules/home_page/home_page_screen.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:e_commerce/shared/network/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class EditProfile extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    nameController.text = CacheHelper.getData(key: "Name");
    emailController.text = CacheHelper.getData(key: "Email");
    return BlocProvider.value(
      value: BlocProvider.of<HomeLayoutCubit>(context),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {
          if (state is SuccessUpdateState) {
            Toast(
                text: "Updated successfully".tr,
                color: HexColor(color),
                context: context);
          }
          if (state is ErrorUpdateState) {
            Toast(
                text: "Something went error".tr,
                color: Colors.red,
                context: context);
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0, left: 30, right: 30),
                child: ListView(
                  children: [
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            child: CircleAvatar(
                              child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(150),
                                  ),
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  child: HomeLayoutCubit.get(context)
                                              .profileImage ==
                                          null
                                      ? CacheHelper.getData(key: "Picture") ==
                                              ""
                                          ? Image.network(
                                              "https://www.iconpacks.net/icons/2/free-user-icon-3297-thumb.png",
                                              width: 300,
                                            )
                                          : Image.network(
                                              (CacheHelper.getData(
                                                  key: "Picture")),
                                              fit: BoxFit.cover,
                                              width: 300,
                                            )
                                      : Image.file(
                                          HomeLayoutCubit.get(context)
                                              .profileImage as File,
                                          width: 300,
                                        )),
                              radius: 97,
                            ),
                            radius: 100,
                            backgroundColor: HexColor(color),
                          ),
                          InkWell(
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: CircleAvatar(
                                child: Icon(
                                  Icons.camera_alt,
                                  size: 25,
                                ),
                                backgroundColor: Colors.blueAccent,
                                radius: 22,
                              ),
                            ),
                            onTap: () {
                              HomeLayoutCubit.get(context).getProfileImage();
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          TextFormField(
                              controller: nameController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This Field can't be empty".tr;
                                }
                              }),
                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                              controller: emailController,
                              validator: (val) {
                                if (val!.isEmpty) {
                                  return "This Field can't be empty".tr;
                                }
                              }),
                          SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          hintText:
                              "Write a New password if you want to change it".tr),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    button(
                        text: "Update".tr,
                        function: () {
                          if (formKey.currentState!.validate()) {
                            HomeLayoutCubit.get(context).updateData(
                                emailController: emailController,
                                nameController: nameController);
                            if (passwordController.text.isNotEmpty) {
                              FirebaseAuth.instance.currentUser!
                                  .updatePassword(passwordController.text).then((value) {
                                passwordController.text = "";
                              });
                            }
                          }
                        }),
                    if (state is LoadingUpdateState)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: LinearProgressIndicator(
                          color: HexColor(color),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
