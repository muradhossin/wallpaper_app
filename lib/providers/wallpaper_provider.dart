import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:wallpaper_app/models/wallpaper_response.dart';
import 'package:http/http.dart' as Http;
import 'package:wallpaper_app/utils/constants.dart';

class WallpaperProvider extends ChangeNotifier{
  WallpaperResponse? wallpaperResponse;
  String? categoryName;
  num pageNumber = 1;

  void setCategory(String catName){
    categoryName = catName;
  }

  void setPageNumber (num pgNumber){
    pageNumber = pgNumber;
  }

  bool get hasDataLoaded => wallpaperResponse != null;
  bool get hasCategoryName => categoryName != null;

  Future<void> getCategoryData() async{
    final urlString = "https://api.pexels.com/v1/search?query=$categoryName&page=$pageNumber&per_page=16";
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
    final urlString = "https://api.pexels.com/v1/curated/?page=$pageNumber&per_page=16";
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