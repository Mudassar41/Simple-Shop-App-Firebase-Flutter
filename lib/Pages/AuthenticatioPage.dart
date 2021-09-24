
import 'package:easybuy/Helpers/User.dart';

import 'package:easybuy/Pages/NavigationDrawer.dart';
import 'package:easybuy/Providers/AuthProviders.dart';
import 'package:easybuy/SizeConfig.dart';
import 'package:easybuy/Style/TEXT.dart';
import 'package:easybuy/images.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
enum AuthMode{Login,Register}
class AuthenticatioPage extends StatefulWidget {
  @override
  _AuthenticatioPageState createState() => _AuthenticatioPageState();
}

class _AuthenticatioPageState extends State<AuthenticatioPage>   {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AuthMode _authMode = AuthMode.Login;
  User _user = User();
  bool value=true;
  bool _isHidden=true;
  AuthProvider authProvider;
  initState() {
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
     authProvider = Provider.of<AuthProvider>(context, listen: false);
    return Scaffold(
backgroundColor: Color(0xFFFFffffff),
      body:
   ListView(
          children: [
            AppLogo(),
            Container(child: Form(key:
            _formKey,
              child:
              Column(children: [
              _authMode==AuthMode.Register?  buildUsername():Container(),
                buildEmail(),
                buildPassword()
              ],),)),buildText(),
            buildButton(),
//
          ],),
    );}

 Widget AppLogo(){
 return  Center(
   child: Container(
     child: Image.asset('images/logo.JPG',height: 25*SizeConfig.imageSizeMultiplier,width: MediaQuery.of(context).size.width,
),
   ),
 );}
 Widget buildUsername(){
    return Padding(
      padding: const EdgeInsets.all(5.0),

        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                //fillColor: Colors.green

                  labelText: 'Enter Username',
                  prefixIcon: Icon(Icons.person,color: Colors.blue,)),
              validator: (String value) {
                if (value.isEmpty) {
                  return 'Name  Required';
                }
                return null;
              },
              onSaved: (String value) {
                //   _user.displayName = value;
              },
            ), Container(
              margin: EdgeInsets.only(left: 5,right: 5),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey,width: 1.0),
                ),
              ),)
          ],
        ),
      );

 }
 Widget buildEmail(){
return  Padding(
  padding: const EdgeInsets.all(5.0),

    child: Column(
      children: [
        TextFormField(

          decoration: InputDecoration(
              border: InputBorder.none,
              labelText: 'Enter Email',
              prefixIcon: Icon(Icons.mail,color: Colors.blue,)),
          validator: (String value) {
            if (value.isEmpty) {
              return 'Email is Required';
            }

            if (!RegExp(
                r"[aA-zZ0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
              return 'Please enter a valid email Address';
            }

            return null;
          },
          onSaved: (String value) {
            _user.email = value;
          },
        ), Container(
          margin: EdgeInsets.only(left: 5,right: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey,width: 1.0),
            ),
          ),)
      ],
    ),

);
 }
 Widget buildPassword(){
return   Padding(
  padding: const EdgeInsets.all(5.0),

    child: Column(
      children: [
        Row(
          children: [
            Expanded(
              flex: 3,
              child: TextFormField(
                obscureText:_isHidden?true:false,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock,color: Colors.blue,),),
                keyboardType: TextInputType.visiblePassword,
                validator: (String value) {
                  if (value.isEmpty) {
                    return 'Password is Required';
                  }

                  return null;
                },
                onSaved: (String value) {
                  _user.password = value;
                },
              ),
            ),Expanded(
              flex: 1,
              child: FlatButton(

                  onPressed: (){

                    setvalue();
                  },
                  child: _isHidden?Icon(Icons.visibility_off):Icon(Icons.visibility)),
            )
          ],
        ), Container(
          margin: EdgeInsets.only(left: 5,right: 5),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey,width: 1.0),
            ),
          ),)
      ],
    ),


);
 }
 Widget buildText(){
    return  Padding(
   padding: const EdgeInsets.all(10.0),
   child: Row(
     mainAxisAlignment: MainAxisAlignment.spaceAround,
     children: [
       TEXT(title:_authMode==AuthMode.Register? 'Already Have Account ? ':'New User ? ',fontsize: 2.5,fontWeight: FontWeight.bold,color: Colors.black54,), InkWell(
           onTap: (){setState(() {
             _authMode = _authMode == AuthMode.Login ? AuthMode.Register : AuthMode.Login;
           });},
           child: TEXT(title: _authMode==AuthMode.Register?'Sign In ':'Sign Up',fontsize: 2.5,fontWeight: FontWeight.bold,color: Colors.blue,)),
     ],
   ),
 );}
 Widget buildButton(){
    return Padding(
      padding:  EdgeInsets.only(left: 10*SizeConfig.widthMultiplier,right: 10*SizeConfig.widthMultiplier,top: 5*SizeConfig.widthMultiplier),
      child: RaisedButton(child: Text(_authMode==AuthMode.Register?'Sign Up':'Sign In',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),onPressed: (){_submitForm();






      },shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),


      ),color: Colors.blue,),
    );
 }  void _submitForm() async{
    if (!_formKey.currentState.validate()) {
      return;
    }

    _formKey.currentState.save();

print(_user.email);

    if (_authMode == AuthMode.Login) {

      String message= await authProvider.signIn(_user);
      print(message);


    } else {
      String message= await authProvider.signUp(_user);
      print(message);
    }
  }
 void setvalue(){
    setState(() {
      _isHidden=!_isHidden;
    });

  }

}
