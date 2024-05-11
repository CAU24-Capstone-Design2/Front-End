import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:scart/widget/widget_customNavBar.dart';
import 'package:scart/widget/widget_mytattoTilt.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../util/AllTattooList.dart';
import '../widget/widget_customAppBar.dart';
import '../widget/widget_customhomeFAB.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => HomeState();
}

class HomeState extends State<HomeScreen> {
  final storage = FlutterSecureStorage();
  Future<List<AllTattooList>>? futureAllTattoo;

  List <Icon> icons = [
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),
    Icon(Icons.insert_photo, size: 160),];

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

  @override
  void initState(){
    super.initState();
    futureAllTattoo = getAllTattoo();
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
            child: FutureBuilder<List<AllTattooList>>(
              future: futureAllTattoo,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return buildTattoos(snapshot);
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}에러!");
                }
                return CircularProgressIndicator();
              },
            )
          ),),
          SizedBox(height: 30, width: double.infinity),
          Container(
            margin: EdgeInsets.only(left: 20),
            child: GestureDetector(
              onTap: () {
                print('스타일 보기');
                Navigator.pushNamed(context, '/tattostyle');
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
            itemCount: 20,
            itemBuilder: (context, index) =>
                Container(
                  width: 80,
                  height: 80,
                  margin: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Color(0xffEEF4FF),
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                ),
          ),
        ],
      ),
    );
  }

  Widget buildTattoos(snapshot) {
    return Row(
      children: [for(var snap in snapshot) GestureDetector(
        onTap: () {
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (BuildContext context) {
                return AlertDialog(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)
                  ),
                  content: MytattoTilt(),
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
        },
        child: Image.network(snap.tattooImage.toString()),
      )],
    );
  }
}