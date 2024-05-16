import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:scart/util/Tattoo.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ShowTattoos extends StatefulWidget {
  const ShowTattoos({Key? key, required this.tattooData}) : super(key: key);
  final Tattoo tattooData;

  @override
  _ShowTattoosState createState() => _ShowTattoosState();
}

class _ShowTattoosState extends State<ShowTattoos> with TickerProviderStateMixin {
  var isNotNull = false;
  final PageController pageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    if (widget.tattooData != null) {
      setState(() {
        isNotNull = true;
      });
    }
  }

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
    return !isNotNull ? Container() : ListView(
      shrinkWrap: true,
      children: [
        Container(
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
                    Image.network(widget.tattooData.segmentImage, height: 180,),
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
                    Image.network(widget.tattooData.tattooImage, height: 180,),
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
        ),
        SizedBox(height: 10),
        Center(
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: const WormEffect(
              dotHeight: 8,
              dotWidth: 8,
              type: WormType.thinUnderground,
            ),
          ),
        ),
      ],
    )
    ;
  }
}