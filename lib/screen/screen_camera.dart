import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scart/widget/widget_customAppBar.dart';

import '../widget/widget_multiSelectChip.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => CameraState();
}

class CameraState extends State<CameraScreen> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();
  final tattoController = TextEditingController();

  List<String> tattostyleList = [
    "올드스쿨",
    "라인워크",
    "수채화",
  ];

  List<String> selectedTattostyleList = [];

  // 이미지 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: CustomAppBar(),
      ),
      body: ListView( // ListView : 스크롤 가능 vs. Column
        children: <Widget>[
          SizedBox(height: 10, width: double.infinity),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Text('흉터 사진을 촬영해주세요 !',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                IconButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('사진 찍는 방법'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('1. 예시 문구'),
                                  Text('2. 예시 문구'),
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('확인'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        }
                    );
                  },
                  icon: Image.asset('lib/asset/Tip.png'),
                ),
              ],
            ),
          ),
          SizedBox(height: 30, width: double.infinity),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildPhotoArea(),
              SizedBox(width: 40),
              _buildButton(),
            ],
          ),
          SizedBox(height: 80, width: double.infinity),
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('타투 도안의 스타일을 얘기해주세요 !',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                MultiSelectChip(
                  tattostyleList,
                  onSelectedChanged: (selectedList) {
                    setState(() {
                      selectedTattostyleList = selectedList;
                    });
                  },
                  maxSelection: 3,
                ),
              ],
            ),
          ),
          SizedBox(height: 80, width: double.infinity),
          Container(
            padding: const EdgeInsets.only(left: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('타투 도안에 추가하고 싶은게 있나요 ?',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600
                  ),),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, right: 20.0),
                  child: TextField(
                    decoration: InputDecoration(
                        labelText: '원하는 스타일을 입력해주세요!',
                        filled: true,
                        fillColor: Color(0xffEEF4FF),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none
                        )
                    ),
                    controller: tattoController,
                  ),
                )
              ],
            )
          ),
          SizedBox(height: 80, width: double.infinity),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              onPressed: () {
                print(tattoController.text);
                print(selectedTattostyleList.join(','));
                Navigator.pushReplacementNamed(context, '/home');
              },
              icon: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text('완료',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                    ),),
                  Icon(Icons.arrow_forward)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPhotoArea() {
    return _image != null
        ?
        UnconstrainedBox(
          child: Container(
            width: 120,
            height: 120,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.file(File(_image!.path),fit: BoxFit.cover,),
            ),
            decoration: BoxDecoration(
                color: Color(0xffEEF4FF),
                borderRadius: BorderRadius.circular(10.0)
            ),
          ),
        )
     :
        UnconstrainedBox(
          child: Container(
            width: 120,
            height: 120,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo, size: 30,),
                SizedBox(height: 10, width: double.infinity),
                Text('사진 추가'),
              ],
            ),
            decoration: BoxDecoration(
                color: Color(0xffEEF4FF),
                borderRadius: BorderRadius.circular(10.0)
            ),
          ),
        );
  }

  Widget _buildButton() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.camera);
          },
          child: Text('Camera'),
        ),
        SizedBox(width: 30),
        ElevatedButton(
          onPressed: () {
            getImage(ImageSource.gallery);
          },
          child: Text('Gallery'),
        ),
      ],
    );
  }
}