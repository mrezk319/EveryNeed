import 'package:animated_widgets/AnimatedWidgets.dart';
import 'package:animated_widgets/widgets/opacity_animated.dart';
import 'package:animated_widgets/widgets/translation_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/modules/productDetails/noSql/nosql.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductDetails extends StatelessWidget {
  String? pic, name, disc,details,size,color,id;
  int?price;


  ProductDetails({this.name,this.pic,required this.disc,required this.price,required this.details,required this.size,required this.color,required this.id});
  var favBox = Hive.box<ProdcutModel>('fov');
  @override
  Widget build(BuildContext context) {

    return BlocProvider.value(value: BlocProvider.of<HomeLayoutCubit>(context)..changeColor(id, favBox),
    child: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context,state){},
      builder: (context,state){

        return Scaffold(
          body: TranslationAnimatedWidget.tween(
            translationDisabled: Offset(0, 200),
            translationEnabled: Offset(0, 0),
            child:
            OpacityAnimatedWidget.tween(
              opacityDisabled: 0,
              opacityEnabled: 1,
              child: Column(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Column(
                          children: [
                            Container(
                              child:
                              Image.network((pic ?? ""), fit: BoxFit.cover),
                              width: double.infinity,
                              height: 300,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5, bottom: 20),
                                    child: Text(
                                      (name ?? "").tr,
                                      style: GoogleFonts.merriweatherSans(fontSize: 30),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                    const EdgeInsets.symmetric(horizontal: 5.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 18.0, horizontal: 15),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Size".tr,
                                                    style: GoogleFonts.merriweatherSans(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  Spacer(),
                                                  Text(
                                                    (size ?? ""),
                                                    style: GoogleFonts.merriweatherSans(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: Colors.black12, width: 1)),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 25,
                                        ),
                                        Expanded(
                                          child: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 18.0, horizontal: 15),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    "Color".tr,
                                                    style: GoogleFonts.merriweatherSans(
                                                        fontWeight: FontWeight.bold,
                                                        fontSize: 15),
                                                  ),
                                                  Spacer(),
                                                  CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor: HexColor(
                                                        "${color ?? "#00000"}"),
                                                  )
                                                ],
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(15),
                                                border: Border.all(
                                                    color: Colors.black12, width: 1)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Row(
                                    children: [
                                      Text("Details".tr,
                                          style: GoogleFonts.merriweatherSans(
                                              fontSize: 25)),
                                      Spacer(),
                                      InkWell(
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0),
                                            child: CircleAvatar(
                                              child: Icon(Icons.favorite_border),
                                              radius: 22,
                                              backgroundColor:HomeLayoutCubit.get(context).col,
                                            ),
                                          ),
                                          onTap: () {
                                            HomeLayoutCubit.get(context).onPressFav(
                                                name: (name ?? ""),
                                                disc: (disc ?? ""),
                                                pic: (pic ?? ""),
                                                price: (price ?? 0),
                                                color: (color ?? ""),
                                                size: (size ?? ""),
                                                details: (details ?? ""),
                                                id: (id ?? ""),context: context);
                                            HomeLayoutCubit.get(context).changeColor(id, favBox);
                                          })
                                    ],
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text((details ?? "").tr,
                                      style: GoogleFonts.merriweatherSans(
                                          fontSize: 16, height: 1.6)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              "Price".tr,
                              style: GoogleFonts.merriweatherSans(
                                  fontSize: 18, fontWeight: FontWeight.w300),
                            ),
                            Text(
                              ("\$${price ?? ""}"),
                              style: GoogleFonts.merriweatherSans(
                                color: HexColor(color??"#0000"),
                              ),
                            )
                          ],
                        ),
                        Spacer(),
                        Container(
                          width: 150,
                          child: button(
                              text: "Add".tr,
                              function: () async {
                                CartModel cartModel = CartModel(
                                    price: price,
                                    disc: disc,
                                    name: name,
                                    pic: pic,
                                    howMany: 1,
                                    id: id,
                                    color: color,
                                    details: details,
                                    size: size);
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('cart')
                                    .doc(id)
                                    .get()
                                    .then((value) {
                                  if (!value.exists)
                                    Toast(
                                        text: "Added Successfully".tr,
                                        color: HexColor(color!),
                                        context: context);
                                  else
                                    Toast(
                                        text: "Already in cart".tr,
                                        color: Colors.blueGrey,
                                        context: context);
                                });
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection('cart')
                                    .doc(id)
                                    .set(cartModel.toMap());
                              }),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
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