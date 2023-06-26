import 'package:chat_app/views/signin.dart';
import 'package:flutter/material.dart';
import 'package:chat_app/services/auth.dart';
import 'package:chat_app/services/database.dart';
import 'package:chat_app/helper/helper_functions.dart';

import '../widgets/widget.dart';
import 'chatRoomScreens.dart';


class SignUp extends StatefulWidget {
static const String id='signup';

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading=false;
  AuthMethods authMethods=new AuthMethods();
DatabaseMethods databaseMethods=new DatabaseMethods();
HelperFunctions helperFunctions=new HelperFunctions();

  final formKey =GlobalKey<FormState>();
  TextEditingController userNameTextEditingController=new TextEditingController();
  TextEditingController emailTextEditingController=new TextEditingController();
  TextEditingController passwordTextEditingController=new TextEditingController();
  signMeUp(){
    if(formKey.currentState!.validate()){
setState(() {
  isLoading=true;
});
authMethods.signInWithEmailAndPassword(emailTextEditingController.text, passwordTextEditingController.text).then((val){
 //print('${val.uid}');
  Map<String,String>userInfoMap={
    'name':userNameTextEditingController.text,
    'email':emailTextEditingController.text,
  };
  HelperFunctions.saveUserEmailSharedPreference(emailTextEditingController.text);
  HelperFunctions.saveUserNameSharedPreference(userNameTextEditingController.text);


  databaseMethods.uploadUserInfo(userInfoMap);
  HelperFunctions.saveUserLoggedInSharedPreference(true);
  Navigator.pushNamed(context, ChatRoom.id);
});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: isLoading? Container(
        child: Center(child: CircularProgressIndicator()),
      ): SingleChildScrollView(

        child: Container(

          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(height: 300,),
               Form(
                 key: formKey,
                 child: Column(
                   children: [
                     TextFormField(
                       validator: (val){
return val!.isEmpty ||val!.length<3 ? ' Please Provide a valid username':null;
                       },
                         controller: userNameTextEditingController,
                         style: simpleTextStyle(),
                         decoration: textFieldInputDecoration('username')
                     ),
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
                       obscureText: true,
                       validator: (val){
                         return val!.length>6? null:'Password must hold more than 6 characters';
                       },
                         controller: passwordTextEditingController,
                         style: simpleTextStyle(),
                         decoration:textFieldInputDecoration('password')
                     ),
                   ],
                 ),
               ),
                SizedBox(
                  height: 16,
                ),
                SizedBox(height: 8,),
                GestureDetector(
                  onTap: (){
                    signMeUp();
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
                    Text('Already have an account? ',style: simpleTextStyle(),),
                    GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context,SignIn.id);
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text('Log In',style: TextStyle(
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

