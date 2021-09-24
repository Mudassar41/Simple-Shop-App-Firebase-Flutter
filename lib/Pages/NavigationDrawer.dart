
import 'package:badges/badges.dart';
import 'package:easybuy/Providers/AuthProviders.dart';
import 'package:easybuy/Providers/SqliteProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'AccountPage.dart';
import 'Cartpage.dart';
import 'HomePage.dart';
class NavigationDrawer extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Fragment 2", Icons.local_pizza),
    new DrawerItem("Cart", Icons.shopping_cart)
  ];

  @override
  State<StatefulWidget> createState() {
    return new HomePageState();
  }
}

class HomePageState extends State<NavigationDrawer> with TickerProviderStateMixin {
  int _selectedDrawerIndex = 0;
AuthProvider authProvider;
SqliteProvider sqliteProvider;
List<Widget> childrens=[Home(),AccountPage(),CartPage()];
  _getDrawerItemWidget(int pos) {
    switch (pos) {
      case 0:
        return  Home();
      case 1:
        return  AccountPage();
      case 2:
        return  CartPage();

      default:
        return new Text("Error");
    }
  }
  @override
  Widget build(BuildContext context) {
    sqliteProvider=Provider.of<SqliteProvider>(context);
    authProvider = Provider.of<AuthProvider>(context, listen: false);


    return  Scaffold(
      appBar:  AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,color: Colors.white,),onPressed: (){
           // authProvider.signOutUser();
          },),
 FutureBuilder(
   future: sqliteProvider.getiteminCart(),
   builder: (context,snapshot){

     if(snapshot.hasData){

       return Badge(
         position: BadgePosition.topLeft(),
         badgeColor: Colors.red,


         badgeContent: snapshot.data==0?Text('0'):Text('${snapshot.data}'),
         child: IconButton(icon: Icon(Icons.shopping_cart),onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (_)=>CartPage(


           )));
         },),
       );
     }
     return Container(
         padding: EdgeInsets.only(top: 20),
         child: Center(child: CupertinoActivityIndicator()));


   },

 )
        ],
        backgroundColor: Colors.cyan[600],
        title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
      ),
      drawer: new Drawer(
        child: Container(
          color: Colors.white,
          child: new Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                ),
              ),
              Expanded(
                child: new ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context,index){

                    return ListTile(
                      leading: new Icon(widget.drawerItems[index].icon,color: _selectedDrawerIndex==index?Colors.cyan[600]:Colors.grey,),
                      title: new Text(widget.drawerItems[index].title,style: TextStyle(fontWeight:_selectedDrawerIndex==index?FontWeight.bold:FontWeight.normal ,color: _selectedDrawerIndex==index?Colors.cyan[600]:Colors.grey),),
                      onTap: () {
                      Navigator.pop(context);
                        setState(() {
                          _selectedDrawerIndex=index;
                        });},);
                  },itemCount: widget.drawerItems.length,),
              )
            ],
          ),
        ),
      ),
      body: IndexedStack(index: _selectedDrawerIndex,
        children:childrens
      ),

      //_getDrawerItemWidget(_selectedDrawerIndex),
    );
  }
}
class DrawerItem {
  String title;
  IconData icon;
  DrawerItem(this.title, this.icon);
}
