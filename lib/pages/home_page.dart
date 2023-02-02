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
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() {});
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (isCalledOnce) {
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
        title: Text(
          'Wallpaper Store',
          style: TextStyle(fontSize: 25, color: Colors.grey.shade700)
        ),
        elevation: 0.0,
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: RefreshIndicator(
        onRefresh: () async{
          provider.getBodyData();
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
              children: [
                buildSectionSearch(),
                buildSectionCategory(),
                buildSectionBody(),
                buildSectionPage(),
              ],
            ),
          ),
      ),
    );
  }

  Padding buildSectionPage() {
    final pageNumber = provider.wallpaperResponse?.page;
    return Padding(
      padding: const EdgeInsets.all(9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          provider.hasDataLoaded
              ? Container(
                  child: (pageNumber! > 1)
                      ? OutlinedButton(
                          onPressed: () {
                            if (pageNumber! > 1) {

                              setState(() {
                                scrollController.animateTo(0,
                                    duration: Duration(microseconds: 500),
                                    curve: Curves.fastOutSlowIn);
                              });
                              if(provider.hasCategoryName){
                                provider.setPageNumber(pageNumber! - 1);
                                provider.getCategoryData();
                              }
                              else if(_searchController.text.isNotEmpty){
                                provider.setPageNumber(pageNumber! - 1);
                                getInput();
                              }else{
                                provider.setPageNumber(pageNumber! - 1);
                                provider.getBodyData();
                              }

                            }
                          },
                          child: const Text('Previous page'),
                        )
                      : null,
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
          provider.hasDataLoaded
              ? OutlinedButton(
                  onPressed: () {
                    setState(() {
                      scrollController.animateTo(0,
                          duration: Duration(microseconds: 500),
                          curve: Curves.fastOutSlowIn);
                    });
                    if(provider.hasCategoryName){
                      provider.setPageNumber(pageNumber! + 1);
                      provider.getCategoryData();
                    }
                    else if(_searchController.text.isNotEmpty){
                      provider.setPageNumber(pageNumber! + 1);
                      getInput();
                    }else{
                      provider.setPageNumber(pageNumber! + 1);
                      provider.getBodyData();
                    }
                  },
                  child: const Text('Next page'),
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ],
      ),
    );
  }

  SingleChildRenderObjectWidget buildSectionBody() {
    final photoList = provider.wallpaperResponse?.photos;
    return provider.hasDataLoaded
        ? Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  childAspectRatio: .7, mainAxisSpacing: 7, crossAxisCount: 2),
              itemCount: photoList!.length,
              itemBuilder: (context, index) {
                final photo = photoList![index];
                return BodyTile(imgUrl: photo.src!.portrait!);
              },
            ),
          )
        : const Center(
            child: CircularProgressIndicator(),
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
              decoration: InputDecoration(
                hintText: 'search',
                border: InputBorder.none,
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      onPressed: (){
                        getInput();
                      },
                      icon: const Icon(Icons.search),
                    ),
                    IconButton(
                      onPressed: (){
                        _searchController.clear();
                        provider.setPageNumber(1);
                        provider.getBodyData();
                      },
                      icon: const Icon(Icons.delete_forever),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  getInput() {
    provider.setCategory(_searchController.text);
    provider.setPageNumber(1);
    provider.getCategoryData();
  }
}
