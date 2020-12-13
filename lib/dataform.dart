import 'package:flutter/material.dart';

class DataForm extends StatefulWidget{
	_DataFormState createState() => _DataFormState();
}

class _DataFormState extends State<DataForm>{
	final _formKey  = GlobalKey<FormState>();
	final _recipeCtrl  = TextEditingController();
	final _descCtrl  = TextEditingController();



	@override
	dispose(){
		_recipeCtrl.dispose();
		_descCtrl.dispose();
		super.dispose();
	}

	@override
	initState(){
		super.initState();
		
			
	}

	_saveData(Map<String,dynamic> data){
		

	}
	Widget build(BuildContext context){
		return Scaffold(
			appBar : AppBar(
				title : Text('Add Data')
			),
			body: Form(
				key: _formKey,
				child: Column(
					children: [
						TextFormField(
							controller: _recipeCtrl,
							decoration: InputDecoration(
								labelText: "Recipe: "
							)
						),
						SizedBox(height:20),
						TextFormField(
							controller: _descCtrl,
							decoration: InputDecoration(
								labelText: "Description: "
							)
						),
						ElevatedButton(
							child: Text('Save'),
							onPressed: (){
								
								Map<String,dynamic> data  = {
									"id":  null,
									"recipe" : _recipeCtrl.text,
									"description" : _descCtrl.text
								};
								
								_saveData(data);

							}
						)
					]

				)

			)

		);
	}
}