import 'dart:async';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import '../provider/audioProvider.dart';
import '../provider/ttsProvider.dart';

/// Display slide dialog.
///
/// `barrierColor` Color of outside dialog. Defaults to Colors.black.withOpacity(0.7).
///
/// `barrierDismissible` Can be dismissed by tapping outside dialog. Defaults to true.
///
/// `transitionDuration` Duration of slide transition. Defaults to Duration(milliseconds: 300).
///
/// `pillColor` Color of pill inside dialog. Defaults to Colors.blueGrey[200].
///
/// `backgroundColor` Color of dialog background. Defaults to Theme.of(context).canvasColor.
Future<T> showSlideDialog<T>({
  @required BuildContext context,
  @required Widget child,
  Color barrierColor,
  bool barrierDismissible = true,
  Duration transitionDuration = const Duration(milliseconds: 300),
  Color pillColor,
  Color backgroundColor,
  Color containerColor,
  List<Color> bgGradient,
  List<double> gradientStop,
  bool propVisibility,
}) {
  assert(context != null);
  assert(child != null);

  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation1, animation2) {
      return;
    },
    barrierColor: barrierColor ?? Colors.black.withOpacity(0.7),
    barrierDismissible: barrierDismissible,
    barrierLabel: "Dismiss",
    transitionDuration: transitionDuration,
    transitionBuilder: (context, animation1, animation2, widget) {
      final curvedValue = Curves.easeInOut.transform(animation1.value) - 1.0;
      /* return Transform(
        transform: Matrix4.translationValues(0.0, curvedValue * -300, 0.0),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogVocab(
            child: child,
          ),
        ),
      ); */
      return ScaleTransition(
        alignment: Alignment.center,
        scale: CurvedAnimation(
          parent: animation1,
          curve: SpringCurve(),
          reverseCurve: SpringReverseCurve(),
        ),
        child: Opacity(
          opacity: animation1.value,
          child: SlideDialogVocab(
            child: child,
          ),
        ),
      );
    },
  );
}

