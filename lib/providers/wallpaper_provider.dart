import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper_response.dart';
import 'package:http/http.dart' as Http;
import 'package:wallpaper_app/utils/constants.dart';

class WallpaperProvider extends ChangeNotifier{
  WallpaperResponse? wallpaperResponse;
  late String categoryName;

  void setCategory(String catName){
    categoryName = catName;
    getCategoryData();
  }

  bool get hasDataLoaded => wallpaperResponse != null;

  Future<void> getCategoryData() async{
    final urlString = "https://api.pexels.com/v1/search?query=$categoryName&per_page=80";
    try{
      final response = await Http.get(Uri.parse(urlString), headers: {
        "Authorization": apiKey
      });
      final map = jsonDecode(response.body);
      if(response.statusCode == 200){
        wallpaperResponse = WallpaperResponse.fromJson(map);
        notifyListeners();
      }
    }catch(error){
      print(error.toString());
    }
  }

  Future<void> getBodyData() async{
    final urlString = "https://api.pexels.com/v1/curated?per_page=80";
    try{
      final response = await Http.get(Uri.parse(urlString), headers: {
        "Authorization": apiKey
      });
      final map = jsonDecode(response.body);
      if(response.statusCode == 200){
        wallpaperResponse = WallpaperResponse.fromJson(map);
        notifyListeners();
      }
    }catch(error){
      print(error.toString());
    }
  }

}