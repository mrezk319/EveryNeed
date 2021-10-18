import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';
import 'package:get/get_utils/src/extensions/internacionalization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';

import 'conistance.dart';

Widget textForm(
        {required text,
        required hint,
        required TextEditingController controller,
        required validator,
        obsecure = false
        }) =>
    Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${text}".tr,
            style: GoogleFonts.merriweatherSans(color: Colors.black54)),
        TextFormField(
          obscureText: obsecure,
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HexColor(color)),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: HexColor(color)),
              ),
              focusColor: HexColor(color),
              hintText: "${hint}".tr,
              hintStyle: GoogleFonts.merriweatherSans(color: Colors.black26)),
        ),
      ],
    );

Widget button({required text,required function}) => MaterialButton(
    onPressed: function,
    child: Text(
      "${text}".tr,
      style: GoogleFonts.merriweatherSans(color: Colors.white, fontSize: 16),
    ),
    color: HexColor(color),
    minWidth: double.infinity,
    height: 50);

Toast({required text,required Color color,context})=>showToast(text,backgroundColor: color,position: StyledToastPosition.bottom,context: context);