import 'dart:io' as platform;

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoViewPage extends StatefulWidget {
  const PhotoViewPage({Key? key}) : super(key: key);
  static const String routeName = '/photoview';

  @override
  State<PhotoViewPage> createState() => _PhotoViewPageState();
}

class _PhotoViewPageState extends State<PhotoViewPage> {
  bool isPermissionGranted = false;
  bool isPermissionReject = false;
  String downloadStatus = "";

  @override
  Widget build(BuildContext context) {
    final imgUrl = ModalRoute
        .of(context)!
        .settings
        .arguments as String;
    return Scaffold(
      body: Stack(children: [
        SizedBox(
          height: MediaQuery
              .of(context)
              .size
              .height,
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: CachedNetworkImage(
            imageUrl: imgUrl,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () {
                  _save(imgUrl);
                }, child: const Text("Save Image"),
              ),
              if(isPermissionGranted) Text(downloadStatus),
              if(isPermissionReject) Text(downloadStatus),
            ],
          ),
        ),
      ],
      ),
    );
  }

  void _save(imgUrl) async {
    final permission = await _askPermission();
    if (permission) {
      var response = await Dio().get(imgUrl,
          options: Options(responseType: ResponseType.bytes));
      await ImageGallerySaver.saveImage(Uint8List.fromList(response.data));
      setState(() {
        isPermissionGranted = true;
        downloadStatus = "Image Saved in Gallery";
      });
    } else {
      setState(() {
        isPermissionReject = true;
        downloadStatus = "Please Give Storage Permission";
      });
    }
  }

  _askPermission() async {
    if (platform.Platform.isAndroid) {
      Map<Permission, PermissionStatus> statuses = await [
        Permission.storage,
      ].request();
      PermissionStatus permissionStatus = await Permission.storage.status;
      if (permissionStatus.isGranted) {
        return true;
      } else {
        return false;
      }
    }
  }
}
