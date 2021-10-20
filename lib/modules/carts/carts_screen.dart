import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/modules/check_out/check_out.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';

class Carts extends StatefulWidget{

  @override
  State<Carts> createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: BlocProvider.of<HomeLayoutCubit>(context)..getAllCarts()..getTotalPrice(),
        child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
            listener: (context, state) {

            },
            builder: (context, state) {
              if(state is getCartsLoadingState) {
                return Center(child: LoadingBouncingGrid.square(
                  backgroundColor: HexColor(color),));
              }if(HomeLayoutCubit.get(context).cartModel!.length == 0){
                return Center(child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/emptyCart.png',width: 250,),
                    Text("Cart is Empty".tr,style: GoogleFonts.merriweatherSans(fontSize: 25),),
                  ],
                ));
              }
              else {
                return Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, index) =>
                                cartItem(HomeLayoutCubit
                                    .get(context)
                                    .cartModel![index], context, index),
                            separatorBuilder: (context, state) =>
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 15.0),
                                  child: Divider(height: 1,
                                    indent: 25,
                                    endIndent: 25,),
                                ),
                            itemCount: HomeLayoutCubit
                                .get(context)
                                .cartModel!
                                .length
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Column(
                              children: [
                                Text("Total".tr,
                                  style: GoogleFonts.merriweatherSans(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w300),),
                                HomeLayoutCubit
                                    .get(context)
                                    .sum == 0 ? SizedBox(
                                  child: CircularProgressIndicator(
                                    color: HexColor(color), strokeWidth: 1,),
                                  height: 15,
                                  width: 15,) :
                                Text((HomeLayoutCubit
                                    .get(context)
                                    .sum
                                    .toString()),
                                  style: GoogleFonts.merriweatherSans(
                                    color: HexColor(color),),)
                              ],
                            ),
                            Spacer(),
                            Container(
                                width: 150, child: button(text: "CHECKOUT".tr,
                                function: () {
                                  Get.to(CheckOut());
                                })),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
            })
    );
  }

  Widget cartItem(CartModel model,context,index) => GestureDetector(
    child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 15.0),
                child: Container(
                  child: ClipRRect(borderRadius: BorderRadius.circular(5),child: Image.network((model.pic ?? ""),fit: BoxFit.cover,)), width: 150, height: 160,),
              ),
              SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 130,
                    child: Text((model.name ?? ""),
                      style: GoogleFonts.merriweatherSans(fontSize: 16),),
                  ),
                  SizedBox(height: 15,),
                  Text("\$${(model.price ?? "")}",
                    style: GoogleFonts.merriweatherSans(
                        color: HexColor(color), fontSize: 16),),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          InkWell(child: Text("+",
                            style: GoogleFonts.merriweatherSans(fontSize: 25),),
                            onTap: () {
                            HomeLayoutCubit.get(context).increaseUi(index);
                            HomeLayoutCubit.get(context).increaseInFire(model.id,index);
                            },),
                          SizedBox(width: 15,),
                          Text((HomeLayoutCubit.get(context).numper[index].toString()),
                            style: GoogleFonts.merriweatherSans(fontSize: 25),),
                          SizedBox(width: 15,),
                          InkWell(child: Text("-",
                            style: GoogleFonts.merriweatherSans(fontSize: 25),),
                            onTap: () {
                              HomeLayoutCubit.get(context).decreaseUi(index);
                              HomeLayoutCubit.get(context).decreaseInFire(model.id,index);
                            },)

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
    onLongPress: (){
      showAnimatedDialog(context: context, builder: (context)=>ClassicGeneralDialogWidget(
        titleText: ' ',
        contentText: 'are you sure you want to delete it?'.tr,
        positiveText: "Remove".tr,
        negativeText: "Cancel".tr,
        onPositiveClick: () {
         HomeLayoutCubit.get(context).deleteFromCart(model.id, index);
         setState(() {
           HomeLayoutCubit.get(context).getAllCarts();
         });
          Navigator.of(context).pop();
        },
        onNegativeClick: () {
          Navigator.of(context).pop();
        },
      ), animationType: DialogTransitionType.slideFromBottomFade,
        curve: Curves.fastOutSlowIn,
        duration: Duration(seconds: 1),
      );
    },

  );
}