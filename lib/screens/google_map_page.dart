import 'package:flutter/material.dart';
import 'package:gmap_bluetoorh/service/location_provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
class GoogleMapPage extends StatefulWidget {
  @override
  _GoogleMapPageState createState() => _GoogleMapPageState();
}

class _GoogleMapPageState extends State<GoogleMapPage> {

  @override
  void initState() {
    // TODO: implement initState
    Provider.of<LocationProvider>(context,
    listen:false,
    ).initilization();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:googleMapUi(),
    );
  }

  Widget googleMapUi(){
    return Consumer<LocationProvider>(
      builder: (consumerContext,model,child){
        if(model.locationPosition!=null){
          return Column(
            children: [
              Expanded(
                child: GoogleMap(
                  mapType: MapType.satellite,
                  initialCameraPosition: CameraPosition(
                      target: model.locationPosition,
                      zoom: 18
                  ),
                  myLocationEnabled: true,
                  myLocationButtonEnabled: true,
                  onMapCreated: (GoogleMapController controller){
                  },
                ),
              )
            ],
          );
        }
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
