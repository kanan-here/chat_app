import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/views/signup.dart';
import 'package:chat_app/widgets/widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../helper/helper_functions.dart';
import 'chatRoomScreens.dart';

class SignIn extends StatefulWidget {
  static const String id='signin';

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final formKey= GlobalKey<FormState>();
  AuthMethods authMethods=new AuthMethods();
  DatabaseMethods databaseMethods=new DatabaseMethods();
  TextEditingController emailTextEditingController=new TextEditingController();
  TextEditingController passwordTextEditingController=new TextEditingController();

  bool isLoading=false;
  late QuerySnapshot snapshotUserInfo;

  signIn(){
    if(formKey.currentState!.validate()){
      HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
     //HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);

      //TODO  function to get user details
      setState(() {
        isLoading=true;
      });
      databaseMethods.getUserByUserEmail(emailTextEditingController.text).then((val) {
        snapshotUserInfo = val();

        if (snapshotUserInfo != null && snapshotUserInfo.docs.isNotEmpty) {
          String userName = snapshotUserInfo.docs[0].get('name');
          HelperFunctions.saveUserEmailSharedPreference(userName);
        }
      });



      authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
        if(val!=null){

          HelperFunctions.saveUserLoggedInSharedPreference(true);
          Navigator.pushNamed(context, ChatRoom.id);
        }
      });



    }
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
    appBar: appBarMain(context),
     body: SingleChildScrollView(

       child: Container(

         alignment: Alignment.bottomCenter,
         child: Container(
           padding: EdgeInsets.symmetric(horizontal: 20),
           child: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               SizedBox(height: 300,),
              Form(

                child: Column(
                  children: [
                    TextFormField(
                        validator: (val){
                          return RegExp('^[A-Za-z0-9](([a-zA-Z0-9,=\.!\-#|\$%\^&\*\+/\?_`\{\}~]+)*)@(?:[0-9a-zA-Z-]+\.)+[a-zA-Z]{2,9}')
                              .hasMatch(val!)? null: 'Please provide a valid email';
                        },
                        controller: emailTextEditingController,

                        style: simpleTextStyle(),
                        decoration: textFieldInputDecoration('email')
                    ),
                    TextFormField(
                        validator: (val){
                          return val!.length>6? null:'Password must hold more than 6 characters';
                        },
                        obscureText: true,
                        controller: passwordTextEditingController,
                        style: simpleTextStyle(),
                        decoration:textFieldInputDecoration('password')
                    ),
                  ],
                ),
              ),
               SizedBox(
                 height: 8,
               ),
               Container(
                 alignment: Alignment.centerRight,
                 child: Container(
                   padding: EdgeInsets.symmetric(horizontal: 16,vertical: 8),
                   child: Text('Forgot Password?',style: simpleTextStyle(),),
                 ),
               ),
               SizedBox(height: 8,),
               GestureDetector(
                 onTap: (){
                   signIn();
                 },
                 child: Container(
                   alignment: Alignment.center,
                   width: MediaQuery.of(context).size.width,
                   padding: EdgeInsets.symmetric(vertical: 20),
                   decoration: BoxDecoration(
                     gradient: LinearGradient(
                       colors: [
                         const Color(0xff007EF4),
                         const Color(0xff2A75BC),
                       ]
                     ),
                     borderRadius: BorderRadius.circular(30),
                   ),
                   child: Text('Sign In ',style: simpleTextStyle(),),
                 ),
               ),
               SizedBox(height: 16,),
               Container(
                 alignment: Alignment.center,
                 width: MediaQuery.of(context).size.width,
                 padding: EdgeInsets.symmetric(vertical: 20),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(30),
                 ),
                 child: Text('Sign In with Google',style: TextStyle(
                   color: Colors.black,
                   fontSize: 17
                 ),),
               ),
               SizedBox(
                 height: 16,
               ),
Row(
  mainAxisAlignment: MainAxisAlignment.center,
  children: [
    Text('Dont have an account? ',style: simpleTextStyle(),),
    GestureDetector(
      onTap: (){
        Navigator.pushNamed(context,
        SignUp.id);
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Text('Register Now!',style: TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline
        ),),
      ),
    )
  ],
),
             ],
           ),
         ),
       ),
     ),

   );
  }
}
