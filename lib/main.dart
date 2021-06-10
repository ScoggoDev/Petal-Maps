import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:petal_maps/views/confirmation.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(MaterialApp(
  title: 'Your title',
  home: MainPage(),));}

class MainPage extends StatefulWidget{
  MyApp createState()=> MyApp();
}

class MyApp extends State<MainPage>{
final poiNameController = TextEditingController();
final poiAddressController = TextEditingController();
final poiLongController = TextEditingController();
final poiLatitudeController = TextEditingController();

@override
  Widget build(BuildContext context) {
    bool pressed = false;

    return MaterialApp(
      title: 'Petal Maps URUGUAY',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Row(
              children: [
                SizedBox(width: 20,),
                Container(child: Image(image: AssetImage("assets/logo.png"), width: 80, height: 40,)),
                SizedBox(width: 20,),
                Text("Ingreso de datos Petal Maps URUGUAY")
              ],
            ),
            SizedBox(height: 10,),
            Container(width:200, height:200,child: Image(image: AssetImage("assets/Maps.PNG")),),
            SizedBox(height: 10,),
            Container( 
              width: 200,
              child:TextField(
                controller: poiNameController,
                decoration: InputDecoration(
                labelText: 'Nombre de localización',
                border: OutlineInputBorder(
                borderSide: BorderSide(),
                  ),
                ),
              ) 
            ),
            SizedBox(height: 10,),
            Container( 
              width: 200,
              child:TextField(
                  controller: poiAddressController,
                  decoration: InputDecoration(
                  labelText: 'Dirección',
                  border: OutlineInputBorder(
                  borderSide: BorderSide(),
                  ),
                ),
              ) 
            ),
            SizedBox(height: 10,),
            Container( 
              width: 200,
              child:TextField(
                controller: poiLongController,
                decoration: InputDecoration(
                labelText: 'Longitud',
                border: OutlineInputBorder(
                borderSide: BorderSide(),
                  ),
                ),
              ) 
            ),
            SizedBox(height: 10,),
            Container( 
              width: 200,
              child:TextField(
                controller: poiLatitudeController,
                decoration: InputDecoration(
                labelText: 'Latitud',
                border: OutlineInputBorder(
                borderSide: BorderSide(),
                  ),
                ),
              ) 
            ),
            SizedBox(height: 10),
            Container(
                          height: 40,
                          width: 200,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                                side: BorderSide(width: 3,color: Colors.white)
                                )
                              ),
                              backgroundColor: MaterialStateProperty.all(Color(0xffff6f6a))
                            ),
                            onPressed: () {
                              if(poiNameController.text == "" || poiAddressController.text == "" || poiLongController.text == "" || poiLatitudeController.text == "") {
                                Fluttertoast.showToast(
                                  msg: "No ha introducido correctamente sus datos",
                                  toastLength: Toast.LENGTH_LONG,
                                  timeInSecForIosWeb: 4,
                                  webBgColor:	"#FF0000",
                                  webPosition: "center",
                                );
                              }
                              
                               else {
                                 savePoi(poiNameController.text, poiAddressController.text ,poiLongController.text ,poiLatitudeController.text);
                                {
                                setState(() {
                                  poiNameController.text='';
                                  poiAddressController.text='';
                                  poiLatitudeController.text='';
                                  poiLongController.text='';
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => ConfirmationView()));
                                  });
                                }
                               }
                              }, 
                            child: Text("INGRESAR", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),)
                          ),
                        ),
                        SizedBox(height: 10),
                      pressed ? Text(" Ha agregado correctamente su punto de interés ") : SizedBox(),

                      Expanded(
                        child: Align(
                          child: ClipPath(
                            child: Container(
                              color: Colors.blue,
                              height: 300,
                              ),
                            clipper: BottomWaveClipper(),
                            ),
                        alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }

  Future<void> savePoi(String poiName, String poiAddress, String poiLat, String poiLong) async {
  var now = new DateTime.now();
   FirebaseFirestore.instance.collection('POIs').doc(now.toString()).set(
   {
    'name': poiName, 'address': poiAddress, 'latitude': poiLat, 'longitud' : poiLong
   });

   return;
  }
}

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(0.0, size.height + 5);
    var secondControlPoint = Offset(size.width - (size.width / 6), size.height);
    var secondEndPoint = Offset(size.width, 0.0);
    path.quadraticBezierTo(secondControlPoint.dx, secondControlPoint.dy,
        secondEndPoint.dx, secondEndPoint.dy);

    return path;
  }

   @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}