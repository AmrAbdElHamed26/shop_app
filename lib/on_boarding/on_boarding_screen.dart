import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../login_package/login_screen.dart';
import '../shared/components.dart';

class OnBoardingData{

  final String image ;
  final String title ;
  final String body ;

  OnBoardingData({
    required this.image ,
    required this.title,
    required this.body
});



}
class OnBoardingScreen extends StatefulWidget {
      OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardingData> boarding = [
    OnBoardingData(
      image: 'assets/images/onboard_1.jpg',
      title: 'onBoarding title 1',
      body: 'onBoarding Body 1'
    ),
    OnBoardingData(
        image: 'assets/images/onboard_1.jpg',
        title: 'onBoarding title 2',
        body: 'onBoarding Body 2'
    ),
    OnBoardingData(
        image: 'assets/images/onboard_1.jpg',
        title: 'onBoarding title 3',
        body: 'onBoarding Body 3'
    ),

  ];

  bool isLast = false ;
  var pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(onPressed: (){
            navigateAndFinish(context, LoginScreen());
          },
              child: Text(
                  'SKIP',
                style: TextStyle(
                  color: Colors.white,
                ),
              )
            ,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(

          children: [
            Expanded(
              child: PageView.builder(itemBuilder: (context , int index)=> BoardingItem(boarding[index]) ,
                itemCount: boarding.length,
                physics: BouncingScrollPhysics(),
                onPageChanged: (int index){
                  if(index == boarding.length-1){
                    setState(() {
                      isLast = true ;
                    });
                  }
                  else {
                    setState(() {
                      isLast = false ;
                    });
                  }

                },
                controller: pageController,
                scrollDirection: Axis.horizontal,
              ),
            ) ,
            SizedBox(height: 15,),

            Row(
              children: [
                SmoothPageIndicator(
                    controller: pageController,
                    count: boarding.length,
                    effect:ExpandingDotsEffect() ,
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: ()=>{
                    if(isLast){
                      navigateAndFinish(context , LoginScreen(),)
                    }
                    else{
                      pageController.nextPage(
                        duration: Duration(
                          milliseconds: 500,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                    }

                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),


          ],
        ),
      )

    );



  }

  Widget BoardingItem(OnBoardingData myItem) =>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:  [
      Expanded(
        child: Image(
          image: AssetImage('${myItem.image}'),
        ),
      ),
      SizedBox(height: 15,),
      Text(
        '${myItem.title}',
        style: TextStyle(
          fontSize: 30,
        fontWeight: FontWeight.bold ,


      ),
  ),
      SizedBox(height: 30,),
      Text(
        '${myItem.body}',
        style: TextStyle(

          fontWeight: FontWeight.w400,


        ),

      ),


    ],
  );
}
