import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
import '../widget/widget_CameraTips.dart';
import '../widget/widget_loading.dart';
import '../widget/widget_multiSelectChip.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CameraScreen extends StatefulWidget {
  const CameraScreen({Key? key}) : super(key: key);

  @override
  State<CameraScreen> createState() => CameraState();
}

class CameraState extends State<CameraScreen> {
  final storage = FlutterSecureStorage();
  var isLoading = false;
  XFile? _image;
  var tattooStyle = "";
  var tattooText = "";
  final ImagePicker picker = ImagePicker();
  final tattooController = TextEditingController();

  List<String> tattoostyleList = [
    "올드스쿨",
    "라인워크",
    "수채화",
  ];

  List<String> selectedTattoostyleList = [];

  // 이미지 가져오는 함수
  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = XFile(pickedFile.path);
      });
    }
  }

  Future<bool> requestTattto() async {
    final url = Uri.http('165.194.104.133:8888', '/api/scar/requestTattoo'); //165.194.104.144:8888 cvmlserver4

    try {
      setState(() {
        isLoading = true;
      });
      //var accessToken = await storage.read(key: 'accessToken');
      var appToken = await storage.read(key: 'appToken');

      print("***********appToken************ " + appToken!);
      print("tattooStyle: " + tattooStyle);
      print("tattooText: " + tattooText);

      MultipartRequest request = new http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'application/json';
      request.headers['accessToken'] = appToken ; //login시 발급되는 accessToken
      request.fields['styleKeyWord'] = tattooStyle;
      request.fields['styleDescription'] = tattooText;

      request.files.add(await http.MultipartFile.fromPath(
          'scarImage', _image!.path));
      print("****************multipart request send!!**************");
      var response = await request.send();

      if (response.statusCode == 200) {
        print("타투 데이터 전송 성공!");
        Navigator.pushReplacementNamed(context, '/home');
        return true;
      } else {
        print("타투 데이터 전송 실패!");
        return false;
      }
    } catch(e) {
      Exception(e);
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: CustomAppBar(),
      ),
      body: isLoading ? LoadingBar() : ListView( // List// View : 스크롤 가능 vs. Column
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
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0)
                            ),
                            title: const Text('사진 찍을 때 Tip !',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            )),
                            content: CameraTips(),
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
                  icon: Image.asset('assets/Tip.png'),
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
          SizedBox(height: 100, width: double.infinity),
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
                  tattoostyleList,
                  onSelectedChanged: (selectedList) {
                    setState(() {
                      selectedTattoostyleList = selectedList;
                    });
                  },
                  maxSelection: 3,
                ),
              ],
            ),
          ),
          SizedBox(height: 100, width: double.infinity),
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
                    controller: tattooController,
                  ),
                )
              ],
            )
          ),
          SizedBox(height: 100, width: double.infinity),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: IconButton(
              onPressed: () async {
                if (tattooController.text == null || selectedTattoostyleList == null || _image == null) {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        content: Text("흉터 사진, 타투 스타일, 타투 내용은 \n필수 입력 항목입니다!"),
                        actions: [
                          TextButton(
                            child: const Text('확인'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          )
                        ],
                      );
                    }
                  );
                } else {
                  final translator = GoogleTranslator();

                  translator
                  .translate(selectedTattoostyleList.join(','))
                  .then((result) {
                      print("Source: ${selectedTattoostyleList.join(',')}\nTranslated: $result");
                      setState(() {
                        tattooStyle = result.toString();
                      });

                      translator
                          .translate(tattooController.text, to: 'en')
                          .then(
                              (result) {
                            print("Source: ${tattooController.text}\nTranslated: $result");
                            setState(() {
                              tattooText = result.toString();
                              requestTattto();
                            });
                          }
                      );
                  }
                  );
                }
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
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff9CBFFF)),
          ),
          onPressed: () {
            getImage(ImageSource.camera);
          },
          child: Text('Camera'),
        ),
        SizedBox(height: 30),
        ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff9CBFFF)),
          ),
          onPressed: () {
            getImage(ImageSource.gallery);
          },
          child: Text('Gallery'),
        ),
      ],
    );
  }
}