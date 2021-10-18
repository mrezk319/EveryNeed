import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/home/cubit/cubit.dart';
import 'package:e_commerce/home/cubit/states.dart';
import 'package:e_commerce/home/home_layout.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/order_model.dart';
import 'package:e_commerce/shared/components/components.dart';
import 'package:e_commerce/shared/components/conistance.dart';
import 'package:e_commerce/shared/network/local.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:intl/intl.dart';
class CheckOut extends StatefulWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  @override
  var street1Controller = TextEditingController();
  var street2Controller = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var countryController = TextEditingController();
  var formKey = GlobalKey<FormState>();

  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeLayoutCubit>(context)..getAllCarts()..getTotalPrice(),
      child: BlocConsumer<HomeLayoutCubit, HomeLayoutStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return IntroductionScreen(
            pages: [
              PageViewModel(
                titleWidget: Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: Text(
                    "Delivery".tr,
                    style: GoogleFonts.merriweatherSans(fontSize: 25),
                  ),
                ),
                bodyWidget: Column(
                  children: [
                    SizedBox(
                      height: 55,
                    ),
                    RadioListTile(
                      value: (radios[0].title ?? ""),
                      groupValue: HomeLayoutCubit.get(context).value,
                      onChanged: (val) {
                        HomeLayoutCubit.get(context).changeradio(val);
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (radios[0].title ?? ""),
                            style: GoogleFonts.merriweatherSans(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text((radios[0].disc ?? ""),
                              style: GoogleFonts.merriweatherSans(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      activeColor: HexColor(color),
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    RadioListTile(
                      value: (radios[1].title ?? ""),
                      groupValue: HomeLayoutCubit.get(context).value,
                      onChanged: (val) {
                        HomeLayoutCubit.get(context).changeradio(val);
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (radios[1].title ?? ""),
                            style: GoogleFonts.merriweatherSans(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text((radios[1].disc ?? ""),
                              style: GoogleFonts.merriweatherSans(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      activeColor: HexColor(color),
                    ),
                    SizedBox(
                      height: 55,
                    ),
                    RadioListTile(
                      value: (radios[2].title ?? ""),
                      groupValue: HomeLayoutCubit.get(context).value,
                      onChanged: (val) {
                        HomeLayoutCubit.get(context).changeradio(val);
                      },
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            (radios[2].title ?? ""),
                            style: GoogleFonts.merriweatherSans(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text((radios[2].disc ?? ""),
                              style: GoogleFonts.merriweatherSans(
                                  fontSize: 18, fontWeight: FontWeight.w500)),
                        ],
                      ),
                      activeColor: HexColor(color),
                    ),
                  ],
                ),
              ),
              PageViewModel(
               titleWidget: Padding(
                 padding: const EdgeInsets.only(top: 10.0),
                 child: Text("Address".tr,style: GoogleFonts.merriweatherSans(fontSize: 25),),
               ),
                bodyWidget: Padding(
                  padding: const EdgeInsets.only(top: 45.0, left: 5, right: 5),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            child: Icon(
                              Icons.where_to_vote_sharp,
                              color: Colors.white,
                            ),
                            backgroundColor: Colors.green,
                            radius: 16,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Container(
                            width: 308,
                              child: Text(
                            "Billing address is the same as delivery address"
                                .tr,
                            style: GoogleFonts.merriweatherSans(),
                          )),
                        ],
                      ),
                      Form(
                        key: formKey,
                        child: Column(
                          children: [
                            SizedBox(
                              height: 55,
                            ),
                            item("Street 1".tr,street1Controller),
                            SizedBox(
                              height: 15,
                            ),
                            item("Street 2".tr,street2Controller),
                            SizedBox(
                              height: 45,
                            ),
                            item("City".tr,cityController),
                            SizedBox(
                              height: 45,
                            ),
                            Row(
                              children: [
                                Expanded(child: item("State".tr,stateController)),
                                SizedBox(
                                  width: 45,
                                ),
                                Expanded(child: item("Country".tr,countryController)),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              PageViewModel(
                titleWidget: Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text("Summary".tr,style: GoogleFonts.merriweatherSans(fontSize: 25)),
                ),
                bodyWidget: Column(
                  children: [
                    Container(
                        height: 300,
                        child: ListView.separated(scrollDirection: Axis.horizontal,itemBuilder: (context,index)=> bestSell(HomeLayoutCubit.get(context).cartModel![index]), separatorBuilder: (context,index)=>SizedBox(width: 10,), itemCount: HomeLayoutCubit.get(context).cartModel!.length)),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18.0),
                      child: Divider(height: 1,color: Colors.grey,),
                    ),
                    Align(child: Text("Total price".tr,style: GoogleFonts.merriweatherSans(fontSize: 25)),alignment: Alignment.topLeft,),
                    SizedBox(height: 15,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("\$${HomeLayoutCubit.get(context).sum.toString()}",style: GoogleFonts.merriweatherSans(color: HexColor(color),fontSize: 25),),
                      ],
                    ),
                  ],
                ),
              ),
            ],
            onDone: () {
              if(formKey.currentState!.validate()){
                String id = FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').doc().id;
                OrderModel orderModel = OrderModel(city: cityController.text,country: countryController.text,state: stateController.text,street1: street1Controller.text,street2: street2Controller.text,transType: HomeLayoutCubit.get(context).value,orderId: id,totalPrice: HomeLayoutCubit.get(context).sum,products: (HomeLayoutCubit.get(context).cartModel??[]),time: DateTime.now().toString());
                FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection('orders').doc(id).set(orderModel.toMap());
                Toast(text: "Added Successfully".tr, color: Colors.green,context: context);

                Get.to(HomeLayout());
              }
              else{
                Toast(text: "Please fill all data !!".tr, color: Colors.red,context: context);
              }
              // HomeLayoutCubit.get(context).cartModel!.forEach((element){print(element.name);});
            },
            showSkipButton: true,
            skip:  Text(
              "Skip".tr,
            ),
            next:  Text(
              "Next".tr,
            ),

            nextColor: HexColor(color),
            doneColor: HexColor(color),
            skipColor: HexColor(color),
            done:  Text("Done".tr,
                style: TextStyle(fontWeight: FontWeight.w600)),
            dotsDecorator: DotsDecorator(
                size: const Size.square(10.0),
                activeSize: const Size(20.0, 10.0),
                activeColor: HexColor(color),
                color: Colors.black26,
                spacing: const EdgeInsets.symmetric(horizontal: 3.0),
                activeShape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0))),
          );
        },
      ),
    );
  }
}

class radio {
  String? title, disc;

  radio({required this.title, required this.disc});
}

List<radio> radios = [
  radio(
      title: "Standard Delivery".tr,
      disc: "Order will be delivered between 3 - 5 business days".tr),
  radio(
      title: "Next Day Delivery".tr,
      disc:
          "Place your order before 6pm and your items will be delivered the next day"
              .tr),
  radio(
      title: "Nominated Delivery".tr,
      disc:
          "Pick a particular date from the calendar and order will be delivered on selected date"
              .tr),
];

Widget item(text, controller) => Column(
  crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18.0),
          child: Text(text,style: GoogleFonts.merriweatherSans(color: Colors.black38,fontSize: 19),),
        ),
        TextFormField(controller: controller,validator: (val){
          if(val!.isEmpty){
            return "This field can't be empty".tr;
          }
        },)
      ],
    );
Widget bestSell(CartModel model) {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          child: Image.network(
            (model.pic??""),
            fit: BoxFit.cover,
            width: 150,
            height: 200,
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
  );
}