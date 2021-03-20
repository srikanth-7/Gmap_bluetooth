import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:gmap_bluetoorh/controller/map_controller.dart';
import 'package:gmap_bluetoorh/screens/bluetooth_screen.dart';
import 'package:gmap_bluetoorh/service/geolocator_service.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';



class Map extends StatefulWidget {

  final Position initialPosition;


  Map(this.initialPosition);

  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {

  final GeoLocatorServices geoServices = GeoLocatorServices();
  MapController mapController;
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    // TODO: implement initState
    mapController =Get.put(MapController());
    geoServices.getCurrentLocation().listen((position) {
      centerScreen(position);
    });
    super.initState();
  }

  Future<Widget> getPermissions()async{
    var geoLocator = Geolocator();
    var status = await geoLocator.isLocationServiceEnabled();
    print("status is $status");

    // if()
    // if (status == GeolocationStatus.denied){
    //   return Text("Permission denied");
    // }
    // // Take user to permission settings
    // else if (status == GeolocationStatus.disabled){
    //   return Text("Permission disabled");
    // }
    // // Take user to location page
    // else if (status == GeolocationStatus.restricted){
    //   return Text("Permission restricted");
    // }
    // // Restricted
    // else if (status == GeolocationStatus.unknown){
    //   return Text("Permission unknown");
    // }
    // // Unknown
    // else if (status == GeolocationStatus.granted){
    //   return StreamBuilder<Position>(
    //     stream: geoServices.getCurrentLocation(),
    //     builder: (context,snapshot){
    //       if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
    //       return Center(
    //         child: Text("lat: ${snapshot.data.latitude.toString()}, long:${snapshot.data.longitude}"),
    //       );
    //     },);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              SizedBox(height: 25,),
              Text("Your Current Location",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 25),),
              Obx((){
                if(mapController.permission.value){
                  return Expanded(
                    flex:8,
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 40,horizontal: 10),
                      child: GoogleMap(
                        initialCameraPosition:CameraPosition(
                          target: LatLng(widget.initialPosition.latitude,widget.initialPosition.longitude),
                          zoom: 18.0,
                        ) ,
                        mapType: MapType.satellite,
                        myLocationButtonEnabled: true,
                        myLocationEnabled: true,
                        onMapCreated: (GoogleMapController controller){
                          _controller.complete(controller);
                        },
                      ),
                    ),
                  );
                }else{
                  return Expanded(
                    flex:8,
                    child: Center(
                      child: Text("Please enable the Location"),
                    ),
                  );
                }
              }),
              SizedBox(height: 20,),
              Expanded(
                flex: 1,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 20),
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
              ),
            ],
          ),
        ),
      ),
      // Obx((){
      //   if(mapController.permission.value){
      //     return StreamBuilder<Position>(
      //             stream: geoServices.getCurrentLocation(),
      //             builder: (context,snapshot){
      //               if(!snapshot.hasData) return Center(child: CircularProgressIndicator(),);
      //               return Center(
      //                 child: Text("lat: ${snapshot.data.latitude.toString()}, long:${snapshot.data.longitude}"),
      //               );
      //             },);
      //   }else{
      //     return Text("please enable the location");
      //   }
      // })

      // FutureBuilder<Widget>(
      //     future: getPermissions(),
      //     builder: (BuildContext context, AsyncSnapshot<Widget> snapshot){
      //       if(snapshot.hasData)
      //         return snapshot.data;
      //       return Container(child: CircularProgressIndicator());
      //     }
      // ),
    );
  }
  Future<void> centerScreen(Position position)async{
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(position.latitude,position.longitude),zoom: 18)));
  }
}
