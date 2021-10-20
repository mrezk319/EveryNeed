import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/modules/admin/admin_screen.dart';
import 'package:e_commerce/modules/editProfile/edit_profile.dart';
import 'package:e_commerce/modules/login/log_in_screen.dart';
import 'package:e_commerce/modules/order/order_history.dart';
import 'package:e_commerce/modules/shipping/shipping_address.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:e_commerce/shared/network/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

class menu {
  String? image, title;

  menu({ this.image, required this.title});
}

List<menu> items = [
  menu(image: "prof", title: "Edit Profile"),
  menu(image: "loc", title: "Shipping Address"),
  menu(image: "order", title: "Order History"),
  menu(image: "noti", title: "Notifications"),
];
List functions = [
  EditProfile(),
  ShippingAddress(),
  OrderHistory(),
];
class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeLayoutCubit>(context),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.only(top: 100.0, right: 20, left: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      child: CircleAvatar(
                        child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child:CacheHelper.getData(key: "Picture") == ""? Image.network("https://www.iconpacks.net/icons/2/free-user-icon-3297-thumb.png",width: 300,): Image.network(
                              (CacheHelper.getData(key: "Picture")),
                              fit: BoxFit.cover,
                              width: 300,
                            )),
                        radius: 50,
                      ),
                      radius: 52,
                      backgroundColor: HexColor(color),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          width: 220,
                          child: Text(CacheHelper.getData(key: "Name"),
                              style: GoogleFonts.merriweatherSans(fontSize: 26),
                              overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text((CacheHelper.getData(key: "Email")),
                            style: GoogleFonts.merriweatherSans(fontSize: 17)),
                        SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                ListView.separated(
                  shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      if (index == items.length-1){
                        return Column(
                          children: [
                            InkWell(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Icon(Icons.language,size: 25,color: HexColor(color),),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Change Language".tr,
                                    style: GoogleFonts.merriweatherSans(
                                        fontSize: 22),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                              onTap: (){
                                showAnimatedDialog(context: context, builder: (context)=>ClassicGeneralDialogWidget(
                                  titleText: '',
                                  contentText: 'Choose language'.tr,
                                  onPositiveClick: () {
                                    Get.updateLocale(Locale('ar'));
                                    CacheHelper.saveData(key: "isArabic", value: true);
                                    Navigator.of(context).pop();
                                  },
                                  onNegativeClick: () {
                                    Get.updateLocale(Locale('en'));
                                    CacheHelper.saveData(key: "isArabic", value: false);
                                    Navigator.of(context).pop();
                                  },
                                  positiveText: "Arabic",
                                  negativeText: "English",
                                  negativeTextStyle: GoogleFonts.merriweatherSans(fontWeight: FontWeight.w600,color:Colors.black),
                                  positiveTextStyle: GoogleFonts.merriweatherSans(fontWeight: FontWeight.w600,color:Colors.black),
                                ), animationType: DialogTransitionType.slideFromBottomFade,
                                  curve: Curves.fastOutSlowIn,
                                  duration: Duration(seconds: 1),
                                );
                              },
                            ),
                            SizedBox(
                              height: 25,
                            ),
                            if(HomeLayoutCubit.get(context).isAdmin)
                            InkWell(
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 6,
                                  ),
                                  Icon(Icons.person,size: 25,color: HexColor(color),),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "For Admin".tr,
                                    style: GoogleFonts.merriweatherSans(fontSize: 22),
                                  ),
                                  Spacer(),
                                  Icon(Icons.arrow_forward_ios),
                                ],
                              ),
                              onTap: (){
                                Get.to(AdminScreen());
                              },
                            ),
                            if(HomeLayoutCubit.get(context).isAdmin)
                            SizedBox(
                              height: 35,
                            ),

                            InkWell(
                              child: Row(
                                children: [
                                  Image.asset(
                                    'assets/images/logout.png',
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(
                                    width: 15,
                                  ),
                                  Text(
                                    "Log Out".tr,
                                    style: GoogleFonts.merriweatherSans(
                                        fontSize: 22),
                                  ),
                                ],
                              ),
                              onTap: (){
                                FirebaseAuth.instance.signOut();
                                CacheHelper.saveData(key: "uid", value: null);
                                CacheHelper.saveData(key: "isLogged", value: false);
                                Get.to(LogIn());
                              },
                            ),
                          ],
                        );
                      }
                      return InkWell(child: menuItem(items[index]),onTap: (){Get.to(functions[index]);},);
                    },
                    separatorBuilder: (context, index) => SizedBox(
                          height: 25,
                        ),
                    itemCount: items.length),

              ],
            ),
          );
        },
      ),
    );
  }
}

Widget menuItem(menu model) => Row(
  children: [
    Image.asset(
      'assets/images/${model.image}.png',
      fit: BoxFit.cover,
    ),
    SizedBox(
      width: 15,
    ),
    Text(
      "${model.title}".tr,
      style: GoogleFonts.merriweatherSans(fontSize: 22),
    ),
    Spacer(),
    Icon(Icons.arrow_forward_ios),
  ],
);
