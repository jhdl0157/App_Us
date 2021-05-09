import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:us_2/src/srceen/login.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';


class ImageAndCamera extends StatefulWidget {
  @override
  ImageAndCameraState createState() => ImageAndCameraState();
}

class ImageAndCameraState extends State<ImageAndCamera> {
  File mPhoto;
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future getCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Widget build(BuildContext context) {
    Widget photo = (_image != null) ? Image.file(_image) : Text('사진을 선택해주세요');

    return Container(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Center(child: photo),
          ),
          Row(
            children: <Widget>[
              RaisedButton(
                child: Text('앨범'),
                onPressed: () => getImage(),
              ),
              RaisedButton(
                child: Text('카메라'),
                onPressed: () => getCamera(),
              ),
              RaisedButton(
                child: Text('업로드'),
                onPressed: () => getCamera(),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.center,
          ),
        ],
        //화면 하단에 배치
        mainAxisAlignment: MainAxisAlignment.end,
      ),
    );
  }
}