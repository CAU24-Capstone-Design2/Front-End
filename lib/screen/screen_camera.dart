import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:translator/translator.dart';
import 'package:http/http.dart' as http;
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
  var tattoStyle = "";
  var tattoText = "";
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

  Future<bool> requestTattto() async {
    final url = Uri.http('165.194.104.144:8888', '/api/scar/requestTattoo');

    try {
      setState(() {
        isLoading = true;
      });
      var accessToken = await storage.read(key: 'accessToken');

      print("***********accessToken************ " + accessToken!);

      MultipartRequest request = new http.MultipartRequest('POST', url);
      request.headers['Content-Type'] = 'application/json';
      request.headers['accessToken'] = 'appToken'; //login시 발급되는 accessToken
      request.fields['styleKeyWord'] = tattoStyle;
      request.fields['styleDescription'] = tattoText;

      request.files.add(await http.MultipartFile.fromPath(
          'scarImage', _image!.path));
      print("****************multipart request send!!**************");
      var response = await request.send();

      if (response.statusCode == 200) {
        print("타투 데이터 전송 성공!");
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
                            title: const Text('사진 찍을 때 Tip !'),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: <Widget>[
                                  Text('사진은 그림자가 없는 환경에서 흉터를 잘 찍어주면 더 정확한 결과가 나와요 :)'),
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
                    controller: tattoController,
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
                if (tattoController.text == null || selectedTattostyleList == null || _image == null) {
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
                  var tattoText = "";
                  var tattoStyle = "";
                  translator
                  .translate(tattoController.text, to: 'en')
                  .then(
                          (result) {
                          print("Source: ${tattoController.text}\nTranslated: $result");
                          tattoText = result.toString();
                          }
                  );

                  translator
                  .translate(selectedTattostyleList.join(','))
                  .then((result) {
                      print("Source: ${selectedTattostyleList.join(',')}\nTranslated: $result");
                      tattoStyle = result.toString();
                      requestTattto();
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