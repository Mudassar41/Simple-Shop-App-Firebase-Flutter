import 'package:easybuy/Helpers/Cart.dart';
import 'package:easybuy/Helpers/OrderHelper.dart';
import 'package:easybuy/Providers/SqliteProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderPage extends StatefulWidget {
  @override
  _OrderPageState createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  int selectedRadio;
OrderHelper _orderHelper=OrderHelper();
SqliteProvider _sqliteProvider;
  @override
  void initState() {
    super.initState();
    selectedRadio = 0;
  }

// Changes the selected value on 'onChanged' click on each radio button
  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }
  @override
  Widget build(BuildContext context) {
    _sqliteProvider = Provider.of<SqliteProvider>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.cyan,
        title: Text("Checkout"),),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Products ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
              Icon(Icons.shopping_cart,color: Colors.deepOrange,)
            ],
          ),
        ),

FutureBuilder(
  future: _sqliteProvider.GetData(),
  builder: (context,snapshot){
    if(snapshot.hasData){
      return  ListView.builder(

        physics: ScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context,index){

        return Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 5,
            child: Container(height: 80,child: Row(
mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcTUFdEZevbrl0jl6M7hLzM_YCkzk-BJVixIT5qumNgwlgCruktB&usqp=CAU',height: 80,fit: BoxFit.fill,width: 100,)
            ,  Text(snapshot.data[index].p_name.toUpperCase()),Text('Qty : ${snapshot.data[index].p_quantity}'),
                Padding(
                  padding: const EdgeInsets.only(right: 5),
                  child: Text('\$${snapshot.data[index].p_quantity*snapshot.data[index].p_price}'),
                )

            ],),),
          ),
        );


      },itemCount: snapshot.data.length,);


    }
    return Container(
        padding: EdgeInsets.only(top: 20),
        child: Center(child: CupertinoActivityIndicator()));


  },


),
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 5,
            child: Column(children: [


              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Shipping ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                    Icon(Icons.location_on,color: Colors.deepOrange,)
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Form(key: _formKey,child: Column(children: [

                  buildUsername(),
                  buildphone(),
                  buildCity(),buildDistrict(),
                  buildAdress(),
SizedBox(height: 40,)],),
                ),
              )
            ],),
          ),

        )
,


        Padding(
          padding: const EdgeInsets.all(2.0),
          child: Card(
            elevation: 5,
            child: Column(children: [
              Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Payment ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.black),),
                Icon(Icons.payment,color: Colors.deepOrange,)
              ],
            ),
          ),ButtonBar(
                alignment: MainAxisAlignment.center,
                children: <Widget>[
                  Radio(
                    value: 1,
                    groupValue: selectedRadio,
                    activeColor: Colors.green,
                    onChanged: (val) {
                      print("Radio $val");
                      setSelectedRadio(val);
                    },
                  ),
                  Text("Cash on Deliver"),
                  Radio(
                    value: 2,
                    groupValue: selectedRadio,
                    activeColor: Colors.blue,
                    onChanged: (val) {
                      print("Radio $val");
                      setSelectedRadio(val);
                    },
                  ),
                  Text("Pay Online"),
                ],
              )
              ,],),),
        ),Padding(
          padding: const EdgeInsets.only(left: 50,right: 50,top: 20,bottom: 20),
          child: RaisedButton(onPressed: (){

            SubmitOrder();

          },child: Text("Submit Now",style: TextStyle(color: Colors.white),),color: Colors.deepOrange,),
        )


      ],),
    );
  }

  Widget buildUsername(){
    return Padding(
      padding: const EdgeInsets.all(5.0),

      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                //fillColor: Colors.green

                labelText: 'Enter Name',
                prefixIcon: Icon(Icons.person,color: Colors.cyan,)),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Name  Required';
              }
              return null;
            },
            onSaved: (String value) {
                 _orderHelper.Name = value;
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
  Widget buildphone(){
    return Padding(
      padding: const EdgeInsets.all(5.0),

      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                //fillColor: Colors.green

                labelText: 'Enter Phone no',

                prefixIcon: Icon(Icons.call,color: Colors.cyan,)),
            keyboardType: TextInputType.phone,
            validator: (String value) {
              if (value.isEmpty) {
                return 'phone  Required';
              }
              return null;
            },
            onSaved: (String value) {
              _orderHelper.Phoneno=value;
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
  Widget buildAdress(){
    return Padding(
      padding: const EdgeInsets.all(5.0),

      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                //fillColor: Colors.green

                labelText: 'Enter Full Adress',
                prefixIcon: Icon(Icons.directions,color: Colors.cyan,)),
            validator: (String value) {
              if (value.isEmpty) {
                return 'Name  Required';
              }
              return null;
            },
            onSaved: (String value) {
       _orderHelper.Adress=value;
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
  Widget buildCity(){
    return Padding(
      padding: const EdgeInsets.all(5.0),

      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                //fillColor: Colors.green

                labelText: 'Enter City',
                prefixIcon: Icon(Icons.location_city,color: Colors.cyan,)),
            validator: (String value) {
              if (value.isEmpty) {
                return 'City  Required';
              }
              return null;
            },
            onSaved: (String value) {
              _orderHelper.Cityname=value;
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
  Widget buildDistrict(){
    return Padding(
      padding: const EdgeInsets.all(5.0),

      child: Column(
        children: [
          TextFormField(
            decoration: InputDecoration(
                border: InputBorder.none,
                //fillColor: Colors.green

                labelText: 'Enter District',
                prefixIcon: Icon(Icons.disc_full,color: Colors.cyan,)),
            validator: (String value) {
              if (value.isEmpty) {
                return 'District  Required';
              }
              return null;
            },
            onSaved: (String value) {
              _orderHelper.Districtname=value;
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

  Future<void> SubmitOrder() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    else{
      _formKey.currentState.save();

    List<Cart> list= await _sqliteProvider.GetData();
    print(list.length);

    for(int i=0;i<list.length;i++){
      DateTime now = new DateTime.now();
      DateTime date = new DateTime(now.year, now.month, now.day);
      String DATE='${date.year}/${date.month}/${date.day}';
      print(DATE);
      print('${i+1}'+_orderHelper.Name);
      print('${i+1}'+_orderHelper.Phoneno);
      print('${i+1}'+_orderHelper.Cityname);
      print('${i+1}'+_orderHelper.Districtname);
      print('${i+1}'+_orderHelper.Adress);
      Cart cart=list[i];
      print('${i+1}'+"ID:"+cart.p_id);
      print('${i+1}'+"NAME:"+cart.p_name);
      print('${i+1}'+"Qty:"+'${cart.p_quantity}');
      print('${i+1}'+"Unit Price:"+'${cart.p_price}');
      print('${i+1}'+"Total Price:"+'${cart.p_price*cart.p_quantity}');


    }












    }







  }
}
