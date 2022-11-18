

class User {
  // late int id;
   String? name ,barcode,cost,sell,dose,mostSide,drugName,mechanism,pregnancy;
  User();
  User.map(dynamic opj){
    name=opj["Name"];
    barcode=opj["BarCode"];
    cost=opj["Cost"];
    sell=opj["Sell"];
    // this.id=opj["ID"];
    dose=opj["dose"];
    mostSide=opj['mostSide'];
    drugName=opj['drugName'];
    pregnancy=opj['pregnancy'];
  }
  Map< String , dynamic > map(){
    var map =  Map<String,dynamic>();
    map['Name'] = name;
    map['BarCode'] = barcode;
    map['Cost'] = cost;
    map['Sell'] = sell;
    map['dose'] = dose;
    map['mostSide'] = mostSide;
    map['drugName'] = drugName;
    map['pregnancy'] = pregnancy;

    return map;
  }


}
