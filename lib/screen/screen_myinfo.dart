import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scart/util/kakaoController.dart';
import 'package:scart/widget/widget_customAppBar.dart';
import 'package:scart/widget/widget_customNavBar.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../util/AllTattooList.dart';
import '../util/Tattoo.dart';
import '../widget/widget_customhomeFAB.dart';

class MyinfoScreen extends StatefulWidget {
  const MyinfoScreen({Key? key}) : super(key: key);

  @override
  State<MyinfoScreen> createState() => MyinfoState();
}

class MyinfoState extends State<MyinfoScreen> {
  final storage = FlutterSecureStorage();
  var scarId = 0;
  var isFirst = true;
  Future<List<AllTattooList>>? futureAllTattoo;
  late Future<Tattoo> futureTattoo;

  Future<bool> checkIsFirstUser() async {
    final url = Uri.http('165.194.104.144:8888', '/api/user/checkIsFirstUser');

    try {
      var appToken = await storage.read(key: 'appToken');

      final response = await http.get(url, headers: {'accessToken':appToken!, 'Content-Type':'application/json'});

      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }

    } catch(e) {
      Exception(e);
      return false;
    }
  }

  Future<List<AllTattooList>> getAllTattoo() async {
    final url = Uri.http('165.194.104.144:8888', '/api/scar/getAllTattoo');

    try {
      var appToken = await storage.read(key: 'appToken');

      final response = await http.get(url, headers: {'accessToken':appToken!, 'Content-Type':'application/json'});

      if (response.statusCode == 200) {
        Map<String, dynamic> bodyMap = jsonDecode(response.body);
        List<dynamic> dataMap = await bodyMap['data'];
        List<AllTattooList> allTattooInfo =
        dataMap.map((dynamic item) => AllTattooList.fromJson(item)).toList();

        print("********test getAllTattoo request********");
        print(allTattooInfo);

        return allTattooInfo;
      } else {
        print("Failed to load AllTattoo");
        throw Exception("Failed to load AllTattoo");
      }
    } catch(e) {
      rethrow;
    }
  }

  Future<Tattoo> getTattooAllInfo() async {
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

        return Tattoo.fromJson(dataMap);
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
    if (checkIsFirstUser() == true) {
      setState(() {
        isFirst = true;
      });
    } else {
      futureAllTattoo = getAllTattoo();
      isFirst = false;
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
          SizedBox(height: 10, width: double.infinity),
          Row(
            children: <Widget>[
              _profile(),
              _nickname(),
            ]
          ),
          SizedBox(height: 30, width: double.infinity),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: Text('마이 타투',
              textAlign: TextAlign.left,
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
              ),
            ),
          ),
          isFirst ?
          SizedBox(
            height: 140,
            child: Center(
              child: Text("사진 촬영을 통해 나만의 타투를 만들어보세요! 🤹🏻", style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 17,
              )),
            ),
          ) : FutureBuilder<List<AllTattooList>>(
            future: futureAllTattoo,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return buildGrid(snapshot);
              } else if (snapshot.hasError) {
                return SizedBox(
                  height: 140,
                  child: Center(
                    child: Text("[ERROR] ${snapshot.error} !", style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    )),
                  ),
                );
              }
              return CircularProgressIndicator();
            },
          ),
        ],
      ),
    );
  }

  Widget _profile() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Container(
      width: 100,
      height: 100,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(100),
        child: Consumer<UserController>(builder: (context, controller, child) {
          final String? src = controller.user?.kakaoAccount?.profile?.thumbnailImageUrl;
          // controller.user?.kakaoAccount?.profile?.thumbnailImageUrl
          if (src != null) {
            return Image.network(src, fit: BoxFit.cover);
          } else {
            return Container(
              color: Colors.black,
            );
          }
        }),
      ),
    ),
  );

  Widget _nickname() => Padding(
    padding: const EdgeInsets.all(8.0),
    child: Consumer<UserController>(builder: (context, controller, child) {
      final String? name = controller.user?.kakaoAccount?.profile?.nickname;
      // controller.user?.kakaoAccount?.profile?.nickname;
      if (name != null) {

        return Text(name + " 님", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ));
      } else {
        return const Text("OOO 님", style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ));
      }
    }),
  );

  Widget buildGrid(snapshot) {
    return GridView.builder(
      physics: ScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemCount: snapshot.length,
      itemBuilder: (context, index) =>
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.all(10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(snapshot[index].tattooImage.toString()),
            ),
          ),
    );
  }
}