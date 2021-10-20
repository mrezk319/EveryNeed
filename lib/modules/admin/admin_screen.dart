import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/models/product_model.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:firebase_storage/firebase_storage.dart' as fireStorage;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AdminScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text('Admin Bannel'.tr),
            bottom: TabBar(
              tabs: [
                Tab(text: "Men".tr),
                Tab(text: "Women".tr),
                Tab(text: "Devices".tr),
                Tab(text: "Gaming".tr),
                Tab(text: "Gadgets".tr),
              ],
              isScrollable: true,
            ),
          ),
          body: TabBarView(
            children: <Widget>[
              men(context),
              women(context),
              devices(context),
              gaming(context),
              gadgets(context),
            ],
          )),
    );
  }
}

Widget men(context) {
  var priceController = TextEditingController();
  var nameController = TextEditingController();
  var discController = TextEditingController();
  var detailsController = TextEditingController();
  var colorController = TextEditingController();
  var sizeController = TextEditingController();
  return BlocProvider.value(
    value: BlocProvider.of<HomeLayoutCubit>(context)
      ..getCategoryProductMenModel('Cl5iScoUf7EOX18OqWzK'),
    child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is getCategoruProductModelLoadingState) {
          return Center(
              child: LoadingBouncingGrid.square(
                backgroundColor: HexColor(color),
              ));
        } else if (HomeLayoutCubit
            .get(context)
            .categoruProductMenModel!
            .length ==
            0) {
          return Center(
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
                  Floatt(context: context,id: "Cl5iScoUf7EOX18OqWzK",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),
                ],
              ));
        } else {
          return Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      GridView.count(
                        childAspectRatio: 1 / 2.2,
                        children: List.generate(
                            HomeLayoutCubit
                                .get(context)
                                .categoruProductMenModel!
                                .length,
                                (index) =>
                                bestSell(
                                    HomeLayoutCubit
                                        .get(context)
                                        .categoruProductMenModel![index],
                                    "Cl5iScoUf7EOX18OqWzK",
                                    context)),
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        crossAxisCount: 2,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0,right: 5),
                  child: Align(child: Floatt(context: context,id: "Cl5iScoUf7EOX18OqWzK",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),alignment: Alignment.bottomRight,),
                ),
              ],
            ),
          );
        }
        ;
      },
    ),
  );
}

