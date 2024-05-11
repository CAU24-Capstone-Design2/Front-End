import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';

class ShowTattoos extends StatefulWidget {
  const ShowTattoos({Key? key}) : super(key: key);

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
                Image.asset('assets/scar1.png', height: 180,),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    downloadImage('https://file.notion.so/f/f/0e18d6e9-2850-48da-b9ba-fcb851077aeb/c7e2fffd-1a95-4ec9-88f6-10e43affca80/scar1.png?id=ec57692d-bd3c-4d8e-8b1c-0fe85a88ce6b&table=block&spaceId=0e18d6e9-2850-48da-b9ba-fcb851077aeb&expirationTimestamp=1715529600000&signature=dUP06nw9wlV-fwmaGU4_gtLFVEkUnLblJgSZ5vjWGow&downloadName=scar1.png');
                  },
                  child: Text('Download'),
                )
            ],
           ),
          ),
          Container(
            child: Column(
              children: [
                Image.asset('assets/nobg_masked_scar.png', height: 180,),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    downloadImage('https://file.notion.so/f/f/0e18d6e9-2850-48da-b9ba-fcb851077aeb/236518d7-53bb-475f-a8c2-3611fbeea68b/nobg_masked_scar.png?id=749ddb46-31e4-4a1b-a25b-6dd370f9abd1&table=block&spaceId=0e18d6e9-2850-48da-b9ba-fcb851077aeb&expirationTimestamp=1715529600000&signature=7U0k5KChfp7WJaQClIMXTRLRjvKiPrvSaCnpSZDelIY&downloadName=nobg_masked_scar.png');
                  },
                  child: Text('Download'),
                )
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Image.asset('assets/nobg_masked_airplane.png', height: 180,),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    downloadImage('https://file.notion.so/f/f/0e18d6e9-2850-48da-b9ba-fcb851077aeb/85f52349-0674-4b68-8c54-96aa9fa5aa3a/nobg_masked_airplane.png?id=212dadee-082d-47c2-8e66-72b3188a0f93&table=block&spaceId=0e18d6e9-2850-48da-b9ba-fcb851077aeb&expirationTimestamp=1715529600000&signature=1uaNCrmvf9iGi-xVNmrC0FQmmNUlfn3ohGuEq7t_Iao&downloadName=nobg_masked_airplane.png');
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