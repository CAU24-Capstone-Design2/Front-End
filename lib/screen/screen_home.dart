import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scart/util/AllTattooList.dart';
import 'package:scart/util/Tattoo.dart';
import 'package:scart/widget/widget_customNavBar.dart';
import 'package:scart/widget/widget_mytattooTilt.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../widget/widget_customAppBar.dart';
import '../widget/widget_customhomeFAB.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  final storage = FlutterSecureStorage();
  var tattolength = 0;
  var scarId = 0;
  var isFirst = true;
  var tattooStyleImages = List.empty(growable : true);
  List<AllTattooList>? futureAllTattoo;
  Tattoo? futureTattoo;

  Future<bool> checkIsFirstUser() async {
    final url = Uri.http('165.194.104.144:8888', '/api/user/checkIsFirstUser');

    try {
      var appToken = await storage.read(key: 'appToken');

      final response = await http.get(url, headers: {'accessToken':appToken!, 'Content-Type':'application/json'});
      if (response.statusCode == 200) {
        Map<String, dynamic> bodyMap = jsonDecode(response.body);
        bool data = await bodyMap['data'];

        print("tetstest data: "+data.toString());
        if (data.toString() == "true") {
          return false;
        } else {
          return true;
        }
        return true;
      } else {
        return false;
      }

    } catch(e) {
      Exception(e);
      return false;
    }
  }

  Future<bool> getAllTattoo() async {
    final url = Uri.http('165.194.104.144:8888', '/api/scar/getAllTattoo');

    try {
      var appToken = await storage.read(key: 'appToken');

      final response = await http.get(url, headers: {'accessToken':appToken!, 'Content-Type':'application/json'});

      if (response.statusCode == 200) {
        print("test****************1");
        Map<String, dynamic> bodyMap = jsonDecode(response.body);
        print(bodyMap);
        print("test****************2");
        List<dynamic> dataMap = await bodyMap['data'];
        List<AllTattooList> allTattooInfo =
            dataMap.map((dynamic item) => AllTattooList.fromJson(item)).toList();
        print("test****************");
        print("allTattooInfo length: "+tattolength.toString());
        print(allTattooInfo[0].tattooImage);

        setState(() {
          tattolength = allTattooInfo.length;
          futureAllTattoo = allTattooInfo;
        });

        print("tattoolength in allTattooInfo *************"+tattolength.toString());

        return true;
      } else {
        print("Failed to load AllTattoo");
        throw Exception("Failed to load AllTattoo");
      }
    } catch(e) {
      rethrow;
    }
  }

  Future<bool> getTattooAllInfo(i) async {
    final api = 'api/scar/' + scarId.toString() + '/getTattooAllInfo';

    final url = Uri.http('165.194.104.144:8888', api);

    try {
      var appToken = await storage.read(key: 'appToken');

      final response = await http.get(url, headers: {'accessToken':appToken!, 'Content-Type':'application/json'});

      if (response.statusCode == 200) {
        Map<String, dynamic> bodyMap = jsonDecode(response.body);
        Map<String, dynamic> dataMap = await bodyMap['data'];

        print("********test getTattooAllInfo request********");
        print(dataMap);

        setState(() {
          futureTattoo = Tattoo.fromJson(dataMap);
        });
        return true;
      } else {
        print("Failed to load AllTattoo");
        throw Exception("Failed to load AllTattoo");
      }
    } catch(e) {
      rethrow;
    }
  }

  @override
  void initState(){
    super.initState();
    getAllTattoo();
    print("initState isFirst: "+ isFirst.toString());
    if (isFirst == true) {
      checkIsFirstUser().then((result) {
        print("*********tescheckIsUser1234 "+result.toString());
        if (result.toString() == "false") {
          setState(() {
            isFirst = false;
            getAllTattoo();
            print("***getfuterAllTattoo");
            print("isFirst : "+isFirst.toString());
          });
        }
      });
    }

    if (tattooStyleImages.isEmpty) {
      for (int i=1; i<=16; i++) {
        var image = 'assets/tattoo/oldschool'+ i.toString() +'.png';
        tattooStyleImages.add(image);
      }

      for (int i=1; i<=16; i++) {
        var image = 'assets/tattoo/linework'+ i.toString() +'.png';
        tattooStyleImages.add(image);
      }

      for (int i=1; i<=16; i++) {
        var image = 'assets/tattoo/watercolor'+ i.toString() +'.png';
        tattooStyleImages.add(image);
      }

      tattooStyleImages.shuffle();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(83.0),
        child: CustomAppBar(),
      ),
      bottomNavigationBar: CustomNavBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: CustomHomeFAB(),
      body: ListView(
        children: [
          SizedBox(height: 20, width: double.infinity),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('마이 타투',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),),
          ),
          Center(
            child: SingleChildScrollView( // Row vs. SingleChildScrollView : 스크롤 가능
            scrollDirection: Axis.horizontal,
            child: isFirst ?
            SizedBox(
              height: 140,
              child: Center(
                child: Text("사진 촬영을 통해 나만의 타투를 만들어보세요! 🤹🏻", style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                )),
              ),
            ) : buildTattoos()
          ),),
          SizedBox(height: 30, width: double.infinity),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                print('스타일 보기');
                Navigator.pushNamed(context, '/tattoostyle');
              },
              child: Text('스타일 둘러보기 >',
                textAlign: TextAlign.left,
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
          GridView.builder(
            physics: ScrollPhysics(),
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemCount: tattooStyleImages.length,
            itemBuilder: (context, index) =>
                Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.all(10.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10.0),
                    child: Image.asset(tattooStyleImages[index], fit: BoxFit.cover),
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget buildTattoos() {
    print("******************buildTattoos: "+tattolength.toString());
    if (tattolength > 0) {
      print("not null***********");
      print("futureALlTattoo in buildTattoos : "+futureAllTattoo![0].scarId.toString());
      return Row(
        children: [for(int i=0; i<futureAllTattoo!.length; i++) GestureDetector(
          onTap: () {
            setState(() {
              scarId = futureAllTattoo![i].scarId;
              getTattooAllInfo(i).then((result) {
                print("getTattooAllInfo result: "+ result.toString());
                print(futureTattoo?.scarImage.toString());
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0)
                        ),
                        content: MytattooTilt(tattooData: futureTattoo!), // 여기다가 futureTattoo 넘겨줘서 요청보내기!!
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
              });
            });
          },
          child: Container(
            width: 140,
            height: 140,
            margin: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(futureAllTattoo![i].tattooImage, height: 160,),
            ),
          ),
        )],
      );
    } else {
      print("null***********");
      return Center(
        child: Text("사진 촬영을 통해 나만의 타투를 만들어보세요! 🤹🏻", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 17,
        )),
      );
    }

  }
}