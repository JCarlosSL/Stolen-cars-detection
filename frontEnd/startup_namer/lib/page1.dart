import 'package:flutter/material.dart';
import 'package:startup_namer/map.dart';
import 'package:startup_namer/page2.dart';
import 'package:startup_namer/page3.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:dio/dio.dart';
//import 'package:startup_namer/dataModel.dart';

class MyForm extends StatefulWidget{
	String? posi;
	MyForm({this.posi});

	@override
	MyFormState createState(){
		return MyFormState(posi);
	}
}
class MyFormState extends State<MyForm>{
	String? posi;
	MyFormState(this.posi);
 
	final _formKey = GlobalKey<FormState>();
	//DataModel? _dataModel;
	TextEditingController dniController = TextEditingController();
	TextEditingController emailController = TextEditingController();
	TextEditingController placaController = TextEditingController();
	TextEditingController marcaController = TextEditingController();
	TextEditingController modeloController = TextEditingController();
	TextEditingController tipoController = TextEditingController();
	TextEditingController colorController = TextEditingController();
	TextEditingController posIniController = TextEditingController();
  // 'http://192.168.0.20:8000/register/'
  // 'https:jsonplaceholder.typicope.com/posts'
  postData(String? dni, String? email, String? placa, String? marca,String? modelo, String? tipo, String? color, String? position, String? timeA, String? timeB) async{
    final response2 = await http.post(
      Uri.parse('http://192.168.0.20:8000/register/'),
      body: {
				'dni': dni,//'dni',
		  	'email': email,//'email',
	  		'placa': placa,//'placa',
  			'marca': marca,//'marca',
			  'modelo': modelo,//'modelo',
		  	'tipo': tipo,//'tipo',
	  		'color': color,//'color',
  			'tEstimate1': position,//'tEstimate1',
			  'tEstimate2': timeA,//'tEstimate2',
			  'tEstimate3': timeB,//'tEstimate2',
 			}
		);

		print('Response status: ${response2.statusCode}');
    print('Response body: ${response2.body}');
  }

	validator(){
		if(_formKey.currentState != null && _formKey.currentState!.validate()){
			print("validated");
		} else {
			print("Not validated");
		}
	}
  Future<void> estimateGoogle(String? posicion1, String posicion2) async {
    var url = "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=' + posicion1 + '&destinations=' + posicion2 + '&key=AIzaSyBJTBcmFmqdOkTckS3K7LTxsxt7JfBS5p0";
	  print("***************  URL  *********************");
    print(url);
    Dio dio = new Dio();
    // 40.6655101,-73.89188969999998&destinations=40.6905615%2C,-73.9976592&key=AIzaSyBJTBcmFmqdOkTckS3K7LTxsxt7JfBS5p0");
		try {
	  	Response response = await dio.get(
			url,
			options: Options(headers: {"Content-Type":"application/json"}),
			);
			if (response.statusCode == 200){
	  		print("???????????  200  ?????????????????????");
	  		print(response.data);
			} else {
	  		print("###################  OK init  ###############");
				print('${response.statusCode} : ${response.data.toString()}');
	  		print("###################  OK  end  ###############");
				//throw response.statusCode;
				throw Exception("Connection Timeout Exception");
			}
		} catch (error){
	  	print("?????????erro?????????????????????????????");
			print(error);
	  	print("?????????erro?????????????????????????????");
		}
		//return response2.data;
  }

	List  timeEstimator(String? posicion){
    // Future<String> rpta =  
		print("posicionnnnnnnnnnn en la funcion estimator");
		print(posicion);
    estimateGoogle(posicion, "-16.4262687,-71.6729344");
    estimateGoogle(posicion, "-16.1898996,-71.6521665");
		// consultar a la api 
		// https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=40.6655101,-73.89188969999998&destinations=40.6905615%2C,-73.9976592&key=AIzaSyBJTBcmFmqdOkTckS3K7LTxsxt7JfBS5p0

		double time1 = 10;
		double time2 = 20;

		List<double> times = [0.0,0.0];
    times[0] = time1;
    times[1] = time2;
		
		return times;
	}
	

	List<String>? setTipo(String str){
		if (str == "auto"){
			return tipoAuto;
		} else {
			return tipoCamioneta;
		}
	}

	String tipoId = '';
	List<String>? tipoAuto = ["sedan","hatchback","coupe","station wagon"];
	//String tipoIdCamioneta = '';
	List<String>? tipoCamioneta = ["pickup","SUV"];
	//String tipoIdVan = '';
	List<String>? tipoVan = ["minivan","van"];
	//String tipoIdBus = '';
	List<String>? tipoBus = ["microbus","bus"];
	//String tipoIdCamion = '';
	List<String>? tipoCamion = ["trailer","mini camion"];
	String modelId = '';
	List<String>? modelo = ["auto","camioneta","van","bus","camion"];
	String colorId = '';
	List<String>? color = ["Rojo","Plateado","Blanco","Negro","Azul","Amarillo"];
	List<String>? tipo = [];