Widget women(context) {
  var priceController = TextEditingController();
  var nameController = TextEditingController();
  var discController = TextEditingController();
  var detailsController = TextEditingController();
  var colorController = TextEditingController();
  var sizeController = TextEditingController();
  return BlocProvider.value(
    value: BlocProvider.of<HomeLayoutCubit>(context)
      ..getCategoryProductWomenModel('ORSIX2UM8iUNba5KknE1'),
    child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is getCategoruProductModelLoadingState
            ? Center(
            child: LoadingBouncingGrid.square(
              backgroundColor: HexColor(color),
            ))
            : HomeLayoutCubit
            .get(context)
            .categoruProductWomenModel!
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
                Floatt(context: context,id: "ORSIX2UM8iUNba5KknE1",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),
              ],
            ))
            : Padding(
          padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              GridView.count(
                childAspectRatio: 1 / 2.2,
                children: List.generate(
                    HomeLayoutCubit
                        .get(context)
                        .categoruProductWomenModel!
                        .length,
                        (index) =>
                        bestSell(
                            HomeLayoutCubit
                                .get(context)
                                .categoruProductWomenModel![index],
                            "ORSIX2UM8iUNba5KknE1",
                            context)),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 5),
                child: Align(child: Floatt(context: context,id: "ORSIX2UM8iUNba5KknE1",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),alignment: Alignment.bottomRight,),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget gaming(context) {
  var priceController = TextEditingController();
  var nameController = TextEditingController();
  var discController = TextEditingController();
  var detailsController = TextEditingController();
  var colorController = TextEditingController();
  var sizeController = TextEditingController();
  return BlocProvider.value(
    value: BlocProvider.of<HomeLayoutCubit>(context)
      ..getCategoryProductGamingModel('EqGVjYoTDn9NcyxmyXGR'),
    child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is getCategoruProductModelLoadingState
            ? Center(
            child: LoadingBouncingGrid.square(
              backgroundColor: HexColor(color),
            ))
            : HomeLayoutCubit
            .get(context)
            .categoruProductGamingModel!
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
                Floatt(context: context,id: "EqGVjYoTDn9NcyxmyXGR",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),
              ],
            ))
            : Padding(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              GridView.count(
                childAspectRatio: 1 / 2.2,
                children: List.generate(
                    HomeLayoutCubit
                        .get(context)
                        .categoruProductGamingModel!
                        .length,
                        (index) =>
                        bestSell(
                            HomeLayoutCubit
                                .get(context)
                                .categoruProductGamingModel![index],
                            "EqGVjYoTDn9NcyxmyXGR",
                            context)),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 5),
                child: Align(child: Floatt(context: context,id: "EqGVjYoTDn9NcyxmyXGR",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),alignment: Alignment.bottomRight,),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget gadgets(context) {
  var priceController = TextEditingController();
  var nameController = TextEditingController();
  var discController = TextEditingController();
  var detailsController = TextEditingController();
  var colorController = TextEditingController();
  var sizeController = TextEditingController();
  return BlocProvider.value(
    value: BlocProvider.of<HomeLayoutCubit>(context)
      ..getCategoryProductGadgetModel('ETfjjbmipepEyHlbylrN'),
    child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is getCategoruProductModelLoadingState
            ? Center(
            child: LoadingBouncingGrid.square(
              backgroundColor: HexColor(color),
            ))
            : HomeLayoutCubit
            .get(context)
            .categoruProductGadgetModel!
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
                Floatt(context: context,id: "ETfjjbmipepEyHlbylrN",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),
              ],
            ))
            : Padding(
          padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              GridView.count(
                childAspectRatio: 1 / 2.2,
                children: List.generate(
                    HomeLayoutCubit
                        .get(context)
                        .categoruProductGadgetModel!
                        .length,
                        (index) =>
                        bestSell(
                            HomeLayoutCubit
                                .get(context)
                                .categoruProductGadgetModel![index],
                            "ETfjjbmipepEyHlbylrN",
                            context)),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 5),
                child: Align(child: Floatt(context: context,id: "ETfjjbmipepEyHlbylrN",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),alignment: Alignment.bottomRight,),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget devices(context) {
  var priceController = TextEditingController();
  var nameController = TextEditingController();
  var discController = TextEditingController();
  var detailsController = TextEditingController();
  var colorController = TextEditingController();
  var sizeController = TextEditingController();
  return BlocProvider.value(
    value: BlocProvider.of<HomeLayoutCubit>(context)
      ..getCategoryProductDeviceModel('HIkSDctmlXGSNRCyEIGA'),
    child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return state is getCategoruProductModelLoadingState
            ? Center(
            child: LoadingBouncingGrid.square(
              backgroundColor: HexColor(color),
            ))
            : HomeLayoutCubit
            .get(context)
            .categoruProductDeviceModel!
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
                Floatt(context: context,id: "HIkSDctmlXGSNRCyEIGA",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),
              ],
            ))
            : Padding(
          padding: const EdgeInsets.only(top: 5, left: 15, right: 15),
          child: ListView(
            children: [
              SizedBox(
                height: 10,
              ),
              GridView.count(
                childAspectRatio: 1 / 2.2,
                children: List.generate(
                    HomeLayoutCubit
                        .get(context)
                        .categoruProductDeviceModel!
                        .length,
                        (index) =>
                        bestSell(
                            HomeLayoutCubit
                                .get(context)
                                .categoruProductDeviceModel![index],
                            "HIkSDctmlXGSNRCyEIGA",
                            context)),
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 5),
                child: Align(child: Floatt(context: context,id: "HIkSDctmlXGSNRCyEIGA",size: sizeController,details: detailsController,disc: discController,price: priceController,name: nameController,Color: colorController),alignment: Alignment.bottomRight,),
              ),
            ],
          ),
        );
      },
    ),
  );
}

