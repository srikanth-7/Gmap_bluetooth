import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BluetoothScreen extends StatefulWidget {
  @override
  _BluetoothScreenState createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {

  FlutterBlue flutterBlueInstance  = FlutterBlue.instance;
  final List<BluetoothDevice> devicesList = new List<BluetoothDevice>();
  List<Container> containers = new List<Container>();
  bool visible= false;
  _addDeviceTolist(final BluetoothDevice device) {
    if (!devicesList.contains(device)) {
      setState(() {
        devicesList.add(device);
      });
    }
  }

  @override
  void initState() {
    flutterBlueInstance.connectedDevices
        .asStream()
        .listen((List<BluetoothDevice> devices) {
      for (BluetoothDevice device in devices) {
        devicesList.clear();
        _addDeviceTolist(device);
      }
    });
    flutterBlueInstance.scanResults.listen((List<ScanResult> results) {
      for (ScanResult result in results) {
        devicesList.clear();
        _addDeviceTolist(result.device);
      }
    });
    flutterBlueInstance.startScan();
    super.initState();
  }

  ListView _buildListViewOfDevices() {

    for (BluetoothDevice device in devicesList) {
      containers.add(
        Container(
          height: 50,
          child: Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  children: <Widget>[
                    Text(device.name == '' ? '(unknown device)' : device.name),
                    Text(device.id.toString()),
                  ],
                ),
              ),
              FlatButton(
                color: Colors.blue,
                child: Text(
                  'Connect',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
    }

    return ListView(
      padding: const EdgeInsets.all(8),
      children: <Widget>[
        ...containers,
      ],
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 100,),
          Container(
            margin: EdgeInsets.symmetric(vertical: 0,horizontal: 50),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("Scanning...",style: TextStyle(color: Colors.blue[200],fontSize: 10,fontWeight: FontWeight.w500),),
                SizedBox(width: 10,),
                Container(
                    width: 10.0,
                    height: 10.0,
                    child: (CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Colors.blue[200],
                      ),
                      strokeWidth: 2,
                    ))),
              ],
            ),
          ),
          Text("Available devices are:",style: TextStyle(color: Colors.blue,fontSize: 20,fontWeight: FontWeight.w500),),
          SizedBox(height: 30,),
          Expanded(
              flex: 5,
              child: _buildListViewOfDevices()),
        ],
      )
      // Column(
      //   children: [
      //     Expanded(
      //       flex: 1,
      //         child: RaisedButton(
      //       onPressed: (){
      //
      //         flutterBlueInstance.startScan();
      //         flutterBlueInstance.connectedDevices
      //             .asStream()
      //             .listen((List<BluetoothDevice> devices) {
      //           for (BluetoothDevice device in devices) {
      //             _addDeviceTolist(device);
      //           }
      //         });
      //         flutterBlueInstance.scanResults.listen((List<ScanResult> results) {
      //           for (ScanResult result in results) {
      //             _addDeviceTolist(result.device);
      //           }
      //         });
      //         // if(devicesList.isEmpty){
      //         //   setState(() {
      //         //     visible = false;
      //         //   });
      //         // }
      //         // else{
      //         //   print("device list is ${devicesList.length}");
      //         //   setState(() {
      //         //     visible = true;
      //         //   });
      //         // }
      //       },
      //           child: Text("Scan"),
      //     )),
      //     Expanded(
      //       flex: 7,
      //       child: ListView.builder(
      //           itemCount: devicesList.length,
      //           itemBuilder:(context,index){
      //             for (BluetoothDevice device in devicesList) {
      //               containers.add(
      //                 Container(
      //                   height: 50,
      //                   child: Row(
      //                     children: <Widget>[
      //                       Expanded(
      //                         child: Column(
      //                           children: <Widget>[
      //                             Text(device.name == '' ? '(unknown device)' : device.name),
      //                             Text(device.id.toString()),
      //                           ],
      //                         ),
      //                       ),
      //                       FlatButton(
      //                         color: Colors.blue,
      //                         child: Text(
      //                           'Connect',
      //                           style: TextStyle(color: Colors.white),
      //                         ),
      //                         onPressed: () {},
      //                       ),
      //                     ],
      //                   ),
      //                 ),
      //               );
      //             }
      //             return Column(
      //               children: [
      //                 ...containers
      //               ],
      //             );
      //           }),
      //     ),
      //   ],
      // ),
      // Container(
      //   margin: EdgeInsets.all(100),
      //   child: Center(
      //     child: Column(
      //       children: [
      //         RaisedButton(
      //           onPressed: (){
      //             setState(() {
      //               flutterBlueInstance.startScan();
      //               scanfordevices();
      //             });
      //           },
      //           child: Text("SCAN"),
      //         ),
      //         _buildListViewOfDevices(),
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
