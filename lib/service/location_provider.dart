import 'package:flutter/cupertino.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider with ChangeNotifier{
  Location _location;
  Location get location => _location;
  LatLng _locationPosition;
  LatLng get locationPosition =>_locationPosition;

  bool locationService = true;

  LocationProvider(){
    _location = new Location();
  }


  initilization()async{
    await getUserLocation();
  }

  getUserLocation()async{
    bool serviceEnabled;
    PermissionStatus _permission;
    serviceEnabled = await location.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled = await location.serviceEnabled();

    }
    if(!serviceEnabled){
      return;
    }
    _permission = await location.hasPermission();
    if(_permission == PermissionStatus.denied){
      _permission = await location.requestPermission();
      if(_permission != PermissionStatus.granted){
        return;
      }
    }
    location.onLocationChanged.listen((LocationData currentLocation) {
      _locationPosition = LatLng(currentLocation.latitude, currentLocation.longitude);
      print("location is $_locationPosition");
      notifyListeners();
    });
  }


}