Widget bestSell(ProdcutModel model, id, context) {
  var priceController = TextEditingController();
  var nameController = TextEditingController();
  var discController = TextEditingController();
  var detailsController = TextEditingController();
  var colorController = TextEditingController();
  var sizeController = TextEditingController();
  priceController.text = model.price.toString();
  nameController.text = model.name.toString();
  detailsController.text = model.details.toString();
  discController.text = model.disc.toString();
  colorController.text = model.color.toString();
  sizeController.text = model.size.toString();
  var formKey = GlobalKey<FormState>();
  return InkWell(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
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
            Row(
              children: [
                Text("${model.disc}",
                    style: GoogleFonts.merriweatherSans(
                        color: Colors.black54,
                        fontSize: 12,
                        fontWeight: FontWeight.w100)),
                Spacer(),
                InkWell(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Icon(
                      Icons.delete_forever_rounded,
                      color: Colors.red,
                      size: 30,
                    ),
                  ),
                  onTap: () {
                    FirebaseFirestore.instance
                        .collection('categories')
                        .doc(id)
                        .collection('products')
                        .doc(model.id)
                        .delete()
                        .whenComplete(() =>
                    {
                      HomeLayoutCubit.get(context).getAll(
                          menId: "Cl5iScoUf7EOX18OqWzK",
                          deviceId: "HIkSDctmlXGSNRCyEIGA",
                          gadgetId: "ETfjjbmipepEyHlbylrN",
                          ganmingId: "EqGVjYoTDn9NcyxmyXGR",
                          WomenId: "ORSIX2UM8iUNba5KknE1")
                    });
                  },
                ),
              ],
            ),
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
      showMaterialModalBottomSheet(
        context: context,
        builder: (context) =>
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(children: [
                Center(
                  child: Stack(
                    alignment: AlignmentDirectional.bottomEnd,
                    children: [
                      Container(
                        child: model.pic ==
                            null
                            ? SizedBox()
                            : Image.network((model.pic??"")),
                        width: 180,
                        height: 220,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(
                              15),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(25.0),
                        child: CircleAvatar(
                          child: IconButton(
                            onPressed: () {
                              HomeLayoutCubit.get(context)
                                  .getImage();
                            },
                            icon: Icon(Icons.add),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      item(
                          text: "Name".tr,
                          controller: nameController),
                      item(
                          text: "Price".tr,
                          controller: priceController,
                          type: TextInputType.number),
                      item(
                          text: "Description".tr,
                          controller: discController),
                      item(
                          text: "Details".tr,
                          controller: detailsController),
                      item(
                          text: "Color".tr,
                          controller: colorController),
                      item(
                          text: "Size".tr,
                          controller: sizeController),
                    ],
                  ),
                ),
                Container(
                  width: 100,
                  height: 40,
                  child: button(text: "Update".tr, function: () {
                    if (formKey.currentState!.validate()) {
                      if (HomeLayoutCubit
                          .get(context)
                          .image != null) {
                        fireStorage.FirebaseStorage.instance
                            .ref()
                            .child(
                            'Products/${Uri
                                .file(HomeLayoutCubit
                                .get(context)
                                .image!
                                .path)
                                .pathSegments
                                .last}')
                            .putFile((HomeLayoutCubit
                            .get(context)
                            .image as File)).then((val) {
                          val.ref.getDownloadURL().then((value) {
                            FirebaseFirestore.instance.collection('categories')
                                .doc(
                                id)
                                .collection('products').doc(model.id).update({
                              'name': nameController.text,
                              'price': int.parse(priceController.text),
                              'disc': discController.text,
                              'color': colorController.text,
                              'size': sizeController.text,
                              'details': detailsController.text,
                              'picture': value,
                            })
                                .then((value) {
                              Get.back();
                              HomeLayoutCubit.get(context).getAll
                                (
                                  menId: "Cl5iScoUf7EOX18OqWzK",
                                  deviceId: "HIkSDctmlXGSNRCyEIGA",
                                  gadgetId: "ETfjjbmipepEyHlbylrN",
                                  ganmingId: "EqGVjYoTDn9NcyxmyXGR",
                                  WomenId: "ORSIX2UM8iUNba5KknE1");
                              HomeLayoutCubit
                                  .get(context)
                                  .image = null;
                            });
                          });
                        });
                      }
                      else
                      {
                        FirebaseFirestore.instance.collection('categories').doc(
                            id)
                            .collection('products').doc(model.id).update({
                          'name': nameController.text,
                          'price': int.parse(priceController.text),
                          'disc': discController.text,
                          'color': colorController.text,
                          'size': sizeController.text,
                          'details': detailsController.text,
                        }).then((value) {
                          Get.back();
                          HomeLayoutCubit.get(context).getAll
                            (
                              menId: "Cl5iScoUf7EOX18OqWzK",
                              deviceId: "HIkSDctmlXGSNRCyEIGA",
                              gadgetId: "ETfjjbmipepEyHlbylrN",
                              ganmingId: "EqGVjYoTDn9NcyxmyXGR",
                              WomenId: "ORSIX2UM8iUNba5KknE1");
                        });
                      }
                    }
                  }),

                ),
              ]),
            ),
      );
    },
  );
}