////////////////////////////////////////////////////////////////
class SpringCurve extends Curve {
  const SpringCurve({
    this.a = 0.22,
    this.w = 6.5,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}

class SpringReverseCurve extends Curve {
  const SpringReverseCurve({
    this.a = 0.15,
    this.w = 6.5,
  });
  final double a;
  final double w;

  @override
  double transformInternal(double t) {
    return -(pow(e, -t / a) * cos(t * w)) + 1;
  }
}

//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////
class SlideDialogVocab extends StatefulWidget {
  final Widget child;

  SlideDialogVocab({
    @required this.child,
  });

  @override
  _SlideDialogVocabState createState() => _SlideDialogVocabState();
}

class _SlideDialogVocabState extends State<SlideDialogVocab> {
  @override
  void initState() {
    super.initState();
    Provider.of<TTSProvider>(context, listen: false).initTts();
   
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<TTSProvider>(context, listen: false).disposeTTS();
  }
  //var _initialPosition = 0.0;
  //var _currentPosition = 0.0;

  bool _perventMultipleTab = true;

  ////////////////////// Animation Control
  String toothController = 'Collected';
  String monsterController = 'Collected';
  String candyController = 'Collected';
  String mirrorController = 'Collected';
  String toothBrushController = 'Collected';

  void chooseSticker(String choosen) {
    print('clicked Sticker: $choosen');
    ////////////////// play sound and auto dispose
    Provider.of<TTSProvider>(context, listen: false).speak(choosen);
    /* AssetsAudioPlayer.playAndForget(Audio(
        'assets/ttsAudio/candyMonster/level1/' +
            choosen
                .toLowerCase()
                .replaceAll(new RegExp(r'(?:_|[^\w\s])+'), '') +
            '.mp3')); */
    ////////////////////////
    setState(() {
      if (choosen == 'tooth') {
        toothController = 'Active';
        if (monsterController == 'Active') {
          monsterController = 'Deactive';
        } else if (candyController == 'Active') {
          candyController = 'Deactive';
        } else if (mirrorController == 'Active') {
          mirrorController = 'Deactive';
        } else if (toothBrushController == 'Active') {
          toothBrushController = 'Deactive';
        }
      } else if (choosen == 'monster') {
        monsterController = 'Active';
        if (toothController == 'Active') {
          toothController = 'Deactive';
        } else if (candyController == 'Active') {
          candyController = 'Deactive';
        } else if (mirrorController == 'Active') {
          mirrorController = 'Deactive';
        } else if (toothBrushController == 'Active') {
          toothBrushController = 'Deactive';
        }
      } else if (choosen == 'candy') {
        candyController = 'Active';
        if (toothController == 'Active') {
          toothController = 'Deactive';
        } else if (monsterController == 'Active') {
          monsterController = 'Deactive';
        } else if (mirrorController == 'Active') {
          mirrorController = 'Deactive';
        } else if (toothBrushController == 'Active') {
          toothBrushController = 'Deactive';
        }
      } else if (choosen == 'mirror') {
        mirrorController = 'Active';
        if (toothController == 'Active') {
          toothController = 'Deactive';
        } else if (monsterController == 'Active') {
          monsterController = 'Deactive';
        } else if (candyController == 'Active') {
          candyController = 'Deactive';
        } else if (toothBrushController == 'Active') {
          toothBrushController = 'Deactive';
        }
      } else if (choosen == 'toothBrush') {
        toothBrushController = 'Active';
        if (toothController == 'Active') {
          toothController = 'Deactive';
        } else if (monsterController == 'Active') {
          monsterController = 'Deactive';
        } else if (candyController == 'Active') {
          candyController = 'Deactive';
        } else if (mirrorController == 'Active') {
          mirrorController = 'Deactive';
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    return AnimatedPadding(
      padding: /* MediaQuery.of(context).viewInsets + */ EdgeInsets
          .only(top: 0),
      duration: Duration(milliseconds: 100),
      curve: Curves.decelerate,
      child: MediaQuery.removeViewInsets(
        removeLeft: true,
        removeTop: true,
        removeRight: true,
        removeBottom: true,
        context: context,
        child: Center(
          child: Container(
            /* width: deviceHeight > 500
                  ? deviceWidth * (987 / 1024)
                  : deviceWidth * (987 / 1024), */
            height:
                deviceHeight > 500 ? deviceHeight * (692 / 768) : deviceHeight,
            child: AspectRatio(
              aspectRatio: 987 / 643,
              child: Stack(
                children: <Widget>[
                  //////////////////////////// Vocab Book bg
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        margin: EdgeInsets.only(
                            top: deviceHeight > 500
                                ? deviceHeight * (692 / 768) * (25 / 692)
                                : deviceHeight * (25 / 692),
                            bottom: deviceHeight > 500
                                ? deviceHeight * (692 / 768) * (25 / 692)
                                : deviceHeight * (25 / 692)),
                        //height: MediaQuery.of(context).size.height,
                        child: Image.asset(
                          'assets/images/vocabulary/bookBg.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                  /////////////////////////////
                  Container(
                    padding: EdgeInsets.only(
                      top: deviceHeight > 500
                          ? deviceHeight * (692 / 768) * (75 / 692)
                          : deviceHeight * (75 / 692),
                      bottom: deviceHeight > 500
                          ? deviceHeight * (692 / 768) * (50 / 692)
                          : deviceHeight * (50 / 692),
                      left: deviceHeight > 500
                          ? deviceHeight * (692 / 768) * (73 / 692)
                          : deviceHeight * (90 / 692),
                      right: deviceHeight > 500
                          ? deviceHeight * (692 / 768) * (60 / 692)
                          : deviceHeight * (60 / 692),
                    ),
                    height: deviceHeight > 500
                        ? deviceHeight * (692 / 768)
                        : deviceHeight,
                    child: AspectRatio(
                      aspectRatio: 987 / 643,
                      child: Stack(
                        children: <Widget>[
                          ////////////////////////////////////////////// Tooth
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.topRight,
                                child: Container(
                                    height: deviceHeight > 500
                                        ? ((deviceHeight * (692 / 768)) -
                                                (deviceHeight *
                                                    2 *
                                                    (692 / 768) *
                                                    (25 / 692))) *
                                            (300 / 643)
                                        : (deviceHeight -
                                                (deviceHeight * (25 / 692))) *
                                            (300 / 643),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Stack(
                                        children: <Widget>[
                                          /////////////////////////////////// Tooth Flare Acter
                                          FlareActor(
                                            'assets/images/vocabulary/VocabStickerCollect.flr',
                                            artboard: 'Tooth',
                                            animation: Provider.of<
                                                                DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .bookStatistic[
                                                            Provider.of<DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .currentKids]
                                                            ['readBook']
                                                        .length >
                                                    0
                                                //////////////////////// lazy to fix
                                                /* && Provider.of<
                                                              DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .bookStatistic[
                                                          Provider.of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .currentKids]
                                                          ['book1'][
                                                          'kidsStickerCollection']
                                                      .contains('tooth')  */
                                                ? toothController
                                                : 'UnCollected',
                                          ),
                                          /////////////////////////////////// Gesture Detector Tooth
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                onTap: _perventMultipleTab
                                                    ? () async {
                                                        setState(() {
                                                          _perventMultipleTab =
                                                              false;
                                                        });

                                                        Timer(
                                                            Duration(
                                                                milliseconds:
                                                                    500),
                                                            () => setState(() =>
                                                                _perventMultipleTab =
                                                                    true));
                                                        chooseSticker('tooth');
                                                      }
                                                    : null,
                                                child: Container(
                                                  height: deviceHeight > 500
                                                      ? ((deviceHeight *
                                                                  (692 / 768)) -
                                                              (deviceHeight *
                                                                  2 *
                                                                  (692 / 768) *
                                                                  (25 / 692))) *
                                                          (160 / 643)
                                                      : (deviceHeight -
                                                              (deviceHeight *
                                                                  (25 / 692))) *
                                                          (160 / 643),
                                                  child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                          color: Colors
                                                              .transparent)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //////////////////////////////////////
                                        ],
                                      ),
                                    ))),
                          ),
                          ////////////////////////////////////////////// Monster
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.topLeft,
                                child: Container(
                                    height: deviceHeight > 500
                                        ? ((deviceHeight * (692 / 768)) -
                                                (deviceHeight *
                                                    2 *
                                                    (692 / 768) *
                                                    (25 / 692))) *
                                            (300 / 643)
                                        : (deviceHeight -
                                                (deviceHeight * (25 / 692))) *
                                            (300 / 643),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Stack(
                                        children: <Widget>[
                                          /////////////////////////////////// Flare Acter Monster
                                          FlareActor(
                                            'assets/images/vocabulary/VocabStickerCollect.flr',
                                            artboard: 'Monster',
                                            animation: Provider.of<
                                                                DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .bookStatistic[
                                                            Provider.of<DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .currentKids]
                                                            ['readBook']
                                                        .length >
                                                    0
                                                //////////////////////// lazy to fix
                                                /* && Provider.of<
                                                              DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .bookStatistic[
                                                          Provider.of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .currentKids]
                                                          ['book1'][
                                                          'kidsStickerCollection']
                                                      .contains('monster')  */
                                                ? monsterController
                                                : 'UnCollected',
                                          ),
                                          /////////////////////////////////// Gesture Detector Monster
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                onTap: _perventMultipleTab
                                                    ? () async {
                                                        setState(() {
                                                          _perventMultipleTab =
                                                              false;
                                                        });

                                                        Timer(
                                                            Duration(
                                                                milliseconds:
                                                                    500),
                                                            () => setState(() =>
                                                                _perventMultipleTab =
                                                                    true));
                                                        chooseSticker(
                                                            'monster');
                                                      }
                                                    : null,
                                                child: Container(
                                                  height: deviceHeight > 500
                                                      ? ((deviceHeight *
                                                                  (692 / 768)) -
                                                              (deviceHeight *
                                                                  2 *
                                                                  (692 / 768) *
                                                                  (25 / 692))) *
                                                          (160 / 643)
                                                      : (deviceHeight -
                                                              (deviceHeight *
                                                                  (25 / 692))) *
                                                          (160 / 643),
                                                  child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                          color: Colors
                                                              .transparent)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //////////////////////////////////////
                                        ],
                                      ),
                                    ))),
                          ),

                          ////////////////////////////////////////////// Mirror
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.bottomLeft,
                                child: Container(
                                    height: deviceHeight > 500
                                        ? ((deviceHeight * (692 / 768)) -
                                                (deviceHeight *
                                                    2 *
                                                    (692 / 768) *
                                                    (25 / 692))) *
                                            (300 / 643)
                                        : (deviceHeight -
                                                (deviceHeight * (25 / 692))) *
                                            (300 / 643),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Stack(
                                        children: <Widget>[
                                          ////////////////////////////////////// Flare Acter Mirror
                                          FlareActor(
                                            'assets/images/vocabulary/VocabStickerCollect.flr',
                                            artboard: 'Mirror',
                                            animation: Provider.of<
                                                                DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .bookStatistic[
                                                            Provider.of<DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .currentKids]
                                                            ['readBook']
                                                        .length >
                                                    0
                                                //////////////////////// lazy to fix
                                                /* && Provider.of<
                                                              DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .bookStatistic[
                                                          Provider.of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .currentKids]
                                                          ['book1'][
                                                          'kidsStickerCollection']
                                                      .contains('mirror')  */
                                                ? mirrorController
                                                : 'UnCollected',
                                          ),
                                          /////////////////////////////////// Gesture Detector Mirror
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                onTap: _perventMultipleTab
                                                    ? () async {
                                                        setState(() {
                                                          _perventMultipleTab =
                                                              false;
                                                        });

                                                        Timer(
                                                            Duration(
                                                                milliseconds:
                                                                    500),
                                                            () => setState(() =>
                                                                _perventMultipleTab =
                                                                    true));
                                                        chooseSticker('mirror');
                                                      }
                                                    : null,
                                                child: Container(
                                                  height: deviceHeight > 500
                                                      ? ((deviceHeight *
                                                                  (692 / 768)) -
                                                              (deviceHeight *
                                                                  2 *
                                                                  (692 / 768) *
                                                                  (25 / 692))) *
                                                          (160 / 643)
                                                      : (deviceHeight -
                                                              (deviceHeight *
                                                                  (25 / 692))) *
                                                          (160 / 643),
                                                  child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                          color: Colors
                                                              .transparent)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //////////////////////////////////////
                                        ],
                                      ),
                                    ))),
                          ),
                          ////////////////////////////////////////////// Candy
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.bottomRight,
                                child: Container(
                                    height: deviceHeight > 500
                                        ? ((deviceHeight * (692 / 768)) -
                                                (deviceHeight *
                                                    2 *
                                                    (692 / 768) *
                                                    (25 / 692))) *
                                            (300 / 643)
                                        : (deviceHeight -
                                                (deviceHeight * (25 / 692))) *
                                            (300 / 643),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Stack(
                                        children: <Widget>[
                                          /////////////////////////////////// Flare Acter Candy
                                          FlareActor(
                                            'assets/images/vocabulary/VocabStickerCollect.flr',
                                            artboard: 'Candy',
                                            animation: Provider.of<
                                                                DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .bookStatistic[
                                                            Provider.of<DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .currentKids]
                                                            ['readBook']
                                                        .length >
                                                    0
                                                //////////////////////// lazy to fix
                                                /* && Provider.of<
                                                              DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .bookStatistic[
                                                          Provider.of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .currentKids]
                                                          ['book1'][
                                                          'kidsStickerCollection']
                                                      .contains('candy')  */
                                                ? candyController
                                                : 'UnCollected',
                                          ),
                                          /////////////////////////////////// Gesture Detector Candy
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                onTap: _perventMultipleTab
                                                    ? () async {
                                                        setState(() {
                                                          _perventMultipleTab =
                                                              false;
                                                        });

                                                        Timer(
                                                            Duration(
                                                                milliseconds:
                                                                    500),
                                                            () => setState(() =>
                                                                _perventMultipleTab =
                                                                    true));
                                                        chooseSticker('candy');
                                                      }
                                                    : null,
                                                child: Container(
                                                  height: deviceHeight > 500
                                                      ? ((deviceHeight *
                                                                  (692 / 768)) -
                                                              (deviceHeight *
                                                                  2 *
                                                                  (692 / 768) *
                                                                  (25 / 692))) *
                                                          (160 / 643)
                                                      : (deviceHeight -
                                                              (deviceHeight *
                                                                  (25 / 692))) *
                                                          (160 / 643),
                                                  child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                          color: Colors
                                                              .transparent)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //////////////////////////////////////
                                        ],
                                      ),
                                    ))),
                          ),
                          ////////////////////////////////////////////// ToothBrush
                          Positioned.fill(
                            child: Align(
                                alignment: Alignment.topCenter,
                                child: Container(
                                    margin: EdgeInsets.only(
                                      top: deviceHeight > 500
                                          ? deviceHeight *
                                              (692 / 768) *
                                              (60 / 692)
                                          : deviceHeight * (60 / 692),
                                    ),
                                    height: deviceHeight > 500
                                        ? ((deviceHeight * (692 / 768)) -
                                                (deviceHeight *
                                                    2 *
                                                    (692 / 768) *
                                                    (25 / 692))) *
                                            (300 / 643)
                                        : (deviceHeight -
                                                (deviceHeight * (25 / 692))) *
                                            (300 / 643),
                                    child: AspectRatio(
                                      aspectRatio: 1,
                                      child: Stack(
                                        children: <Widget>[
                                          ///////////////////////////////////// Flare Acter ToothBrush
                                          FlareActor(
                                            'assets/images/vocabulary/VocabStickerCollect.flr',
                                            artboard: 'ToothBrush',
                                            animation: Provider.of<
                                                                DataProvider>(
                                                            context,
                                                            listen: false)
                                                        .bookStatistic[
                                                            Provider.of<DataProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .currentKids]
                                                            ['readBook']
                                                        .length >
                                                    0
                                                //////////////////////// lazy to fix
                                                /* && Provider.of<
                                                              DataProvider>(
                                                          context,
                                                          listen: false)
                                                      .bookStatistic[
                                                          Provider.of<DataProvider>(
                                                                  context,
                                                                  listen: false)
                                                              .currentKids]
                                                          ['book1'][
                                                          'kidsStickerCollection']
                                                      .contains('toothBrush')   */
                                                ? toothBrushController
                                                : 'UnCollected',
                                          ),
                                          /////////////////////////////////// Gesture Detector ToothBrush
                                          Positioned.fill(
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: GestureDetector(
                                                onTap: _perventMultipleTab
                                                    ? () async {
                                                        setState(() {
                                                          _perventMultipleTab =
                                                              false;
                                                        });

                                                        Timer(
                                                            Duration(
                                                                milliseconds:
                                                                    500),
                                                            () => setState(() =>
                                                                _perventMultipleTab =
                                                                    true));
                                                        chooseSticker(
                                                            'toothBrush');
                                                      }
                                                    : null,
                                                child: Container(
                                                  height: deviceHeight > 500
                                                      ? ((deviceHeight *
                                                                  (692 / 768)) -
                                                              (deviceHeight *
                                                                  2 *
                                                                  (692 / 768) *
                                                                  (25 / 692))) *
                                                          (160 / 643)
                                                      : (deviceHeight -
                                                              (deviceHeight *
                                                                  (25 / 692))) *
                                                          (160 / 643),
                                                  child: AspectRatio(
                                                      aspectRatio: 1,
                                                      child: Container(
                                                          color: Colors
                                                              .transparent)),
                                                ),
                                              ),
                                            ),
                                          ),
                                          //////////////////////////////////////
                                        ],
                                      ),
                                    ))),
                          ),
                          //////////////////////////////////////////////////
                        ],
                      ),
                    ),
                  ),

                  //////////////////////////// close Btn
                  Positioned.fill(
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        margin: EdgeInsets.only(
                          left: deviceHeight > 500
                              ? deviceHeight *
                                  (692 / 768) *
                                  (3014 / 1929) *
                                  (82 / 100)
                              : deviceHeight * (3014 / 1929) * (83 / 100),
                        ),
                        child: GestureDetector(
                            onTap: _perventMultipleTab
                                ? () async {
                                    setState(() {
                                      _perventMultipleTab = false;
                                    });

                                    Timer(
                                        Duration(seconds: 1),
                                        () => setState(
                                            () => _perventMultipleTab = true));
                                    Provider.of<AudioProvider>(context,
                                            listen: false)
                                        .playSoundEffect("click3", 1.0);
                                    Navigator.pop(context);
                                  }
                                : null,
                            child: Container(
                              height: deviceHeight > 500
                                  ? deviceHeight * (692 / 768) * (80 / 692)
                                  : deviceHeight * (692 / 768) * (100 / 692),
                              child: Image.asset(
                                'assets/images/vocabulary/closeBtn.png',
                                fit: BoxFit.contain,
                              ),
                            )),
                      ),
                    ),
                  ),
                  //////////////////////////////////////// Next & Back Navigate Btn
                  //// hide navigat Btn if only have 1 book
                  Provider.of<DataProvider>(context, listen: false)
                              .bookStatistic[Provider.of<DataProvider>(context,
                                      listen: false)
                                  .currentKids]['readBook']
                              .length >
                          1
                      ? Positioned.fill(
                          child: Align(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                ////////////////////// Back Btn

                                Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * (692 / 768) * (80 / 692)
                                      : deviceHeight *
                                          (692 / 768) *
                                          (100 / 692),
                                  child: Image.asset(
                                    'assets/images/vocabulary/back.png',
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(
                                  width: deviceHeight > 500
                                      ? deviceHeight /*  *
                                    (692 / 768)  */
                                          *
                                          (3014 / 1929) *
                                          (67 / 100)
                                      : deviceHeight *
                                          (3014 / 1929) *
                                          (76 / 100),
                                ),
                                //////////////////////// Next Btn
                                Container(
                                  height: deviceHeight > 500
                                      ? deviceHeight * (692 / 768) * (80 / 692)
                                      : deviceHeight *
                                          (692 / 768) *
                                          (100 / 692),
                                  child: Image.asset(
                                    'assets/images/vocabulary/next.png',
                                    fit: BoxFit.contain,
                                  ),
                                )
                              ],
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
