import 'package:easybuy/Helpers/Cart.dart';
import 'package:easybuy/Providers/SqliteProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class DetailPage extends StatefulWidget {
  final String CID;
  final String ID;
  final String IMAGE;
  final String NAME;
  final String PRICE;

  const DetailPage({Key key, this.CID, this.ID, this.IMAGE, this.NAME, this.PRICE}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  int qty=1;
  SqliteProvider sqliteProvider;
  @override

  Widget build(BuildContext context) {
    sqliteProvider = Provider.of<SqliteProvider>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text('Detail Page'),),
      body: (


          ListView(

            physics: BouncingScrollPhysics(),
            children: [


        Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 5,
          child: Column(
            children: <Widget>[
              Container(
                child:Image.network(widget.IMAGE,fit: BoxFit.cover,) ,
                width: MediaQuery.of(context).size.width,
                height: 250,
              ),
              Container(

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              color: Colors.deepOrange
                          ),

                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('\$${widget.PRICE}',style: TextStyle(fontSize: 18,color: Colors.white),),
                          )),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),

                              child: Row(
                                children: <Widget>[
//                                   for(int i=0;i<5;i++)
//                                   Icon(Icons.star_border,color: Colors.yellow,),
                                ],
                              ),
                            ))
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      Column(
          children: <Widget>[
            Container(
              child: Text(widget.NAME,style: TextStyle(color: Colors.cyan,fontSize: 24,fontWeight: FontWeight.bold),),
            ),
            Container(
                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.description,color: Colors.grey,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Description"),
                    )
                  ],
                )
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left:40,right: 40),
                child: Text("It is a long established fact that a reader will be "
                    "distracted by the readable content of a page when looking at its layout."
                    " The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, "
                    "as opposed to using 'Content here, content here', making it look like readable English. "
                    "Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, "
                    "and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various"
                    " versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour "
                    "and the like).",style: TextStyle(fontStyle: FontStyle.normal),),
              ),


            ),
            Divider(),
            Container(

                child: Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Icon(Icons.rate_review,color: Colors.grey,),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left:8.0),
                      child: Text("Reviews"),
                    )
                  ],
                )

            ),  Divider(),
            Container(


              child: Row(
                children: <Widget>[
                  Padding(
                      padding: EdgeInsets.only(left: 8),
                      child: Text("ADD QUANTITY",style: TextStyle(color: Colors.deepOrange,fontWeight: FontWeight.bold),)),

                  FlatButton(
                    onPressed: (){_increment();},
                    child: Icon(Icons.add,color: Colors.black54,size: 26,),
                  ),
                  Text(qty.toString()),

                  qty==1||qty==0?Container(): FlatButton(  onPressed: (){_decrement();},
                    child: Icon(Icons.remove,color: Colors.black,size: 26,),
                  )

                ],
              ),


            ),Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[

                  Container(

                    width: MediaQuery.of(context).size.width*.5,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FlatButton(onPressed: (){


                        int price1=int.parse(widget.PRICE);
                        print(price1);
                        print(qty);
                        print(widget.ID);

                        Cart cart=new Cart(widget.ID, widget.NAME, price1, qty);
                        sqliteProvider.Add_Or_Update(cart);




                      },
                        color: Colors.deepOrange,
                        child: Text("ADD TO CART"),
                      ),
                    ),

                  ),Container(     width: MediaQuery.of(context).size.width*.5,  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: FlatButton( color: Colors.cyan,
                      child: Text("BUY"),onPressed: (){},),
                  ),),

                ],

              ),


            )
          ],
        )


      ],)),
    );

  }
  _increment(){


    setState(() {

      qty++;

    });


  }
  _decrement(){

    setState(() {
      qty--;
    });

  }

}
