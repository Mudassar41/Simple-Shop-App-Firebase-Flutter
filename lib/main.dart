
import 'package:device_preview/device_preview.dart';
import 'package:easybuy/Pages/NavigationDrawer.dart';
import 'package:easybuy/Providers/SqliteProvider.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Pages/AuthenticatioPage.dart';
import 'Providers/AuthProviders.dart';
import 'SizeConfig.dart';
void main() => runApp(
  DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => MultiProvider(providers: [

      ChangeNotifierProvider<AuthProvider>(

      create: (BuildContext context) {
        return AuthProvider();
      },
    ), ChangeNotifierProvider<SqliteProvider>(

        create: (BuildContext context) {
          return SqliteProvider();
        },
      )],child:
     MyApp(),


),
  ));

class MyApp extends StatelessWidget {
  AuthProvider authProvider;
  @override
  Widget build(BuildContext context) {
     authProvider = Provider.of<AuthProvider>(context);
    return LayoutBuilder(

      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SizeConfig().init(constraints, orientation);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Learning Platform Application',

              home: FutureBuilder<FirebaseUser>(
                  future: authProvider.getCurrentUser(),
                  builder: (context,AsyncSnapshot snapshot){
                    switch(snapshot.connectionState){
                      case ConnectionState.none:
                        return Center(child: Text("Check Your Connection State"),);
                        break;
                      case ConnectionState.waiting:
                      case ConnectionState.active:
                        return CircularProgressIndicator(valueColor: AlwaysStoppedAnimation(Colors.amber));
                        break;
                      case ConnectionState.done:
                      //  print("ID==>>>"+snapshot.data.uid);
                        return snapshot.hasData ?NavigationDrawer():AuthenticatioPage();
                        break;
                    }

                  }),);
          },
        );
      },
    );
  }
}


class progress extends StatefulWidget {
  @override
  _progressState createState() => _progressState();
}

class _progressState extends State<progress> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CupertinoActivityIndicator(),),
    );
  }
}


