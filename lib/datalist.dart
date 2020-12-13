import 'package:flutter/material.dart';
import 'dataform.dart';

class DataList extends StatefulWidget{

	_DataListState createState() => _DataListState();
}

class _DataListState extends State<DataList>{

	Widget build(BuildContext context){
		return Scaffold(
			appBar: AppBar(
				title : Text('Data List')
			),
			body:Center(
				child : Text('Data List')
			),
			floatingActionButton: FloatingActionButton(
				child : Icon(Icons.add),
				onPressed: (){
					Navigator.push(
						context,
						MaterialPageRoute(builder:(context) => DataForm())
					);
				}
			)
		);
	}
}