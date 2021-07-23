import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gamershub/authentication/login.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:flutter/material.dart';
import 'package:intro_slider/dot_animation_enum.dart';
import 'package:gamershub/size_configuration.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<Slide> slides = [];
  Function goToTab;

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        backgroundColor: Color(0xff9E9CF5),
        title: "PUBG\nADDICTED\n?",
        styleTitle: TextStyle(
          color: Colors.white,
          fontSize: 30.0,
          letterSpacing: 2,
          height: 1.6,
          fontWeight: FontWeight.bold,
          fontFamily: 'Quicksand',
        ),
        description: "",
        styleDescription: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            letterSpacing: 1.3,
            height: 1.6,
            fontStyle: FontStyle.italic,
            fontFamily: 'Quicksand'),
        pathImage: "assets/logos/Group1.png",
      ),
    );
    slides.add(
      new Slide(
        backgroundColor: Color(0xff9E9CF5),
        title: "MUSEUM",
        styleTitle: TextStyle(
            color: Color(0xff3da4ab),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand'),
        description:
            "Ye indulgence unreserved connection alteration appearance",
        styleDescription: TextStyle(
            color: Color(0xff9E9CF5),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Quicksand'),
        pathImage: "assets/logos/Group2.png",
      ),
    );
    slides.add(
      new Slide(
        backgroundColor: Color(0xff9E9CF5),
        title: "COFFEE SHOP",
        styleTitle: TextStyle(
            color: Color(0xff9E9CF5),
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'Quicksand'),
        description:
            "Much evil soon high in hope do view. Out may few northward believing attempted. Yet timed being songs marry one defer men our. Although finished blessing do of",
        styleDescription: TextStyle(
            color: Color(0xff9E9CF5),
            fontSize: 20.0,
            fontStyle: FontStyle.italic,
            fontFamily: 'Quicksand'),
        pathImage: "assets/logos/Group3.png",
      ),
    );
  }

  void onDonePress() {
    // Back to the first tab
    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
      return LoginPage();
    }));
  }

  void onTabChangeCompleted(index) {
    // Index of current tab is focused
  }

  Widget renderNextBtn() {
    return Text(
      "Next",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget renderDoneBtn() {
    return Text(
      "Let's Go",
      style: TextStyle(color: Colors.white),
    );
  }

  Widget renderSkipBtn() {
    return Text(
      "Skip",
      style: TextStyle(color: Colors.white),
    );
  }

  List<Widget> renderListCustomTabs() {
    List<Widget> tabs = [];
    for (int i = 0; i < slides.length; i++) {
      Slide currentSlide = slides[i];
      tabs.add(Container(
        color: Color(0xff9E9CF5),
        width: double.infinity,
        height: double.infinity,
        child: Container(
          color: Color(0xff9E9CF5),
          margin: EdgeInsets.only(bottom: 70.0, top: 70.0),
          child: ListView(
            children: <Widget>[
              GestureDetector(
                  child: Image.asset(
                currentSlide.pathImage,
                width: 250.0,
                height: 250.0,
                fit: BoxFit.contain,
              )),
              Container(
                child: Text(
                  currentSlide.title,
                  style: currentSlide.styleTitle,
                  textAlign: TextAlign.center,
                ),
                margin: EdgeInsets.only(top: 50),
              ),
              Container(
                child: Text(
                  currentSlide.description,
                  style: currentSlide.styleDescription,
                  textAlign: TextAlign.center,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
                margin: EdgeInsets.only(top: 20.0),
              ),
            ],
          ),
        ),
      ));
    }
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      // Skip button
      // renderSkipBtn: this.renderSkipBtn(),
      // colorSkipBtn: Colors.black,
      // highlightColorSkipBtn: Color(0xffffcc5c),

      // Next button
      // renderNextBtn: this.renderNextBtn(),

      // Done button
      // renderDoneBtn: this.renderDoneBtn(),
      // onDonePress: this.onDonePress,
      // colorDoneBtn: Color(0xffFFCD41),
      // colorDoneBtn: Color(0xffFFCD41),
      // highlightColorDoneBtn: Color(0xffFFCD41),
      onDonePress: onDonePress,
      // Dot indicator
      colorDot: Colors.white,
      sizeDot: 10.0,
      // typeDotAnimation: ,
      typeDotAnimation: dotSliderAnimation.SIZE_TRANSITION,

      // Tabs
      listCustomTabs: this.renderListCustomTabs(),
      backgroundColorAllSlides: Color(0xff9E9CF5),
      refFuncGoToTab: (refFunc) {
        this.goToTab = refFunc;
      },

      // Behavior
      scrollPhysics: BouncingScrollPhysics(),

      // Show or hide status bar
      hideStatusBar: true,

      // On tab change completed
      onTabChangeCompleted: this.onTabChangeCompleted,
    );
  }
}
