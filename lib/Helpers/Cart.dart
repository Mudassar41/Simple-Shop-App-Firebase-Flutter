class Cart{

  String p_id;
  String p_name;
  int p_price;
  int p_quantity;


  Cart(this.p_id, this.p_name, this.p_price, this.p_quantity);

  Map<String, dynamic> toMap() {
    return {
      'p_id': p_id,
      'p_name': p_name,
      'p_price': p_price,
      'p_quantity':p_quantity,

    };
  }


}