import 'package:flutter/material.dart';
import 'views/signin.dart';
import 'views/signup.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'views/search.dart';
import 'views/chatRoomScreens.dart';
import 'views/converstion_screen.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

late  Function toggle;
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      title: 'Chatting App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff145C9E),
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity
      ),
      initialRoute: ChatRoom.id,
      routes: {
        SignIn.id:(context)=>SignIn(),
        SignUp.id:(context)=>SignUp(),
        ChatRoom.id:(context)=>ChatRoom(),
        SearchScreen.id:(context)=>SearchScreen(),
        ConvoScreen.id:(context)=>ConvoScreen(),
      },
    );
  }
}

