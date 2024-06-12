import 'package:flutter/material.dart';
import 'package:planet_saver/Models/Product.dart';

class CustomSearchDelegeta extends SearchDelegate{
  final List<Product> list;

  CustomSearchDelegeta({super.searchFieldLabel, super.searchFieldStyle, super.searchFieldDecorationTheme, super.keyboardType, super.textInputAction, required this.list});
  @override
  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [IconButton(
      onPressed:(){
        query='';
    },
      icon:Icon(Icons.clear),
    )];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    // TODO: implement buildLeading
    return IconButton(onPressed: (){
      close(context, null);
    }, icon: Icon(Icons.arrow_back)
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: implement buildResults
    List<Product> searchResust=[];
    for(var product in list){
      if(product.tittle.toLowerCase().contains(query.toLowerCase())){
        searchResust.add(product);
      }
    }
    return ListView.builder(
        itemCount: searchResust.length,
        itemBuilder: (context,index){
          Product product=searchResust[index];
          return ListTile(
            title: Text(product.tittle),
          );
        }
        );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<Product> suggestions=[];
    for(var product in list){
      if(product.tittle.toLowerCase().contains(query)){
        suggestions.add(product);
      }
    }
    // TODO: implement buildSuggestions
    return ListView.builder(
        itemBuilder: (context,index){
          Product product=suggestions[index];
          return ListTile(
            title: Text(product.tittle),
          );
        }
        );
  }
  
}