import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sez_wallpapers/data/data.dart';
import 'package:sez_wallpapers/model/categories_model.dart';
import 'package:sez_wallpapers/model/wallpaper_model.dart';
import 'package:sez_wallpapers/views/categorie.dart';
import 'package:sez_wallpapers/views/search.dart';
import 'package:sez_wallpapers/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List<CategoriesModel> categories  = new List();
  List<WallpaperModel> wallpapers = new List();
  TextEditingController searchController = new TextEditingController();

  getTrendingWallpapers() async{

    var response = await http.get("https://api.pexels.com/v1/curated?per_page=26",
    headers: {
      "Authorization" : apiKey} );

    //print(response.body.toString());

    Map<String, dynamic> jsonData = jsonDecode(response.body);
    jsonData["photos"].forEach((element){
      //print(element);
      WallpaperModel wallpaperModel =new WallpaperModel();
      wallpaperModel = WallpaperModel.fromMap(element);
      wallpapers.add(wallpaperModel);

    });

    setState(() {

    });
  }

  @override
  void initState() {
    getTrendingWallpapers();
    categories =getCategories();

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,

      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                color: Color(0xfff5f8fd),
                borderRadius: BorderRadius.circular(30)
              ),
              padding: EdgeInsets.symmetric(horizontal: 24),
              margin: EdgeInsets.symmetric(horizontal: 24),
              child: Row (children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: searchController,
                  decoration: InputDecoration(
                      hintText: "search wallpaper",
                      border: InputBorder.none
                    ),
                   ),
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(
                      builder: (context) => Search(
                        searchQuery:searchController.text,
                      )
                    ));
                  },
                  child: Container(
                      child: Icon(Icons.search)),
                )
               ],),
            ),

            SizedBox(height: 16,),
              Container(
                height: 80,
              child: ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 24),
                  itemCount: categories.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index){
                    return CategoriesTile(
                      title: categories[index].categoriesName,
                      imgUrl: categories[index].imgUrl,
                    );
                  }),
            ),
            wallpapersList(wallpapers: wallpapers, context: context)



          ],),),
      ),
    );
  }
}

class CategoriesTile extends StatelessWidget {

 final  String imgUrl, title;
 CategoriesTile({@required this.title, @required this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => Categorie(
            categorieName: title.toLowerCase(),
          )
        ));
      },
      child: Container(
        margin: EdgeInsets.only(right: 4),
        child: Stack(
          children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
              child:Image.network(imgUrl, height: 50, width: 100, fit: BoxFit.cover)),
          Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(8),
            ),
            height: 50, width: 100,
            alignment: Alignment.center,
            child: Text(title, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 15),),),
          ],),
      ),
    );
  }
}

