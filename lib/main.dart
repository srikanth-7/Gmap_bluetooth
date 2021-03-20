import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:provider/provider.dart';
import 'screens/map.dart';
import 'service/geolocator_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  final geoService = GeoLocatorServices();
  @override
  Widget build(BuildContext context) {
    return
    //   GetMaterialApp(
    //   home: HomePage(),
    // );
      FutureProvider(
      create: (BuildContext context1)=> geoService.getInitialLocation(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          backgroundColor: Colors.white,
          body: Consumer<Position>(
            builder: (context1,position,widget){
              return (position!=null)?
              Map(position):
              Center(child:Center(
                child: Text("Please enable the Location"),
              )
              );
            },
          ),
        ),
      ),
    );
  }
}
