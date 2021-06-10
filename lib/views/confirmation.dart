import 'package:flutter/material.dart';
import 'package:petal_maps/main.dart';

class ConfirmationView extends StatefulWidget {
  @override
  ConfirmationViewState createState() => ConfirmationViewState();
}

class ConfirmationViewState extends State<ConfirmationView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Image(image: AssetImage("assets/confirmation.png"), width: 150, height: 150)
          ),

          SizedBox(height: 30),

          Center(
            child: Text("Su punto de interés se ha cargado correctamente"),
          ),

          SizedBox(height: 30),


          Center(
            child: ElevatedButton(
                child: Text('Volver a inicio'),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                },
              ),
          ),
        ],
      ),
      
    );
  }
}