import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gmap_bluetoorh/screens/bluetooth_screen.dart';
import 'package:gmap_bluetoorh/screens/google_map_page.dart';
import 'package:gmap_bluetoorh/screens/map.dart';
import 'package:gmap_bluetoorh/service/geolocator_service.dart';
import 'package:gmap_bluetoorh/service/location_provider.dart';
import 'package:provider/provider.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  final geoService = GeoLocatorServices();
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (BuildContext futureContext) =>geoService.getInitialLocation(),
      child: Scaffold(
        body: Container(
          height: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300,
                height: 50,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: RaisedButton(onPressed: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => BluetoothScreen()),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.bluetooth,color: Colors.blue,),
                    Text("Check the Nearby devices",style: TextStyle(
                      color: Colors.blue
                    ),),
                  ],
                ),
                ),
              ),
              SizedBox(height: 50,),
              // MultiProvider(
              //   providers: [
              //     ChangeNotifierProvider(create: (context)=> LocationProvider(),child: GoogleMapPage(),),
              //   ],
              //   child: RaisedButton(onPressed: (){
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (context) => GoogleMapPage()),
              //     );
              //   },
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.center,
              //       children: [
              //         Icon(Icons.bluetooth,color: Colors.blue,),
              //         Text("Check the Nearby devices",style: TextStyle(
              //             color: Colors.blue
              //         ),),
              //       ],
              //     ),
              //   ),
              // ),
              RaisedButton(onPressed: (){
                Get.to(
                  Consumer<Position>(builder: (futureContext,position,widget){
                    return (position!=null)? Map(position):CircularProgressIndicator();
                  })
                );
              },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.map_sharp,color: Colors.blue,),
                    Text("Live Tracking",style: TextStyle(
                        color: Colors.blue
                    ),),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