Widget item({text, controller, TextInputType type = TextInputType
    .text}) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          decoration: InputDecoration(
            hintText: text
          ),
          controller: controller,
          validator: (val) {
            if (val!.isEmpty) {
              return "This field can't be empty".tr;
            }
          },
          keyboardType: type,
        ),
        SizedBox(height: 10,),
      ],
    );

Widget Floatt(
    {
      conext,
  id,
  context,
  TextEditingController? name,
  TextEditingController? price,
  TextEditingController? disc,
  TextEditingController? details,
  TextEditingController? Color,
  TextEditingController? size,
})=>FloatingActionButton(
  onPressed: () {
    var formKey = GlobalKey<FormState>();
    showMaterialModalBottomSheet(
      context: context,
      builder: (context) =>
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(children: [
              Center(
                child: Stack(
                  alignment: AlignmentDirectional.bottomEnd,
                  children: [
                    Container(
                      child: HomeLayoutCubit
                          .get(context)
                          .image ==
                          null
                          ? SizedBox()
                          : Image(
                        image: FileImage(
                            HomeLayoutCubit
                                .get(context)
                                .image
                            as File),
                      ),
                      width: 180,
                      height: 220,
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(
                            15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: CircleAvatar(
                        child: IconButton(
                          onPressed: () {
                            HomeLayoutCubit.get(context)
                                .getImage();
                          },
                          icon: Icon(Icons.add),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: 15,
                    ),
                    item(
                        text: "Name".tr,
                        controller: name),
                    item(
                        text: "Price".tr,
                        controller: price,
                        type: TextInputType.number),
                    item(
                        text: "Description".tr,
                        controller: disc),
                    item(
                        text: "Details".tr,
                        controller: details),
                    item(
                        text: "Color".tr,
                        controller: Color),
                    item(
                        text: "Size".tr,
                        controller: size),
                  ],
                ),
              ),
              Container(
                width: 100,
                height: 40,
                child: button(text: "Add".tr, function: () {
                  if (formKey.currentState!.validate() && HomeLayoutCubit
                      .get(context)
                      .image != null) {
                    fireStorage.FirebaseStorage.instance
                        .ref()
                        .child(
                        'Products/${Uri
                            .file(HomeLayoutCubit
                            .get(context)
                            .image!
                            .path)
                            .pathSegments
                            .last}')
                        .putFile((HomeLayoutCubit
                        .get(context)
                        .image as File)).then((val) {
                      val.ref.getDownloadURL().then((value) {
                        FirebaseFirestore.instance.collection('categories').doc(
                            id)
                            .collection('products').add({
                          'name': name!.text,
                          'price': int.parse(price!.text),
                          'disc': disc!.text,
                          'color': Color!.text,
                          'size': size!.text,
                          'details': details!.text,
                          'picture': value,
                        }).then((value) {
                          FirebaseFirestore.instance.collection('categories')
                              .doc(id)
                              .collection('products').doc(value.id)
                              .update({
                            'id': value.id,
                          });
                          Get.back();
                          HomeLayoutCubit.get(context).getAll
                            (
                              menId: "Cl5iScoUf7EOX18OqWzK",
                              deviceId: "HIkSDctmlXGSNRCyEIGA",
                              gadgetId: "ETfjjbmipepEyHlbylrN",
                              ganmingId: "EqGVjYoTDn9NcyxmyXGR",
                              WomenId: "ORSIX2UM8iUNba5KknE1");
                          HomeLayoutCubit
                              .get(context)
                              .image = null;
                        });
                      });
                    });
                  }
                  else{
                    Toast(text: "Please fill all data !!", color: Colors.red,context: context);
                  }
                }
                ),

              ),
            ]),
          ),
    );
  },
  backgroundColor: HexColor(color),
  child: Icon(
    Icons.add,
    size: 30,
  ),
);