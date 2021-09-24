class ProductHelper{

  String category_id;
  String id;
  String image;
  String price;
  String productname;
  ProductHelper.fromMap(Map<String, dynamic> data) {
    category_id = data['category_id'];
    id = data['id'];
    image = data['image'];
    price = data['price'];
    productname = data['productname'];


  }



}