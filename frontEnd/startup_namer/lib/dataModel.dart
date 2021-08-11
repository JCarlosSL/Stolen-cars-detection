import 'dart:convert';
DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));
String dataModelToJson(DataModel data) => json.encode(data.toJson());


 class DataModel{
	DataModel({
		this.dni,
		this.email,
		this.placa,
		this.marca,
		this.modelo,
		this.tipo,
		this.color,
		this.tEstimate1,
		this.tEstimate2,
	});
	
	String? dni;
	String? email;
	String? placa;
	String? marca;
	String? modelo;
	String? tipo;
	String? color;
	String? tEstimate1;
	String? tEstimate2;

	factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
		dni: json["dni"],
		email: json["email"],
		placa: json["placa"],
		marca: json["marca"],
		modelo: json["modelo"],
		tipo: json["tipo"],
		color: json["color"],
		tEstimate1: json["tEstimate1"],
		tEstimate2: json["tEstimate2"],
	);
	
	Map<String, dynamic> toJson() => {
		"dni": dni,
		"email": email,
		"placa": placa,
		"marca": marca,
		"modelo": modelo,
		"tipo": tipo,
		"color": color,
		"tEstimate1": tEstimate1,
		"tEstimate2": tEstimate2,
	};

 }

