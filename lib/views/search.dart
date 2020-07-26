import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sez_wallpapers/data/data.dart';
import 'package:sez_wallpapers/model/wallpaper_model.dart';
import 'package:sez_wallpapers/widgets/widgets.dart';
import 'package:http/http.dart' as http;

class Search extends StatefulWidget {
    final String searchQuery;
    Search({this.searchQuery});

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

    List<WallpaperModel> wallpapers = new List();

    TextEditingController searchController = new TextEditingController();


    getSearchWallpapers(String query) async{

      var response = await http.get("https://api.pexels.com/v1/search?query=$query&per_page=26",
          headers: {"Authorization" : apiKey} );

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
      getSearchWallpapers(widget.searchQuery);
    super.initState();
    searchController.text = widget.searchQuery;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: brandName(),
        elevation: 0.0,
        actions: <Widget>[
          Container(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Icon(
                Icons.add,
                color: Colors.white,
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 16,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xfff5f8fd),
                  borderRadius: BorderRadius.circular(30),
                ),
                margin: EdgeInsets.symmetric(horizontal: 24),
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: TextField(
                          controller: searchController,
                          decoration: InputDecoration(
                              hintText: "search wallpapers",
                              border: InputBorder.none),
                        )),
                    InkWell(
                        onTap: () {
                          getSearchWallpapers(searchController.text);
                        },
                        child: Container(child: Icon(Icons.search)))
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              wallpapersList(wallpapers: wallpapers, context: context)
            ],
          ),
        ),
      ),
    );
  }
}

