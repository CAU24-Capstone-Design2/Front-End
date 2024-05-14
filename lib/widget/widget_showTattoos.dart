import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowTattoos extends StatefulWidget {
  const ShowTattoos({Key? key, this.tattooData}) : super(key: key);
  final tattooData;

  @override
  _ShowTattoosState createState() => _ShowTattoosState();
}

class _ShowTattoosState extends State<ShowTattoos> with TickerProviderStateMixin {
  final PageController pageController = PageController(
    initialPage: 0,
  );

  void downloadImage(String url) async {
    var status = await Permission.storage.status;

    if (status.isDenied) {
      await Permission.storage.request();
    } else {
      try {
        print("image save test");
        GallerySaver.saveImage(url);

        print("이미지 저장 성공!!");
      } catch(e) {
        print("이미지 저장 실패!");
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      child: PageView(
        controller: pageController,
        children: [
          Container(
            child: Column(
              children: [
                Image.network(widget.tattooData.scarImage, height: 180,),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    downloadImage(widget.tattooData.scarImage);
                  },
                  child: Text('Download'),
                )
            ],
           ),
          ),
          Container(
            child: Column(
              children: [
                Image.asset(widget.tattooData.segmentImage, height: 180,),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    downloadImage(widget.tattooData.segmentImage);
                  },
                  child: Text('Download'),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Image.asset(widget.tattooData.tattooImage, height: 180,),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    downloadImage(widget.tattooData.tattooImage);
                  },
                  child: Text('Download'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}