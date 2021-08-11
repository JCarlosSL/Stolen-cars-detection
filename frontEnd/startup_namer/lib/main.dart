import 'package:flutter/material.dart';
import 'package:startup_namer/map.dart';
import 'package:startup_namer/page1.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Formulario para robo de autos',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
				appBar: AppBar(
					title: Text('Ingrese los datos del Vehiculo'),
				),
				body: MyForm(),
	  	),
    );
  }
}
/*
class MapScreen extends StatelessWidget{
	@override
	_MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen>{

	static const _initialCameraPosition = CameraPosition(
		target: LatLng(37.7732,-122.4329),
		zoom: 11.5,
	);

	GoogleMapController _googleMapController;
	@override
	void dispose(){
		_googleMapController.dispose();
		super.dispose();
	}

	@override
	Widget build(BuildContext context){
		return Scaffold(
			body: GoogleMap(
				myLocationButtonEnabled: false,
				zoomControlsEnabled: false,
				initialCameraPosition: _initialCameraPosition,
				onMapCreated: (controller) => _googleMapController = controller,
			),
			floatingActionButton: FloatingActionButton(
				backgroundColor: Theme.of(context).primaryColor,
				foregroundColor: Colors.black,
				onPressed: () => _googleMapController.animateCamera(
					CameraUpdate.newCameraPosition(_initialCameraPosition),
				),
				child: const Icon(Icons.center_focus_strong),
			),
		);
	}
}
*/
