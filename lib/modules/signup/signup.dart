import 'package:e_commerce/modules/signup/cubit/states.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';

import 'cubit/cubit.dart';

class SignUp extends StatelessWidget {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(create:(context)=> SignupCubit(),
    child: BlocConsumer<SignupCubit,SignupStates>(
      listener: (context,state){},
      builder: (context,state){

        return Scaffold(
          appBar: AppBar(
            backgroundColor: HexColor('#F5F5F5'),
            elevation: 0,
            leading: IconButton(onPressed: (){
              Get.back();
            }, icon: Icon(Icons.arrow_back_ios,color: HexColor(color),),),
          ),
          backgroundColor: HexColor('#F5F5F5'),
          body: (state is SignupLoadingState)?Center(child: LoadingBouncingGrid.square(backgroundColor: HexColor(color),)): Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 80.0,left: 8,right: 8),
                  child: Container(
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
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("Sign Up".tr,style: GoogleFonts.merriweatherSans(fontSize: 30,fontWeight: FontWeight.w600),),
                            ],
                          ),
                          SizedBox(height: 45,),
                          Form(
                            key: formKey,
                            child: Column(
                              children: [
                                textForm(hint: "Enter Your Name",text: "Name",controller:nameController,validator:(val){
                                  if(val == ""){return "This Field can't be empty".tr;}}),
                                SizedBox(height: 40,),
                                textForm(hint: "Enter Your Email",text: "Email",controller:emailController,validator:(val){
                                  if(val == ""){return "This Field can't be empty".tr;}}),
                                SizedBox(height: 40,),
                                textForm(hint: "Enter Your Password",text: "Password",controller:passwordController,obsecure: true,validator:(val){
                                  if(val == ""){return "This Field can't be empty".tr;}}),
                              ],
                            ),
                          ),
                          SizedBox(height: 20,),
                          Container(
                              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
                              clipBehavior: Clip.antiAliasWithSaveLayer,
                              child: button(text: "SIGN UP",function: (){
                                if(formKey.currentState!.validate()){
                                  SignupCubit.get(context).createEmail(email: emailController.text, password: passwordController.text,context: context,name: nameController.text);
                                }
                              })),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
    );
  }
}
