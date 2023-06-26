import 'package:firebase_auth/firebase_auth.dart';
import 'package:chat_app/modal/userr.dart';

class AuthMethods{
final FirebaseAuth _auth =FirebaseAuth.instance;
Userr? _userFromFirbaseUser(User user){
  return user!=null ? Userr(userId: user.uid) : null;
}

Future signInWithEmailAndPassword(String email, String password)async{
  try{
   UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
   User? firebaseUser=result.user;
   return _userFromFirbaseUser(firebaseUser!);
  }
      catch(e){
    print(e.toString());
      }
}
Future signUpWithEmailAndPassword(String email, String password)async{
  try{
    UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
    User? firebaseUser =result.user;
    return _userFromFirbaseUser(firebaseUser!);
  }
  catch(e){
    print(e.toString());
  }
}
Future resetPassword(String email) async {
  try{
    return await _auth.sendPasswordResetEmail(email: email);

}catch(e){
    print(e.toString());
  }
}


}