class User {
  // late int id;
 late String id, name, barcode, cost, sell;

  User({
    required this.name,
    required this.barcode,
    required this.cost,
    required this.sell,
    required this.id,
  });
  User.Tow(String name, String barcode, String cost, String sell){
    this.name = name;
    this.barcode = barcode;
    this.cost = cost;
    this.sell = sell;
  }


}
