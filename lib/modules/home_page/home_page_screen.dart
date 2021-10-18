import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/models/category_model.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/modules/allBestSell/all_best_sell.dart';
import 'package:e_commerce/modules/productDetails/product_details.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive/hive.dart';
import 'package:loading_animations/loading_animations.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(value: BlocProvider.of<HomeLayoutCubit>(context)..getCategories()..getProducts()..getUserdata(),child: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context,state){},
      builder: (context,state){
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(title: Text("Rezk-Store".tr,style: GoogleFonts.merriweatherSans(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 26),),
          elevation: 0,
          backgroundColor: Colors.white,
          ),
          body: (HomeLayoutCubit.get(context).productModel!.length == 0)? Center(child: LoadingBouncingGrid.square(backgroundColor: HexColor(color),)): Padding(
            padding: const EdgeInsets.only(top: 5,left: 15, right: 15),
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      "Categories".tr,
                      style: GoogleFonts.merriweatherSans(
                          fontSize: 25, fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 125,
                    child: ListView.separated(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {

                          return Padding(
                            padding:index==0? const EdgeInsets.only(left: 3.0):EdgeInsets.only(left: 0.0),
                            child: categoryItem(HomeLayoutCubit.get(context).categoryModel![index]),
                          );
                        },
                        separatorBuilder: (context, index) => SizedBox(
                          width: 25,
                        ),
                        itemCount: HomeLayoutCubit.get(context).categoryModel!.length)),
                SizedBox(
                  height: 35,
                ),
                Row(
                  children: [
                    Text("Best Selling".tr,
                        style: GoogleFonts.merriweatherSans(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.w600)),
                    Spacer(),
                    TextButton(
                      child: Text(
                        "See all".tr,
                        style: GoogleFonts.merriweatherSans(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w300),
                      ),
                      onPressed: () {
                        Get.to(AllBestSell());
                      },
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                    height: 390,
                    child: ListView.separated(physics: BouncingScrollPhysics(),scrollDirection: Axis.horizontal,itemBuilder: (context,index)=>bestSell(HomeLayoutCubit.get(context).productModel![index]), separatorBuilder: (context,index)=>SizedBox(width: 10,), itemCount: 4)),
              ],
            ),
          ),
        );
      },
    ),)
    ;
  }
}

Widget categoryItem(CategoryModel model) => InkWell(
  child:   Padding(
    padding: const EdgeInsets.symmetric(vertical: 5.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
            decoration: BoxDecoration(shape: BoxShape.circle, boxShadow: [
              BoxShadow(spreadRadius: 1, blurRadius: 4, color: Colors.black)
            ]),
            child: CircleAvatar(
                radius: 37,
                backgroundColor: HexColor(color),
                child: CircleAvatar(
                  child: Image.network(
                    (model.picture??""),
                    width: 40,
                  ),
                  radius: 35,
                  backgroundColor: Colors.grey[100],
                ))),
        SizedBox(
          height: 15,
        ),
        Text("${model.name}".tr),
      ],
    ),
  ),
  onTap: (){
    Get.to(AllBestSell());
  },
);

Widget bestSell(ProdcutModel model) {
  return InkWell(
    child: Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            child: Image.network(
              (model.pic??""),
              fit: BoxFit.cover,
              width: 180,
              height: 290,
            ),
            borderRadius: BorderRadius.circular(7),
          ),
          Container(
            width: 180,
            child: Text("${model.name}".tr,
                style: GoogleFonts.merriweatherSans(
                    color: Colors.black,
                    fontSize: 19,
                    fontWeight: FontWeight.w300)),
          ),
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
    onTap: (){
      Get.to(ProductDetails(price: model.price,pic: model.pic,disc: model.disc,name: model.name,id: model.id,details: model.details,size: model.size,color: model.color,));
    },
  );
}
