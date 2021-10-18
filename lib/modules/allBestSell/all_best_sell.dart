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

class AllBestSell extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeLayoutCubit>(context)..getProducts(),
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
            body: (HomeLayoutCubit.get(context).productModel!.length == 0)
                ? Center(
                    child: LoadingBouncingGrid.square(
                    backgroundColor: HexColor(color),
                  ))
                : Padding(
                    padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        GridView.count(
                          childAspectRatio: 1/2.2,
                          children: List.generate(
                              HomeLayoutCubit.get(context).productModel!.length,
                              (index) => bestSell(HomeLayoutCubit.get(context)
                                  .productModel![index])),
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
                fit: BoxFit.cover,
                width: 180,
                height: 290,
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
      print(model.id);
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
