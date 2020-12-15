import 'package:flutter/material.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:async';
import 'jsonmodels/recipes.dart';
class RecipeForm extends StatefulWidget{
	_RecipeFormState createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm>{
	final _formKey  = GlobalKey<FormState>();
	final _recipeCtrl  = TextEditingController();
	final _descCtrl  = TextEditingController();
	final RecipeList _recipes  = RecipeList();
	final LocalStorage _storage  = LocalStorage('recipedemo');

	@override
	dispose(){
		_recipeCtrl.dispose();
		_descCtrl.dispose();
		super.dispose();
	}

	@override
	initState(){
		super.initState();
		_loadData();
	
	}

	_loadData() async{
		await _storage.ready;
		//_storage.clear();
		if(_storage.getItem('recipes') == null){
			_storage.setItem('recipes',_recipes.toJsonEncodable());
		}
		else{
			_recipes.toList(_storage.getItem('recipes'));
		}

	}

	Widget build(BuildContext context){
		return Scaffold(
			appBar : AppBar(
				title : Text('Add Recipe')
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
							onPressed: () async{
								await _storage.ready;
								int len,id;
								
								len  = _recipes.items.length;

								if(len > 0){
									id = _recipes.items[len - 1].id + 1;
								}
								else{
									id = 1;
								}
								Recipe data  = Recipe(id:id,name:_recipeCtrl.text,description:_descCtrl.text);
								_recipes.items.add(data);
								_storage.setItem('recipes',_recipes.toJsonEncodable());
								Navigator.pop(context,true);
							}
						)
					]

				)

			)

		);
	}
}