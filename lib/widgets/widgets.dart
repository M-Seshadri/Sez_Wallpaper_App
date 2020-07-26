import 'package:flutter/material.dart';
import 'package:sez_wallpapers/model/wallpaper_model.dart';
import 'package:sez_wallpapers/views/image_view.dart';
Widget brandName(){
  return RichText(
    text: TextSpan(
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      children: <TextSpan>[
        TextSpan(text:'Sez', style: TextStyle(color: Colors.black87)),
        TextSpan(text:'Wallpapers', style: TextStyle(color: Colors.blue)),
      ],
    ),
  );
}

Widget wallpapersList({List<WallpaperModel> wallpapers, context}){
  return Container(
    padding: EdgeInsets.symmetric(horizontal: 16),
    child: GridView.count(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      crossAxisCount: 2,
      childAspectRatio: 0.6,
      mainAxisSpacing: 6.0,
      crossAxisSpacing: 6.0,
      children: wallpapers.map((wallpaper){
        return GridTile(
          child: GestureDetector(
              onTap:(){
                Navigator.push(context,MaterialPageRoute(
                    builder: (context) =>ImageView(
                      imgUrl: wallpaper.src.portrait,
                    )
                ));
              },
            child: Hero(
              tag: wallpaper.src.portrait,
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      wallpaper.src.portrait, height:50, width: 100,fit: BoxFit.cover,
                    )
                ),
              ),
            ),
          ),
        );
      }).toList(),
    ),
  );
}



Widget brandName1() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Text(
        "Sez",
        style: TextStyle(color: Colors.black87, fontFamily: 'Overpass'),
      ),
      Text(
        "Wallpaper",
        style: TextStyle(color: Colors.blue, fontFamily: 'Overpass'),
      )
    ],
  );
}
