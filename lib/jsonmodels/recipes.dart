class Recipe {
	int id;
	String name;
	String description;

	Recipe({this.id,this.name,this.description});


	toJsonEncodable(){
		Map<String,dynamic> m = Map();
		m['id']  = id;
		m['name']  = name;
		m['description']  = description;
		return m;
	}
}



class RecipeList {
	List<Recipe> items;
	RecipeList(){
		items  = List();
	}


	toJsonEncodable(){
		return items.map((item) {
			return item.toJsonEncodable();
		}).toList();
	}

	toList(List data){
		items  = List<Recipe>.from(
			(data as List).map((item) => Recipe(
				id : item['id'],
				name: item['name'],
				description: item['description']
			))
		);
	}
}