import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/customwidgets/body_tile.dart';
import 'package:wallpaper_app/models/wallpaper_response.dart';
import 'package:wallpaper_app/providers/wallpaper_provider.dart';
import 'package:wallpaper_app/utils/constants.dart';

import '../customwidgets/category_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  static const String routeName = '/homepage';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _searchController = TextEditingController();
  late WallpaperProvider provider;
  bool isCalledOnce = true;

  @override
  void didChangeDependencies() {
    if(isCalledOnce){
      provider = Provider.of<WallpaperProvider>(context, listen: true);
      provider.getBodyData();
    }
    isCalledOnce = false;
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Wallpaper Store',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          buildSectionSearch(),
          buildSectionCategory(),
          buildSectionBody(),
        ],
      ),
    );
  }

  Expanded buildSectionBody() {
    final photoList = provider.wallpaperResponse?.photos ;
    return Expanded(
          child: provider.hasDataLoaded? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GridView.builder(

              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
               childAspectRatio: .7,
                  mainAxisSpacing: 7,
                  crossAxisCount: 2),
              itemCount: photoList!.length,
              itemBuilder: (context, index) {
                final photo = photoList![index];
                return BodyTile(imgUrl: photo.src!.portrait!);
              },
            ),
          ) : const Center(
            child: CircularProgressIndicator(),
          )
        );
  }

  Padding buildSectionCategory() {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: categoryModel.length,
          itemBuilder: (context, index) {
            final category = categoryModel[index];
            return CategoryTile(
              categoryName: category.categoryName,
              imageUrl: category.imageUrl,
            );
          },
        ),
      ),
    );
  }

  Row buildSectionSearch() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            margin: const EdgeInsets.symmetric(horizontal: 24),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(30),
            ),
            child: TextField(
              controller: _searchController,
              decoration: const InputDecoration(
                hintText: 'search',
                suffixIcon: Icon(Icons.search),
                border: InputBorder.none,
              ),
              onTap: () {
                getInput();
              },
            ),
          ),
        ),
      ],
    );
  }

  getInput() {
    provider.setCategory(_searchController.text);
  }
}
