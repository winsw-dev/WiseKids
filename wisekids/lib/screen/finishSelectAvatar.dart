import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flare_flutter/flare_actor.dart';

import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import '../provider/audioProvider.dart';
import 'home.dart';

class FinishSelectAvatar extends StatefulWidget {
  @override
  _FinishSelectAvatarState createState() => _FinishSelectAvatarState();
}

class _FinishSelectAvatarState extends State<FinishSelectAvatar> {
  @override
  Widget build(BuildContext context) {
    final deviceHeight = MediaQuery.of(context).size.height;
    final deviceWidth = MediaQuery.of(context).size.width;
    /*Provider.of<AudioProvider>(context, listen: false)
        .playSoundEffect("gameWin", 1.0);*/
    //////////////////////////////////////////////////////////// auto route to HomePage
    Future.delayed(Duration(milliseconds: 4000), () {
      Provider.of<AudioProvider>(context, listen: false)
          .playSoundEffect("click3", 1.0);
      Provider.of<AudioProvider>(context, listen: false).stopCongratTheme();
      Provider.of<AudioProvider>(context, listen: false).resumeBgMusic();
      Provider.of<DataProvider>(context, listen: false)
          .saveDataToSharedPreferences();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
    });

    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        ////////////////////// avoid bottom notch pading
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            ///////////////////////////////////////  BG
            Container(
              width: deviceWidth,
              height: deviceHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 1.0],
                  colors: [
                    Color.fromRGBO(255, 96, 84, 1.00),
                    Color.fromRGBO(255, 109, 49, 1.00)
                  ],
                ),
              ),
              child: Stack(
                children: <Widget>[
                  Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    child: SvgPicture.asset(
                        'assets/images/finishSelectAvatar/congratGradientOverlay.svg'),
                  ),
                  Container(
                    width: deviceWidth,
                    height: deviceHeight,
                    child: Image.asset(
                      'assets/images/finishSelectAvatar/pattern.png',
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                ],
              ),
            ),

            ////////////////////////////////////////////////////// Firework Animation
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? deviceHeight * 0.16
                        : deviceHeight * 0.2,
                  ),
                  height: deviceHeight > 500
                      ? deviceHeight * 0.6
                      : deviceHeight * 0.7,
                  child: FlareActor("assets/animation/Firework.flr",
                      animation: 'Firework'),
                ),
              ),
            ),

            ////////////////////////////////////////////////////// Character
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? deviceHeight * 0.324
                        : deviceHeight * 0.34,
                  ),
                  child: Hero(
                    tag: 'avatar' +
                        Provider.of<DataProvider>(context, listen: false)
                                .avatar[
                            Provider.of<DataProvider>(context, listen: false)
                                .currentKids],
                    child: Container(
                      width: deviceHeight > 500
                          ? deviceWidth * 0.3
                          : deviceWidth * 0.5,
                      height: deviceHeight > 500
                          ? deviceHeight * 0.5
                          : deviceHeight * 0.6,
                      child: Image.asset('assets/images/finishSelectAvatar/' +
                          Provider.of<DataProvider>(context, listen: false)
                                  .avatar[
                              Provider.of<DataProvider>(context, listen: false)
                                  .currentKids] +
                          'AvatarCongrat.png'),
                    ),
                  ),
                ),
              ),
            ),

            /////////////////////////////////////////////////////// Congrat Sign
            Positioned.fill(
              child: Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                    top: deviceHeight > 500
                        ? deviceHeight * 0.11
                        : deviceHeight * 0.06,
                  ),
                  width: deviceHeight > 500
                      ? deviceWidth * 0.48
                      : deviceWidth * 0.4,
                  child: Image.asset(
                      'assets/images/finishSelectAvatar/congratSign.png'),
                ),
              ),
            ),

            /////////////////////////////////////////////////////// Congrat Text
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: deviceHeight > 500
                    ? Container(
                        margin: EdgeInsets.only(bottom: deviceHeight * 0.087),
                        child: Text(
                          'This is your avatar. Let\'s read and play !',
                          style: TextStyle(
                              fontFamily: 'NunitoRegular',
                              fontSize: deviceHeight > 500 ? 30 : 15,
                              color: Colors.white),
                        ),
                      )
                    : null,
              ),
            ),

            //////////////////////////////////////////////////////// Ink Well
            Container(
              height: deviceHeight,
              width: deviceWidth,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                    highlightColor: Color.fromRGBO(255, 255, 255, 0.05),
                    splashColor: Color.fromRGBO(255, 255, 255, 0.2),
                    onTap: () {
                      Provider.of<AudioProvider>(context, listen: false)
                          .playSoundEffect("click3", 1.0);
                      Provider.of<AudioProvider>(context, listen: false)
                          .stopCongratTheme();
                      Provider.of<AudioProvider>(context, listen: false)
                          .resumeBgMusic();
                      Provider.of<DataProvider>(context, listen: false)
                          .saveDataToSharedPreferences();
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Home(),
                        ),
                      );
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
