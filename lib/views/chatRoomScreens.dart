import 'package:chat_app/helper/helper_functions.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/views/search.dart';
import 'package:chat_app/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:chat_app/helper/constants.dart';


class ChatRoom extends StatefulWidget {
 static const String id='chatRoom';

  @override
  State<ChatRoom> createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {
  AuthMethods authMethods = AuthMethods();
  @override
  void initState() {
    getUserInfo();
    super.initState();
  }
  getUserInfo()async{
    Constants.myName=await HelperFunctions.getUserNameSharedPreference().toString();}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:Text('YourChat',style: GoogleFonts.cuteFont(
          fontSize: 50,
          color: Colors.white,),),
        actions: [
          GestureDetector(
            onTap: (){
              Navigator.pushNamed(context, SignIn.id);
            },
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(Icons.exit_to_app),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {Navigator.pushNamed(context, SearchScreen.id);
          },
        child: Icon(Icons.search),
      ),
    );
  }
}
