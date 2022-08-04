import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled/modules/login/login_screen.dart';
import 'package:untitled/network/local/cacheHelper.dart';
import 'package:untitled/styles/colors.dart';

class BoardingModel {
   final String image;
   final String title;
   final String body;

  BoardingModel({ this.body,  this.image,  this.title});
}


class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var boardController = PageController();
  bool isLast = false;
  void submit(){
    CacheHelper.saveDate(key: 'onBoarding', value: true).then((value) {
      if(value){
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
              (Route<dynamic> route) => false,
        );
      }
    });
  }

  List<BoardingModel> boarding = [
    BoardingModel(
        title: 'Choose your product',
        image: 'assets/images/on_boarding1.png',
        body: 'There are more than 1000 brands of men\'s and woman\'s shoes and clothing in the catalog'),
    BoardingModel(
        title: 'Add to cart',
        image: 'assets/images/on_boarding2.png',
        body: 'Just 2 clicks and you can buy all the products news with home delivery'),
    BoardingModel(
        title: 'Confirmation',
        image: 'assets/images/on_boarding3.png',
        body: ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed:submit,
              child: Text('SKIP',
              style: TextStyle(
                fontSize: 20
              ),
              )

          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: BouncingScrollPhysics(),
                controller: boardController,
                onPageChanged: (int index) {
                  if (index == boarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) =>
                    buildBoardingItem(boarding[index]),
                itemCount: boarding.length,
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardController,
                    effect: ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      dotHeight: 10,
                      expansionFactor: 4,
                      dotWidth: 10,
                      spacing: 5,
                      activeDotColor: defaultColor,
                    ),
                    count: boarding.length),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    if (isLast) {
                      submit();
                    } else {
                      boardController.nextPage(
                          duration: Duration(milliseconds: 750),
                          curve: Curves.easeOutSine);
                    }
                  },
                  child: Icon(Icons.arrow_forward_ios_sharp),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Center(
            child: Text(
              '${model.title}',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            '${model.body}',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[500]
            ),
          ),
        ],
      );
}
