import 'package:flutter/material.dart';
import 'package:scanner_qr_barcode/ShowInformation.dart';
import 'package:scanner_qr_barcode/Utils/DataBaseHelper.dart';




class  Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class  _HomeState extends State<Home> {
  bool isLoading = true;
  // User user = User();
  DataBaseHelper db = DataBaseHelper.dataBaseHelper;

  @override
  void initState(){
    readData();
    super.initState();
  }

  List users = [];
  Future readData() async {
    List<Map> response =await db.readData("SELECT * FROM Ahmed");
    users.addAll(response);
    isLoading = false;
    if(mounted){
      setState((){});
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 35.0,
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 150, 0, 72),
        title: const Text(
          'Scanner',
        ),
        leading:  IconButton(
          onPressed: () {},
          icon: const Icon(
            Icons.menu,
            size: 32.0,
          ),
        ),
        actions:  [
          IconButton(
              onPressed: () {
                //
                // Navigator.of(context).push(MaterialPageRoute(
                //     builder: (context) => const QRViewExample())

              } ,
              icon: const Icon(
                Icons.camera_alt_outlined,
                size: 28.0,

              )),
          IconButton(
              onPressed: () {} ,
              icon: const Icon(
                Icons.search,
                size: 28.0,
              )),
        ],
      ),
      floatingActionButton:  FloatingActionButton(
        onPressed: () async {
            Navigator.of(context).pushNamed("AddData");
        } ,
        tooltip: 'Add',
        backgroundColor: const  Color.fromARGB(255, 150, 0, 72),
        child: const Icon(
          Icons.add,
          color: Colors.white
          ,size: 32.0,),
      ),
      body:
      isLoading ==true?
          const Center(child: Text('Loading ... ',style: TextStyle(fontSize: 16.0,color: Colors.red),),)
      :Center(
             child: ListView(children:  [
            ListView.builder(
                     itemCount: users.length,
                      physics: const NeverScrollableScrollPhysics(),
                       shrinkWrap: true,
                       itemBuilder: (context,i){
                         return Card(
                             borderOnForeground: true,
                             child: ListTile(
                               // leading:  const IconButton( onPressed:()  {
                               //   print('Ali');
                               //
                               // }, icon: Icon(Icons.edit),),
                               onTap: (){
                                 Navigator.of(context).push(

                                 MaterialPageRoute(builder: (context) => ShowInformation(
                                   name: users[i]['Name'],
                                   barcode: users[i]['Barcode'],
                                   cost: users[i]['Cost'],
                                   sell: users[i]['Sell'],
                                   id: "${users[i]['ID']}",
                                 )));
                               },
                               title:Text("${users[i]['Name']}\n${users[i]["Cost"]}"
                                 ,
                               ) ,
                              //  subtitle: Text('${users[i]['Sell']}'),
                               subtitle: Text(
                                 " ${users[i]['Sell']}",
                                 style: const TextStyle(color: Colors.black),
                                //  style: const TextStyle(color: Colors.black),

                                 ),
                             ),
                            shape:
                            Border.all(
                         // color: ,
                                color:
                                const Color.fromARGB(255, 150, 0, 72)),
                           shadowColor: const Color.fromARGB(255, 150, 0, 72),
                             elevation: 4.0
                             ,
                           );
                   }),

         ],),
        ),
      );
  }
}
