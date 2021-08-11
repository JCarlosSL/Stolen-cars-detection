import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Page3 extends StatelessWidget{
	//final String _text;
	//Page2(this._text);

	/*	
  Future<void> callJson() async {
    var url = 'http://192.168.0.20:8000/detail/20';
    print(url);
    Dio dio = new Dio();
		try {
	  	Response response = await dio.get(
			url,
			options: Options(headers: {"Content-Type":"application/json"}),
			);
			if (response.statusCode == 200){
	  		print(response.data);
			} else {
				print('${response.statusCode} : ${response.data.toString()}');
				//throw response.statusCode;
				throw Exception("Connection Timeout Exception");
			}
		} catch (error){
			print(error);
		}
		//return response2.data;
  }
	*/
	List<String> carsimages = [
		"1.jpeg",
		"2.jpeg",
		"3.jpeg",
		"4.jpeg",
		"5.jpeg",
		"6.jpeg",
	];
	

	@override
	Widget build(BuildContext context) => StaggeredGridView.countBuilder(
		staggeredTileBuilder: (index) => StaggeredTile.count(2,2),
		mainAxisSpacing: 8,
		crossAxisSpacing: 8,
		crossAxisCount: 2,
		itemCount: 6,
		itemBuilder: (context, index) => buildImageCard(index),
	);

	Widget buildImageCard(int index) => Card(
		margin: EdgeInsets.zero,
		shape: RoundedRectangleBorder(
			borderRadius: BorderRadius.circular(8),
		),
		child: Container(
			margin: EdgeInsets.all(8),
			child: ClipRRect(
				borderRadius: BorderRadius.circular(8),
				child: Image.network(
				'http://192.168.0.20:8000/yolo/imagen/${carsimages[index]}',
					fit: BoxFit.cover,
				),
			),
		),
	);
}
