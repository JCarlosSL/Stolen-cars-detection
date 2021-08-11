import 'dart:async';

import 'package:flutter/material.dart';
import 'package:startup_namer/page1.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsSample extends StatefulWidget {
  @override
  _MapsSampleState createState() => _MapsSampleState();
}

class _MapsSampleState extends State<MapsSample> {
	String? posi = "-16.3987526,-71.5377566";
  //final double _zoom = 100;
  List<Marker> myMarker = [];

  CameraPosition _initialPosition =
      CameraPosition(target: LatLng(-16.3987526, -71.5377566), zoom: 10.0);
  MapType _defaultMapType = MapType.normal;
  Completer<GoogleMapController> _controller = Completer();

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _handleTap(LatLng tappedPoint){
	print(tappedPoint);
		setState((){
			myMarker = [];
			myMarker.add(
				Marker(
					markerId: MarkerId(tappedPoint.toString()),
					position: tappedPoint,
					draggable: true,
					icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
					onDragEnd: (dragEndPosition){
						print(dragEndPosition);
						posi = dragEndPosition.toString();
					}
				)
			);
		});
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
			/*
      appBar: AppBar(
        title: Text('Maps in Flutter'),
        centerTitle: true,
      ),
			*/
      //drawer: _drawer(),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            markers: Set.from(myMarker),
						onTap: _handleTap,
            mapType: _defaultMapType,
            myLocationEnabled: true,
            onMapCreated: _onMapCreated,
            initialCameraPosition: _initialPosition,
          ),
          Container(
            margin: EdgeInsets.only(top: 80, right: 10),
            alignment: Alignment.topRight,
            child: Column(
              children: <Widget>[
                FloatingActionButton(
                    child: Icon(Icons.layers),
                    elevation: 5,
                    backgroundColor: Colors.teal[200],
                    onPressed: () {
                      _changeMapType();
                      print('Changing the Map Type');
                    }),
              ],
            ),
          ),
			  	Container(
            margin: EdgeInsets.only(top: 150, right: 10),
            alignment: Alignment.topRight,
			  		//padding: const EdgeInsets.only(left: 40.0, top: 10.0,bottom:10.0),
			  		child: ElevatedButton.icon(
			  			icon: Icon(Icons.save_outlined),
							label: Text(''),
			  			onPressed: (){
			  				Navigator
			  					.pop(context, posi);
			  						//context,
			  						//MaterialPageRoute(
			  						//	builder: (context) => MyForm(posi:posi),
			  						//)
			  					//);
			  			},
			  			//child: Text('Guardar posicion'),
			  		),
			  	),
        ],
      ),
    );
  }
/*
  Widget _drawer() {
    return Drawer(
      elevation: 16.0,
      child: Column(
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text("xyz"),
            accountEmail: Text("xyz@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("xyz"),
            ),
            otherAccountsPictures: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.white,
                child: Text("abc"),
              )
            ],
          ),
          ListTile(
            title: new Text("Places"),
            leading: new Icon(Icons.flight),
          ),
          Divider(),
          ListTile(
            onTap: () {
              _goToNewYork();
              Navigator.of(context).pop();
            },
            title: new Text("New York"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              _goToNewDelhi();
              Navigator.of(context).pop();
            },
            title: new Text("New Delhi"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              _goToLondon();
              Navigator.of(context).pop();
            },
            title: new Text("London"),
            trailing: new Icon(Icons.arrow_forward_ios),
          ),
          ListTile(
            onTap: () {
              _goToParis();
              Navigator.of(context).pop();
            },
            title: new Text("Paris"),
            trailing: new Icon(Icons.arrow_forward_ios),
          )
        ],
      ),
    );
  }

  Future<void> _goToNewYork() async {
    double lat = 40.7128;
    double long = -74.0060;
    GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('newyork'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'New York', snippet: 'Welcome to New York')),
      );
    });
  }

  Future<void> _goToNewDelhi() async {
    double lat = 28.644800;
    double long = 77.216721;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('newdelhi'),
            position: LatLng(lat, long),
            infoWindow: InfoWindow(
                title: 'New Delhi', snippet: 'Welcome to New Delhi')),
      );
    });
  }

  Future<void> _goToLondon() async {
    double lat = 51.5074;
    double long = -0.1278;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('london'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'London', snippet: 'Welcome to London')),
      );
    });
  }


  Future<void> _goToParis() async {
    double lat = 48.8566;
    double long = 2.3522;
    final GoogleMapController controller = await _controller.future;
    controller
        .animateCamera(CameraUpdate.newLatLngZoom(LatLng(lat, long), _zoom));
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
            markerId: MarkerId('paris'),
            position: LatLng(lat, long),
            infoWindow:
                InfoWindow(title: 'Paris', snippet: 'Welcome to Paris')),
      );
    });
  }
*/
}
