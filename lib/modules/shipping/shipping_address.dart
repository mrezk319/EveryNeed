import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';

class ShippingAddress extends StatelessWidget {
  const ShippingAddress({Key? key}) : super(key: key);

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
              iconTheme: IconThemeData(color: HexColor(color)),
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0,
              title: Text(
                "Shipping Address".tr,
                style: GoogleFonts.merriweatherSans(color: Colors.black),
              ),
            ),
            body: state is getOrdersLoadingState
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
                            "Shipping is Empty".tr,
                            style: GoogleFonts.merriweatherSans(fontSize: 25),
                          ),
                        ],
                      ))
                    : ListView.separated(
                        itemBuilder: (context, index) => orderItem(
                            HomeLayoutCubit.get(context).orders[index]),
                        separatorBuilder: (context, index) => SizedBox(
                              height: 15,
                            ),
                        itemCount: HomeLayoutCubit.get(context).orders.length),
          );
        },
      ),
    );
  }
}

Widget orderItem(OrderModel orders) => Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 300,
            height: 170,
            child: Card(
              elevation: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 300,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Address : ".tr),
                        Text(
                            "${orders.street1}, ${orders.street2}, ${orders.state}, ${orders.city}, ${orders.country}"),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      "Trans".tr,
                    ),
                    Text(" : ${orders.transType}"),
                  ],
                ),
              ],
            ),
          ),
      ),
  ],
    ),
);
