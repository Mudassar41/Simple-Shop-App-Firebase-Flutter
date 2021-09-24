import 'package:easybuy/Helpers/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class AuthProvider with ChangeNotifier{

FirebaseAuth firebaseAuth=FirebaseAuth.instance;

Future<FirebaseUser> getCurrentUser() async{
  return firebaseAuth.currentUser();

}

Future<String> signIn(User user) async{
  String response="";
  try{
    AuthResult authResult=await FirebaseAuth.instance.signInWithEmailAndPassword(email: user.email, password: user.password);
    if(authResult!=null){
            response="Login Success ! ";
      notifyListeners();
    }
  }catch(error){
    response=error.toString();
  }
  return response;
}
Future<String> signUp(User user) async{
  String response="";
  try{
    AuthResult authResult=await FirebaseAuth.instance.createUserWithEmailAndPassword(email: user.email, password: user.password);
    if(authResult!=null){
      response="Account Created Successfully.";
      notifyListeners();
    }
  }catch(error){
    response="Account not Created Successfully";
  }
  return response;
}

// SIGNOUT USER

  Future<void> signOutUser() async{
    await FirebaseAuth.instance.signOut();
    notifyListeners();
  }


}