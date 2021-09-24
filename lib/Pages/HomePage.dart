import 'dart:convert';


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easybuy/Helpers/DealsHelper.dart';
import 'package:easybuy/Helpers/Slider_helper.dart';
import 'package:easybuy/SizeConfig.dart';


import 'package:easybuy/Style/TEXT.dart';

import 'package:flutter/cupertino.dart';

import "package:http/http.dart" as http;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';


import '../my_flutter_app_icons.dart';
import 'Sub_product.dart';
class Home extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<Home>{
  final List<String> imgList = [
    'https://i.pinimg.com/originals/a7/69/8c/a7698c9f07092370dda12af24b7a09b3.jpg',
    'https://www.whatmobile.com.pk/control/news/assets/14052020/acb558c92643c60ac3ab8d4c31b5ba4b.jpg',
    'https://cdn.bestworkoutsupplementsblog.com/wp-content/uploads/2013/03/Official-best-pre-workouts-2019.jpg',
  ];
 int _current = 0;
 double h1;
 Future<List<Slider_helper>> _data;
 Future<List<Slider_helper>>  getFoods() async {
   QuerySnapshot snapshot = await Firestore.instance
       .collection('Food')
       .getDocuments();

   List<Slider_helper> _foodList = [];

   snapshot.documents.forEach((document) {
     Slider_helper food = Slider_helper.fromMap(document.data);
     _foodList.add(food);
   });
   return _foodList;

 }
  Future<List<DealsHelper>>  getDeals() async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Deals')
        .getDocuments();

    List<DealsHelper> _foodList = [];

    snapshot.documents.forEach((document) {
      DealsHelper food = DealsHelper.fromMap(document.data);

      _foodList.add(food);
    });
    print(_foodList);
    return _foodList;

  }


  Future<List<DealsHelper>>  getCategory() async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Food')
        .getDocuments();

    List<DealsHelper> _foodList = [];

    snapshot.documents.forEach((document) {
      DealsHelper food = DealsHelper.fromMap(document.data);
      print(document.data['id']);
      _foodList.add(food);
    });
    print(_foodList);
    return _foodList;

  }
  @override
  void initState() {
    // TODO: implement initState
print("initsate>>>>>");
getDeals();
    super.initState();

  }


 @override
 Widget build(BuildContext context) {



    return Scaffold(
      body:ListView(
        physics:  BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        children: [

          Padding(
          padding: const EdgeInsets.only(top: 0),
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(

                autoPlay: true,enlargeCenterPage: true,onPageChanged: (index,reason){setState(() {
                                 _current=index;
                               });},),
              items: imgList.map((item) => Container(
                child: Center(
                    child: Container(
                      height: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            image: DecorationImage(
                            image: NetworkImage(item,),fit: BoxFit.cover)),
                           child: Container(
                                        // width: MediaQuery.of(context).size.width,
                                         decoration: BoxDecoration(
                                             borderRadius: BorderRadius.all(Radius.circular(10)),
                                             gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                                               0.1,
                                               0.9
                                             ], colors: [
                                               Colors.black.withOpacity(.5),
                                               Colors.black.withOpacity(.1)
                                             ])),))
                ),
              )).toList(),

            ), Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children:imgList.map<Widget>((url) {
                             int index = imgList.indexOf(url);
                             return Container(
                               width: 8.0,
                               height: 8.0,
                               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                               decoration: BoxDecoration(
                                 shape: BoxShape.circle,
                                 color: _current == index
                                     ? Colors.cyan
                                     : Colors.deepOrange,
                               ),
                             );
                           }).toList(),
                         ),
                       ],
                   ),



