import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/productDetails/product_details.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:loading_animations/loading_animations.dart';

class CategotyProduct extends StatelessWidget {
  String id;
  CategotyProduct(this.id);
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeLayoutCubit>(context)..getCategoryProductModel(this.id),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              iconTheme: IconThemeData(color: HexColor(color)),
              title: Text(
                "Products".tr,
                style: GoogleFonts.merriweatherSans(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 26),
              ),
              elevation: 0,
              backgroundColor: Colors.white,
            ),
            body: state is getCategoruProductModelLoadingState
                ? Center(
                child: LoadingBouncingGrid.square(
                  backgroundColor: HexColor(color),
                ))
                : HomeLayoutCubit
                .get(context)
                .categoruProductModel!
                .length == 0
                ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/emptyCart.png',
                      width: 250,
                    ),
                    Text(
                      "No products here".tr,
                      style: GoogleFonts.merriweatherSans(fontSize: 25),
                    ),
                  ],
                )): Padding(
              padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
              child: ListView(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  GridView.count(
                    childAspectRatio: 1/2.2,
                    children: List.generate(
                        HomeLayoutCubit.get(context).categoruProductModel!.length,
                            (index) => bestSell(HomeLayoutCubit.get(context)
                            .categoruProductModel![index])),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
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

Widget bestSell(ProdcutModel model) {
  return InkWell(
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              child: Image.network(
                (model.pic ?? ""),
                width: 180,
                height: 260,
              ),
              borderRadius: BorderRadius.circular(7),
            ),
            Text("${model.name}".tr,
                style: GoogleFonts.merriweatherSans(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w300)),
            SizedBox(
              height: 3,
            ),
            Text("${model.disc}",
                style: GoogleFonts.merriweatherSans(
                    color: Colors.black54,
                    fontSize: 12,
                    fontWeight: FontWeight.w100)),
            SizedBox(
              height: 3,
            ),
            Text("\$${model.price}",
                style: GoogleFonts.merriweatherSans(
                    color: HexColor(color),
                    fontSize: 20,
                    fontWeight: FontWeight.w300)),
            SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    ),
    onTap: () {
      Get.to(ProductDetails(
        price: model.price,
        pic: model.pic,
        disc: model.disc,
        name: model.name,
        id: model.id,
        details: model.details,
        size: model.size,
        color: model.color,
      ));
    },
  );
}
