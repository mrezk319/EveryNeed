import 'dart:async';

import 'package:e_commerce/modules/login/cubit/states.dart';
import 'package:e_commerce/modules/signup/signup.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:e_commerce/modules/login/cubit/cubit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:get/get.dart';
import 'package:loading_animations/loading_animations.dart';
class LogIn extends StatelessWidget {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=> LogInCubit(),
    child: BlocConsumer<LogInCubit,LoginStates>(
      listener: (context,state){},
      builder:  (context,state){

        return Scaffold(
          backgroundColor: HexColor('#F5F5F5'),
          body:  (state is LogInLoadingState) ? Center(child: LoadingBouncingGrid.square(backgroundColor: HexColor(color),)):Padding(
            padding: const EdgeInsets.only(top: 90.0,left: 20,right: 20),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(color: Colors.black12,spreadRadius: 2,blurRadius: 10),
                      ]
                      ,color: Colors.white,borderRadius: BorderRadius.circular(5)),
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Welcome,".tr,style: GoogleFonts.merriweatherSans(fontSize: 30,fontWeight: FontWeight.w600),),
                                SizedBox(height: 8,),
                                Text("Sign in to Continue".tr,style: GoogleFonts.merriweatherSans(color: Colors.black26),),
                              ],
                            ),
                            Spacer(),
                            TextButton(onPressed: (){
                              Get.to(SignUp());
                            }, child: Text("Sign".tr,style: GoogleFonts.merriweatherSans(fontSize: 16,color: HexColor(color)),)),
                          ],
                        ),
                        SizedBox(height: 45,),
                        Form(
                          key: formKey,
                          child: Column(
                            children: [
                              textForm(hint: "Enter Your Email",text: "Email",controller:emailController,validator:(val){
                                if(val == ""){return "This Field can't be empty".tr;}}),
                              SizedBox(height: 40,),
                              textForm(hint: "Enter Your Password",text: "Password",controller:passwordController,obsecure: true,validator:(val){
                                if(val == ""){return "This Field can't be empty".tr;}}),
                            ],
                          ),
                        ),
                        SizedBox(height: 20,),
                        Row(
                          children: [
                            Spacer(),
                            TextButton(onPressed: (){}, child: Text("Forgot Password?".tr,style: GoogleFonts.merriweatherSans(color: Colors.black,fontWeight: FontWeight.w300),))],),
                        Container(
                            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: button(text: "SIGN IN",function: (){
                              if(formKey.currentState!.validate()){
                                LogInCubit.get(context).loginWithEmailAndPassword(email: emailController.text, password: passwordController.text,context: context);
                              }
                            })),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [Text("-",style: GoogleFonts.merriweatherSans(fontSize: 15)),Text("OR".tr,style: GoogleFonts.merriweatherSans(fontSize: 17)),Text("-",style: GoogleFonts.merriweatherSans(fontSize: 15))],),
                SizedBox(height: 25,),
                InkWell(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black38,width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 40,),
                          Image.asset('assets/images/facebook.png'),
                          Spacer(),
                          Text("Sign in with Facebook".tr,style: GoogleFonts.merriweatherSans(),),
                          SizedBox(width: 40,),
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    LogInCubit.get(context).logInWithFacebook(context);
                  },
                ),
                SizedBox(height: 15,),
                InkWell(
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.black38,width: 0.5),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(right: 35.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(width: 40,),
                          Image.asset('assets/images/google.png'),
                          Spacer(),
                          Text("Sign in with Google".tr,style: GoogleFonts.merriweatherSans(),),
                          SizedBox(width: 55,),
                        ],
                      ),
                    ),
                  ),
                  onTap: (){
                    LogInCubit.get(context).loginWithGoogle(context);
                  },
                ),
                SizedBox(height: 20,),
              ],
            ),
          ),
        );
      },
    ),
    );
  }
}
