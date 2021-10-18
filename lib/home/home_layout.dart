import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:google_fonts/google_fonts.dart';
class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return BlocProvider(create:(context)=> HomeLayoutCubit(),
    child: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
      listener: (context,state){},
      builder:  (context,state){
        return Scaffold(
          body: HomeLayoutCubit.get(context).Screens[HomeLayoutCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavyBar(
            containerHeight: 60,

            selectedIndex: HomeLayoutCubit.get(context).currentIndex,
            items: [
              BottomNavyBarItem(icon: Image.asset("assets/images/explore.png",width: 20,), title: Text(" Explore".tr,style: GoogleFonts.merriweatherSans(),),activeColor: HexColor(color),inactiveColor: Colors.grey),
              BottomNavyBarItem(icon: Image.asset("assets/images/cart.png",width: 22,), title: Text(" Cart".tr,style: GoogleFonts.merriweatherSans(),),activeColor: HexColor(color),inactiveColor: Colors.grey),
              BottomNavyBarItem(icon: Icon(Icons.favorite_border,color: Colors.red,), title: Text(" Favourite".tr,style: GoogleFonts.merriweatherSans(),),activeColor: HexColor(color),inactiveColor: Colors.grey),
              BottomNavyBarItem(icon: Image.asset("assets/images/user.png",width: 22,), title: Text(" Account".tr,style: GoogleFonts.merriweatherSans(),),activeColor: HexColor(color),inactiveColor: Colors.grey),
            ], onItemSelected: (int index) {
            HomeLayoutCubit.get(context).changeIndex(index);
          },
          ),
        );
      },
    ),
    );
  }
}
