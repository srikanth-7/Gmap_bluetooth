import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class MapController extends GetxController{
  var permission = false.obs;

  @override
  void onInit() async{
    getPremission();
    super.onInit();
  }

  Future<bool> getPremission()async{
    var geoLocator = Geolocator();
    var enabled = await geoLocator.isLocationServiceEnabled();
    print("status is $enabled");
    print("premission is ${enabled}");
    if(enabled){
    return permission.value = true;}
    else{
      return permission.value = false;
    }
  }
}