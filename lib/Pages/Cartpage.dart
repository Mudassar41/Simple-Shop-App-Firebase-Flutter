import 'package:easybuy/Helpers/Cart.dart';
import 'package:easybuy/Pages/OrderPage.dart';
import 'package:easybuy/Providers/SqliteProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>  with SingleTickerProviderStateMixin  {
SqliteProvider sqliteProvider;
  @override
  Widget build(BuildContext context) {
    sqliteProvider = Provider.of<SqliteProvider>(context);
    return Scaffold(

      body: FutureBuilder(
       
        builder: (context,snapshot){

          if(snapshot.hasData){
            return ListView.builder(
              physics: ScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: snapshot.data.length, itemBuilder: (context,index){
              return Container(
                height: 180,
                child: Card(
                  elevation: 5,
                  clipBehavior: Clip.antiAlias,
                  child: Column(
                    children: <Widget>[
                      Row(

                        children: <Widget>[
                          Expanded(flex: 1,
                            child: Container(
                                child:Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 100,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          fit: BoxFit.fill,
                                          image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTUFdEZevbrl0jl6M7hLzM_YCkzk-BJVixIT5qumNgwlgCruktB&usqp=CAU")
                                      ),
                                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                                      color: Colors.redAccent,
                                    ),),
                                )
                            ),
                          ),  Expanded(flex: 1,
                            child: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top:18.0),
                                    child: Text('Product Name',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                  ),Padding(
                                    padding: const EdgeInsets.only(top:5.0),
                                    child: Text(snapshot.data[index].p_name,style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal),),
                                  ), Padding(
                                    padding: const EdgeInsets.only(top:5.0),
                                    child: Text('Product Price',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                  ),Padding(
                                    padding: const EdgeInsets.only(top:5.0),
                                    child: Text('\$${snapshot.data[index].p_price}',style: TextStyle(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.blue),),
                                  ),

                                ],),

                            ),

                          ),  Expanded(flex: 1,

                            child: Container(color: Colors.white,

                              child: Column(children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(top:0.0),

                                  child: Text('Product Quantity',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                                )
                                , Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    IconButton(
                                      onPressed: (){
                                        Cart cart=snapshot.data[index];

                                        int quantity=cart.p_quantity;

                                        String id=cart.p_id;
                                        print("this is>>>>>>>> $id");
                                        String name=cart.p_name;
                                        int price=cart.p_price;
                                        quantity++;
                                      sqliteProvider.updateCart(Cart(id,name,price,quantity));},
                                      icon: Icon(Icons.add),
                                    ),
                                    Text('${snapshot.data[index].p_quantity}'),

                                    IconButton(
                                      onPressed: (){
                                        Cart cart=snapshot.data[index];
                                        int quantity=cart.p_quantity;
                                        String id=cart.p_id;
                                        String name=cart.p_name;
                                        int price=cart.p_price;
                                        if(quantity>1){
                                          quantity--;}
                                        sqliteProvider.updateCart(Cart(id,name,price,quantity));
                                        },
                                      icon: Icon(Icons.remove)
                                      //            ),IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: (){

                                      //

                                      //

                                      //              Cart cart=ItemAddNotifier.list[index];

                                      //              int id=cart.p_id;

                                      //              databasehelper.deleteDog(id);

                                      //

                                      //

                                      //            },),

                                      //            Text('${ItemAddNotifier.list[index].p_price*ItemAddNotifier.list[index].p_quantity}'),

                                      //            Text('${ItemAddNotifier.list.length}')

                                        ),],

                                ),
                              ],),),

                          )
                        ],
                      ),
                      Row(children: <Widget>[
                        Expanded(flex: 1,child: Container(
                          child:   Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Product Total Price',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),),
                              ),Text('\$${snapshot.data[index].p_quantity*snapshot.data[index].p_price}')
                            ],
                          ),
                        ),),  Expanded(flex: 1,child: Container( child:   Column(
                          children: <Widget>[
                            IconButton(icon: Icon(Icons.delete,color: Colors.red,),onPressed: (){


                              Cart cart=snapshot.data[index];
                              String id=cart.p_id;
                              sqliteProvider.DeleteCart(id);


                            },),
                          ],
                        ),),)

                      ],)
                    ],
                  ),
                ),
              );},);}

          return Container(
              padding: EdgeInsets.only(top: 20),
              child: Center(child: CupertinoActivityIndicator()));


        },
      ),
      bottomNavigationBar: new Container(
        color: Colors.white,
        child: Row(
          children: <Widget>[
            FutureBuilder(
              future: sqliteProvider.getcartTotal(),
builder:(context,snapshot){
                if(snapshot.hasData){


                 return Expanded(
                child: ListTile(title: Text("Total"),
                  subtitle: Text('${snapshot.data}'),),
              );

                }
                return Container(
                    padding: EdgeInsets.only(top: 20),
                    child: Center(child: CupertinoActivityIndicator()));
} ,
//              child: Expanded(
//                child: ListTile(title: Text("Total"),
//                  subtitle: Text("\$320"),),
//              ),
            ),Expanded(
              child: MaterialButton(onPressed: (){


                Navigator.push(context, MaterialPageRoute(builder: (_)=>OrderPage(


                )));
              },
                child: Text("Proceed to Next",style: TextStyle(color: Colors.white),),color: Colors.cyan,),
              // child: Text("Checkout"),
            )

          ],
        ),


      ),
    );
  }
}
