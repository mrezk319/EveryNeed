import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';

class OrderHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (Context) => HomeLayoutCubit()..getAllAddress(),
        child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
            listener: (context, state) {},
            builder: (context, state) {
              return Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  elevation: 0,
                  iconTheme: IconThemeData(color: HexColor(color)),
                  centerTitle: true,
                  title: Text(
                    "Order History".tr,
                    style: GoogleFonts.merriweatherSans(color: Colors.black),
                  ),
                ),
                body:state is getOrdersLoadingState
                    ? Center(
                    child: LoadingBouncingGrid.square(
                      backgroundColor: HexColor(color),
                    ))
                    : HomeLayoutCubit.get(context).orders.isEmpty
                    ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/emptyCart.png',
                          width: 250,
                        ),
                        Text(
                          "Order is Empty".tr,
                          style: GoogleFonts.merriweatherSans(fontSize: 25),
                        ),
                      ],
                    ))
                    :ListView.separated(itemBuilder: (context,index)=>orderHistoryItem(HomeLayoutCubit.get(context).orders[index],context), separatorBuilder:(context,index)=>SizedBox(height: 5,) , itemCount: HomeLayoutCubit.get(context).orders.length),
              );
            }));
  }
}

Widget orderHistoryItem(OrderModel model,context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          children: [
            Row(
              children: [
                Text("Address : ".tr),
                Container(
                    width: 250,
                    child: Text("${model.street1}, ${model.street2}, ${model.state}, ${model.city}, ${model.country}"))
              ],
            ),
            SizedBox(height: 10,),
            Row(children: [
              Text("Total price".tr),
              Text(" : ${model.totalPrice}"),
            ],),
            SizedBox(height: 10,),
            Row(children: [
              Text("Trans".tr),
              Text(" : ${model.transType}"),
            ],),
            SizedBox(height: 20,),
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("in Transit".tr),
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(3),
                      color: Colors.orange
                    ),
                  ),
                ),
                SizedBox(width: 100,),
                Expanded(child: IconButton(onPressed: (){
                  HomeLayoutCubit.get(context).deleteOrder(context, model);
                },icon: Icon(Icons.delete,color: Colors.red,),),),
              ],
            ),
            SizedBox(height: 10,),
          ],
        ),
      ),
    );
}