	@override
	Widget build(BuildContext context){
		return Form(
			key: _formKey,
			child: SingleChildScrollView(
        child: Column(
			  	crossAxisAlignment: CrossAxisAlignment.start,
			  	children: <Widget>[
			  		TextFormField(
							validator: (String? value){
								if (value == null || value.trim().length == 0){
									return 'Ingrese DNI';
								}
								return null;
							},
			  			decoration: const InputDecoration(
			  				icon: const Icon(Icons.person),
			  				hintText: 'DNI',
			  				labelText: 'DNI',
			  			),
						controller: dniController,
			  		),
			  		TextFormField(
							validator: (String? value){
								if (value == null || value.trim().length == 0){
									return 'Ingrese e-mail';
								}
	 							if (!RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$").hasMatch(value)){
									return 'Ingrese e-mail valido';
								}
								return null;
							},
			  			decoration: const InputDecoration(
			  				icon: const Icon(Icons.email),
			  				hintText: 'E-mail',
			  				labelText: 'Mail',
			  			),
						controller: emailController,
			  		),
			  		TextFormField(
							validator: (String? value){
								if (value == null || value.trim().length == 0){
									return 'Ingrese nro. placa';
								}
								return null;
							},
			  			decoration: const InputDecoration(
			  				icon: const Icon(Icons.phone),
			  				hintText: 'Ingresa Placa',
			  				labelText: 'Placa',
			  			),
						controller: placaController,
			  		),
			  		TextFormField(
							validator: (String? value){
								if (value == null || value.trim().length == 0){
									return 'Ingrese Marca';
								}
								return null;
							},
			  			decoration: const InputDecoration(
			  				icon: const Icon(Icons.directions_car_outlined),
			  				hintText: 'Marca del vehiculo',
			  				labelText: 'Marca',
			  			),
						controller: marcaController,
			  		),
			  		TextFormField(
							//enabled: false,
							/*validator: (String? value){
								if (value == null || value.trim().length == 0){
								 'Ubicar en el mapa';
								}
								return null;
							},*/
			  			decoration: const InputDecoration(
			  				icon: const Icon(Icons.location_on_outlined),
			  				hintText: 'Lugar del robo',
			  				labelText: 'Lugar',
			  			),
							controller: posIniController,
			  		),
			  		new Container(
			  			padding: const EdgeInsets.only(left: 40.0, top: 10.0,bottom:10.0),
			  			child: ElevatedButton(
			  				onPressed: ()async{
                  posi = await Navigator
			  					.push(
			  						context,
			  						MaterialPageRoute(
			  							builder: (context) => MapsSample()
			  						)
			  					);
			  				},
			  				child: Text('Ver Mapa'),
			  			),
			  		),

			  		DropDownField(
			  			onValueChanged: (dynamic value){
								setState((){
									tipo = setTipo(modeloController.text);
								});
			  				modelId = value;
								tipo = setTipo(modeloController.text);
			  			},
			  			value: modelId,
			  			required: false,
			  			icon: const Icon(Icons.directions_car),
			  			hintText: 'Elige un modelo',
			  			labelText: 'Modelo',
			  			items: modelo,
							controller: modeloController,
			  		),
			  		DropDownField(
			  			onValueChanged: (dynamic value){
								setState((){
									tipo = setTipo(modeloController.text);
								});
			  				tipoId = value;
			  			},
			  			value: tipoId,
			  			required: false,
			  			icon: const Icon(Icons.directions_car),
			  			hintText: 'Elige un tipo',
			  			labelText: 'Tipo',
			  			items: tipo, 
							controller: tipoController,
			  		),
            new Container(
			  			padding: const EdgeInsets.only(left: 40.0, top: 10.0,bottom:10.0),
			  			child: ElevatedButton(
			  				onPressed: (){
			  					Navigator
			  						.push(
			  							context,
			  							MaterialPageRoute(
			  								builder: (context) => Page2()
			  							)
			  						);
			  				},
			  				child: Text('Ver tipos'),
			  			),
			  		),
			  		DropDownField(
			  			onValueChanged: (dynamic value){
			  				colorId = value;
			  			},
			  			value: colorId,
			  			required: false,
			  			icon: const Icon(Icons.directions_car),
			  			hintText: 'Elige un color',
			  			labelText: 'Color',
			  			items: color,
						controller: colorController,
			  		),

			  		new Container(
			  			padding: const EdgeInsets.only(left: 150.0, top: 40.0),
			  			child: new ElevatedButton(
								//onPressed: postData, /* () async {
								onPressed: () async {
										
									validator();
									String dni = dniController.text;
									String email = emailController.text;
									String placa = placaController.text;
									String marca = marcaController.text;
									String modelo = modeloController.text;
									String tipo = tipoController.text;
									String color = colorController.text;
									String? position = posi;
									String timeA = timeEstimator(posi)[0].toString();
									String timeB = timeEstimator(posi)[1].toString();

                  postData(dni, email, placa, marca, modelo, tipo, color,position, timeA, timeB);

									//DataModel? data = await submitData(dni,email,placa,marca,modelo,tipo,color,tEstimate1,tEstimate2);
									//setState((){
									//	_dataModel = data;
									//});
									
									//////String cadena = timeEstimator("dsadas")[0].toString();
									
	  							print("**************************************");
									print("**********  posi  ********************");
									//print(cadena);
									print(posi);

									
									
			  					Navigator.push(
			  						context,
			  						MaterialPageRoute(
			  							builder: (context) => Page3()
			  						)
									);
								}, 
			  				child: const Text('Enviar'),
			  			),
			  		),
			  	],
			  ),
			),
		);
	}
}

