import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget? appBarMain(BuildContext context){
  return AppBar(
    title: Text('YourChat',style: GoogleFonts.cuteFont(
      fontSize: 50,
      color: Colors.white,),),
  );
}

InputDecoration textFieldInputDecoration(String hintTxet){
  return InputDecoration(
      hintText: hintTxet,
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white)
      ),
      hintStyle: TextStyle(color: Colors.white54,fontSize: 20)
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.white,
    fontSize: 17
  );
}