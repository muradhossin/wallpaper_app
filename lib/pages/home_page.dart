import 'package:flutter/material.dart';
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
          Padding(
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
          ),
        ],
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

  getInput() {}
}
