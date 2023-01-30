import 'dart:ui';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';

const colorRed = Color.fromRGBO(231,28,36,1);
const colorGreen = Color.fromRGBO(33,191,115,1);
const colorWhite = Color.fromRGBO(255,255,255,1);
const colorDarkBlue = Color.fromRGBO(44,62,80,1);

ScreenBackground(context){
  return SvgPicture.asset(
    'lib/asset/screen.svg',
    alignment:Alignment.center,
    width:MediaQuery.of(context).size.width,
    height:MediaQuery.of(context).size.height,
    fit:BoxFit.cover,
  );
}


InputDecoration AppInputDecoraton(label){
  return InputDecoration(
    focusedBorder: const OutlineInputBorder(
      borderSide:const BorderSide(color:colorGreen,width:1),
    ),
    fillColor: colorWhite,
    filled: true,
    contentPadding: EdgeInsets.fromLTRB(20, 10, 10, 20),
    enabledBorder: const OutlineInputBorder(
      borderSide:const BorderSide(color:colorWhite,width: 0),
    ),
    border: OutlineInputBorder(),
    labelText:label,
  );
}

DecoratedBox AppDropDownStyle(child){
  return DecoratedBox(
    decoration: BoxDecoration(
      color:colorWhite,
      border:Border.all(color:colorWhite,width:1),
      borderRadius: BorderRadius.circular(4),
    ),
    child:Padding(
      padding:EdgeInsets.only(left:30,right:30),
      child: child,
    )
  );
}

ButtonStyle AppButtonstyle(){
  return ElevatedButton.styleFrom(
    elevation: 1,
    padding:EdgeInsets.all(0),
    backgroundColor: Colors.transparent,
    shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(6))
  );
}

Ink SuccessButtonChild(ButtonText){
  return Ink(
    decoration: BoxDecoration(
      color:colorGreen,
      borderRadius: BorderRadius.circular(6),
    ),
    child: Container(
      height:49,
      alignment: Alignment.center,
      child:Text(
        ButtonText,
        style:TextStyle(
          fontWeight:FontWeight.w400,
          fontSize: 15,
        ),
      )
    ),
  );
}


SliverGridDelegateWithFixedCrossAxisCount ProductGridViewStyle(){
  return SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: 2,
    mainAxisExtent: 250,  
  );
}