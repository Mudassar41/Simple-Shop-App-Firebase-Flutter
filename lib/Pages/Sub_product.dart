import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easybuy/Helpers/ProductHelper.dart';
import 'package:easybuy/Pages/DetailPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class Sub_product extends StatefulWidget {
final  String id;
final String Pname;

  const Sub_product({Key key, this.id, this.Pname}) : super(key: key);

  @override
  _Sub_productState createState() => _Sub_productState();
}

class _Sub_productState extends State<Sub_product> {
  int Rating=3;
  Future<List<ProductHelper>>  getFoods() async {
    QuerySnapshot snapshot = await Firestore.instance
        .collection('Products')
        .getDocuments();

    List<ProductHelper> _foodList = [];

    snapshot.documents.forEach((document) {
      ProductHelper food = ProductHelper.fromMap(document.data);
      if(document.data['category_id']==widget.id)

     { _foodList.add(food);}
      else
        print("no data found");

    });
    print(_foodList.length);
    return _foodList;

  }

@override
  void initState() {
    getFoods();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        actions: [

          IconButton(icon: Icon(Icons.search,color: Colors.white,),onPressed: (){},)

        ],
        title: Text(widget.Pname),

      ),

body: FutureBuilder(future: getFoods(),
builder: (context,snapshot){
  if(snapshot.hasData){


return snapshot.data.length!=0?   GridView.builder(
  itemCount: snapshot.data.length,
  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(childAspectRatio: 20/25, crossAxisCount: 2,),
  itemBuilder: (context, index) {
    return InkWell(
      onTap: (){




        Navigator.push(context, MaterialPageRoute(builder: (_)=>DetailPage(
       CID:snapshot.data[index].category_id,
          ID:snapshot.data[index].id,
      IMAGE:snapshot.data[index].image,
      PRICE:snapshot.data[index].price,
          NAME:snapshot.data[index].productname

        )));




      },
      splashColor: Colors.cyan,
      highlightColor: Colors.cyan.withOpacity(0.5),
      child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          child:
      Column( children: <Widget>[
        Container(
          height: 160,
          decoration: BoxDecoration(

        borderRadius: BorderRadius.only(bottomRight: Radius.circular(15),bottomLeft: Radius.circular(15)),
              image: DecorationImage(image: NetworkImage(snapshot.data[index].image),fit: BoxFit.cover)),),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(snapshot.data[index].productname.toUpperCase(),style: TextStyle(fontWeight: FontWeight.bold,),),
        ),
        Row(
         mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('\$${snapshot.data[index].price}',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.deepOrange)),
            Row(children: [


              for(int i=0;i<5;i++)

                Icon(Icons.star,  color: i<3?Colors.yellow:Colors.grey,size: 18,)


            ],)
          ],
        ),
      ],)
      ),
    );
  },
):Center(child: Column(

  children: [
        Icon(Icons.error_outline,color: Colors.cyan,size: 25,),
    Text("Sorry no Data found")
  ],
));
//    return GridView.count(
//childAspectRatio: 1/1.5,
//      crossAxisCount: 2,children: List.generate(snapshot.data.length, (index) =>
//
//       Card(
//         clipBehavior: Clip.antiAlias,
//         child: Column(children: [
//
//           Container(height: 150,decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(snapshot.data[index].image),fit: BoxFit.cover)),)
//
//         ],),
//       )),);


  }

  return Container(child: Center(child: CircularProgressIndicator(backgroundColor: Colors.red,)));
},),
    );
}
}
