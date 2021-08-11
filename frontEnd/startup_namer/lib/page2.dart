import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Page2 extends StatelessWidget{
	//final String _text;
	//Page2(this._text);
	List<String> carsimages = [
		"assets/bus.png",
		"assets/coupe.jpg",
		"assets/hb.jpg",
		"assets/minibus.jpg",
		"assets/minicamion.jpg",
		"assets/minivan.jpg",
		"assets/pickup.jpg",
		"assets/sedan.jpg",
		"assets/station.jpg",
		"assets/suv.jpg",
		"assets/trailer.jpg",
		"assets/van.jpg",
	];

	@override
	Widget build(BuildContext context) => StaggeredGridView.countBuilder(
		staggeredTileBuilder: (index) => StaggeredTile.count(2,2),
		mainAxisSpacing: 8,
		crossAxisSpacing: 8,
		crossAxisCount: 6,
		itemCount: 12,
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
				child: Image(
					image: AssetImage(carsimages[index]),
				),
			),
		),
	);
}
