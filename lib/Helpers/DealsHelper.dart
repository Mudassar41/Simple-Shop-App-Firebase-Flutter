class DealsHelper{

  String image;
  String price;
  String productname;


  DealsHelper.fromMap(Map<String, dynamic> data) {
    image = data['image'];
    price = data['price'];
    productname = data['productname'];


  }
}