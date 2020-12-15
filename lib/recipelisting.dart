import 'package:flutter/material.dart';
import 'recipeform.dart';
import 'package:localstorage/localstorage.dart';
import 'dart:async';
import 'jsonmodels/recipes.dart';


class RecipeListing extends StatefulWidget{

	_RecipeListState createState() => _RecipeListState();
}

class _RecipeListState extends State<RecipeListing>{
	final GlobalKey<ScaffoldState> _scaffoldKey  = GlobalKey<ScaffoldState>();
	final RecipeList _recipes  = RecipeList();
	final LocalStorage _storage  = LocalStorage('recipedemo');


	Widget build(BuildContext context){
		return Scaffold(
			key: _scaffoldKey,
			appBar: AppBar(
				title : Text('Recipes')
			),
			body:FutureBuilder(
				future: _storage.ready,
				builder:(context,snapshot){
					if(snapshot.data == null){
						return Center(
			                child: CircularProgressIndicator(),
			            );
					}
					var items  = _storage.getItem('recipes');
					if(items != null){
						_recipes.toList(items);
						if(_recipes.items.length > 0){
							return ListView.builder(
								itemCount: _recipes.items.length,
								itemBuilder: (context,index){
									var recipe  = _recipes.items[index];
									return Card(
										child: ListTile(
											title: Text('${recipe.name}'),
											trailing: IconButton(
												icon: Icon(Icons.delete),
												onPressed:(){
													_recipes.items.removeWhere((e) => e.id == recipe.id);
													_storage.setItem('recipes',_recipes.toJsonEncodable());
													_scaffoldKey.currentState.showSnackBar(SnackBar(
														content : Text('Recipe deleted!')
													));
													setState((){});
												}
											)

										)
									);
								}
							);

						}
					}

				}

			),
			floatingActionButton: FloatingActionButton(
				child : Icon(Icons.add),
				onPressed: () async {
					var res  = await Navigator.push(
						context,
						MaterialPageRoute(builder:(context) => RecipeForm())
					);

					if(res == true){
						_scaffoldKey.currentState.showSnackBar(SnackBar(
							content : Text('Recipe added!')
						));

						setState((){

						});
					}
				}
			)
		);
	}
}