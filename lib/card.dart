import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bluetooth_app/controllers/print_page.dart';
import 'package:flutter_bluetooth_app/views/device_show.dart';
import 'package:flutter_bluetooth_app/views/login_page.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_bluetooth_app/views/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CardDesign extends StatefulWidget {
  const CardDesign({Key? key}) : super(key: key);

  @override
  State<CardDesign> createState() => _CardDesignState();
}

class _CardDesignState extends State<CardDesign> {
  List cardList = [];
  List itemGridList = [];
  int min = 1;
  int max = 100000;
  int randomNumber = 0;

  var vehiclenumber = 45 - 6626;
  var vehicleclass;
  var ammount;
  var lane;
  var user;

  TextStyle textS() {
    return TextStyle(
      color: Color(0xFF000000),
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }
  TextStyle textStyle() {
    return TextStyle(
      color: Color(0xFF000000),
      fontSize: 25,
      fontWeight: FontWeight.bold,
    );
  }

  var response;
  var jsonData;
  var pass;
  var headers_cookie;
  Future addVehicle() async {

    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    user = sharedPreferences.getString('username');
    pass = sharedPreferences.getString('password');
    headers_cookie = sharedPreferences.getString("headers");

    response = await https
        .post(Uri.parse("http://103.101.197.249:8080/tollapi/api/toll"),headers: {
          "Cookie":headers_cookie.toString(),
    },
        body: {
      "pass_id":randomNumber.toString(),
      "registration_number": vehiclenumber.toString(),
      "amount": ammount.toString(),
      "lan": lane.toString(),
      "user_name": user.toString(),
      "vehicle_class": vehicleclass.toString(),
    });
    jsonData = json.decode(response.body);
    print("gjhsdgsdhgh---$jsonData");
    print("Header---:$headers_cookie");
  }

  Future<void> logout() async {
    return showDialog(context: (context), builder: (context){
      return AlertDialog(

        title: Text("Are you sure you want to LogOut?"),
        actions: [
          TextButton(onPressed: (){
            Navigator.pop(context);
          }, child: Text("No"),
          ),
          TextButton(onPressed: () async{
            await Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>LoginScreen()));
          }, child: Text("Yes"),
          ),
        ],
      );

    });
  }

  Widget items(text, image) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      child: Container(
        height: MediaQuery.of(context).size.height * 0.13,
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(image),
              fit: BoxFit.fill,
            ),
            gradient: LinearGradient(
                colors: [Colors.grey.shade900, Colors.grey.shade900])),
      ),
    );
  }

  void motorcycle() {
    print('ticket');

    print("Vehicle Class:-$vehicleclass");

    print("Vehicle Number:-$vehiclenumber");

    print("Pass ID:-$randomNumber");

    print('Lane Number-$lane');

    print("Ammount:-$ammount TK");

    print("NAME:--- $user");
  }

  postData() {}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (_)=>PrintPage()));
          },
        ),
        actions: [
          IconButton(onPressed: (){
            setState(() {
              logout();
            });
          }, icon: Icon(Icons.logout_sharp)),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/backg.jpg"),
            fit: BoxFit.fill,
          ),
        ),
        child: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        SizedBox(
                            height: size.height * 0.1,
                            width: size.width*0.1,
                            child: Image.asset(
                              "assets/logo.png",
                            )),
                        Text("Regnum ETC Toll",style: TextStyle(
                          fontSize: 40,
                        ),),
                      ],
                    ),
                    Container(
                      height: 2,width: double.infinity,color: Colors.white70,
                    ),
                    SizedBox(height: 8,),
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Select Vehicle Class',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            InkWell(
                              child: items(
                                'Mototrcycle',
                                'assets/motor_cycle2.png',
                              ),
                              onTap: () {
                                setState(() {
                                  lane = 1;
                                  ammount = 20;
                                  vehicleclass = 'motor_cycle';
                                  vehiclenumber;
                                  randomNumber =
                                      Random().nextInt(max - min) + min;
                                });
                                addVehicle();
                              },
                            ),
                            Text(
                              "MotorCycle",
                              style: textS(),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            GestureDetector(
                              child: items(
                                'Rickshaw',
                                'assets/rickshaw_van.png',
                              ),
                              onTap: () {
                                setState(() {
                                  lane = 1;
                                  ammount = 10;
                                  vehicleclass = 'rickshaw_van';
                                  vehiclenumber;
                                  randomNumber =
                                      Random().nextInt(max - min) + min;
                                });
                                addVehicle();
                              },
                            ),
                            Text(
                              "Rickshaw",
                              style: textS(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              child: items(
                                '3/4 Wheeler',
                                'assets/three_four_wheeler.png',
                              ),
                              onTap: () {
                                setState(() {
                                  lane = 1;
                                  ammount = 15;
                                  vehicleclass = 'three_four_wheeler';
                                  vehiclenumber;
                                  randomNumber = Random().nextInt(max - min) + min;
                                });
                                addVehicle();
                              },
                            ),
                            Text(
                              "3/4 Wheeler",
                              style: textS(),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.values[4],
                      children: [
                        Text("Vehicle No",),
                        Container(
                          margin: const EdgeInsets.all(15.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)
                          ),
                          height: size.height*0.05,width: size.width*0.6,
                          child: Text('$vehiclenumber'),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.values[5],
                      children: [
                        Text("AVC Class",),
                        Container(
                          margin: const EdgeInsets.all(25.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)
                          ),
                          height: size.height*0.05,width: size.width*0.6,
                          child: Center(
                            child: Builder(
                              builder: (context){
                                var avc=vehicleclass;
                                if(avc=="three_four_wheeler"){
                                  return Text("3/4 Wheeler",style: textStyle());
                                }else if(avc=="rickshaw_van"){
                                  return Text("Rickshaw",style: textStyle(),);
                                }else if(avc=='motor_cycle'){
                                  return Text("Motorcycle",style: textStyle(),);
                                }else{
                                  return Text("avc");
                                }

                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.values[5],
                      children: [
                        const Text("Ticket ID",style: TextStyle(),),
                        Container(
                          margin: const EdgeInsets.all(25.0),
                          padding: const EdgeInsets.all(3.0),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blueAccent)
                          ),
                          height: size.height*0.05,width: size.width*0.6,
                          child: Center(child: Text("$randomNumber",style: textStyle(),)),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
