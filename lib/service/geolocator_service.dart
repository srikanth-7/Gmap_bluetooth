import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

class GeoLocatorServices{
  final Geolocator geolocator = Geolocator();

  //stream
  Stream<Position> getCurrentLocation(){
    var locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 10);
    return geolocator.getPositionStream(locationOptions);
  }

  Future<Position> getInitialLocation()async{
    return geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }
}