//          child: FutureBuilder(
//              future:getFoods(),
//              builder: ( context, snapshot) {
//                if (snapshot.hasData) {
//                  return Stack(
//                   children: [
//                     Column(
//                       children: [
//                            CarouselSlider(
//                             options: CarouselOptions(
//                               height: 25*SizeConfig.imageSizeMultiplier,
//                               onPageChanged: (index,reason){setState(() {
//                                 _current=index;
//                               });},
//                               viewportFraction: 1.0,
//                               autoPlay: true,
//                               enlargeCenterPage: false,
//                             ),items: snapshot.data.map<Widget>((i)
//
//
//
//                           {
//                             return Builder(
//                               builder: (BuildContext context) {
//                                 return Container(
//                                   margin: EdgeInsets.symmetric(horizontal: 1.0),
//                                   decoration: BoxDecoration(
//                                       //borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(40)),
//
//
//                                       image: DecorationImage(
//                                           fit: BoxFit.fitWidth,
//                                           image: NetworkImage(i.image)
//                                       ),
//
//                                       color: Colors.amber
//                                   ),
//                                   child:   Container(
//                                    // width: MediaQuery.of(context).size.width,
//                                     decoration: BoxDecoration(
//                                       //  borderRadius: BorderRadius.only(bottomRight: Radius.circular(30),bottomLeft: Radius.circular(40)),
//                                         gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
//                                           0.1,
//                                           0.9
//                                         ], colors: [
//                                           Colors.black.withOpacity(.5),
//                                           Colors.black.withOpacity(.1)
//                                         ])),
//                                   ),
//                                 );
//                               },
//                             );
//
//
//
//
//                           }
//
//
//                           ).toList(),
//                           ),
//
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: snapshot.data.map<Widget>((url) {
//                             int index = snapshot.data.indexOf(url);
//                             return Container(
//                               width: 8.0,
//                               height: 8.0,
//                               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: _current == index
//                                     ? Colors.cyan
//                                     : Colors.deepOrange,
//                               ),
//                             );
//                           }).toList(),
//                         ),
//                       ],
//                   ),
//                   Positioned(
//top: 3,
//                       child: RotatedBox(
//                         quarterTurns: 3,
//                         child: Text("Explore What you want",style: TextStyle(color: Colors.white54,fontWeight: FontWeight.bold),),))
//                   ,Align(
//
//                          alignment: Alignment.topRight,
//
//                         child: Container(
//                           height: 6*SizeConfig.imageSizeMultiplier,
//                           width: 80,
//                           decoration: BoxDecoration(
//                               color: Colors.white54,
//                              // borderRadius: BorderRadius.circular(50),
//                               image: DecorationImage(image: NetworkImage('https://i.pinimg.com/originals/01/af/d9/01afd9a6781e4654a85deeec3a40d220.png'),fit: BoxFit.cover)
//),
//                         )
//
//                   )],
//                  );}
//                return Container(child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)));
//
//              }),


        ),
          Align(
              alignment:Alignment.center,child: TEXT(title: 'Exclusive Deals',fontsize: 3,fontWeight: FontWeight.bold,color: Colors.cyan,)),
          FutureBuilder(
  future: getDeals(),
  builder: (context,snapshot){
    if(snapshot.hasData){

      return  Container(
        height: 150,


        child: ListView.builder(

            itemBuilder: (context,index){
return Card(
elevation: 5,
  clipBehavior: Clip.antiAlias,
  child: Column(children: [
Container(

  height: 100,
  width: 120,
  decoration: BoxDecoration(
    color: Colors.blue,

      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
      image: DecorationImage(image: NetworkImage(snapshot.data[index].image),fit: BoxFit.cover))),
  Text(snapshot.data[index].productname,style: TextStyle(fontSize: 16),),
    Row(

      children: [
        Text('\$${80}',style: TextStyle(fontSize: 16,color: Colors.grey,decoration: TextDecoration.lineThrough),),
        SizedBox(width: 10,),
        Text('\$${snapshot.data[index].price}',style: TextStyle(fontSize: 16,color: Colors.deepOrange),),


      ],
    )


],),);
          },itemCount: snapshot.data.length,scrollDirection: Axis.horizontal,),
      );





    }


    return Container(child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)));

  },
),
          Padding(
  padding: const EdgeInsets.all(8.0),
  child:   Align(alignment:Alignment.center,child: TEXT(title: 'Populor Categories',fontsize: 3,fontWeight: FontWeight.bold,color: Colors.cyan,)),
),
          FutureBuilder(
              future: getFoods(),
              builder: (context,  snapshot) {
                if (snapshot.hasData) {

                  return GridView.count(
                   childAspectRatio: 8.0/9.0,
                    physics: ScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 4,
                    children: List.generate(snapshot.data.length, (index) =>
                        Container(

                          height: 100,
                          width: 100,
                          child: InkWell(
                            highlightColor: Colors.grey,
                            onTap: (){

                              Navigator.push(context, MaterialPageRoute(builder: (_)=>Sub_product(
id:snapshot.data[index].id,
                                  Pname:snapshot.data[index].category

                              )));



                            },
                            child: Card(
                              elevation: 5,
                              clipBehavior: Clip.antiAlias,
                              child: Column(
                                children: [
                                  Container(

                                height: SizeConfig.heightMultiplier>6.8?85:60,
                                     width: 100,
                                     decoration: BoxDecoration(
                                         borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                         image: DecorationImage(image: NetworkImage(snapshot.data[index].image),fit: BoxFit.cover)),
                                    child: Container(decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),
                                     gradient: LinearGradient(begin: Alignment.bottomRight, stops: [
                                             0.1,
                                             0.9
                                           ], colors: [
                                             Colors.black.withOpacity(.5),
                                             Colors.black.withOpacity(.1)
                                           ]
                                    ),),
                                    //  child: Image.network(snapshot.data[index].image,width: 100,height: 60,fit: BoxFit.cover,)),
                                    )),Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Text(snapshot.data[index].category,style: TextStyle(fontWeight: FontWeight.bold),overflow: TextOverflow.ellipsis),
                                    ) ],
                              ),

//                            clipBehavior: Clip.antiAlias,
//                            child: Column(children: [
//                            Container(
//                              height: 60,
//                              width: 100,
//                              decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(snapshot.data[index].image))),),
//                            Text(snapshot.data[index].category)
//                          ],
//                    ),),
                        ),
                          ))
                    ));}
                return Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(child: CupertinoActivityIndicator()));}),





        ],)

    );
  }



}

