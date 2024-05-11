import 'package:flutter/material.dart';

class ShowTattoos extends StatefulWidget {
  const ShowTattoos({Key? key}) : super(key: key);

  @override
  _ShowTattoosState createState() => _ShowTattoosState();
}

class _ShowTattoosState extends State<ShowTattoos> with TickerProviderStateMixin {
  final PageController pageController = PageController(
    initialPage: 0,
  );

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