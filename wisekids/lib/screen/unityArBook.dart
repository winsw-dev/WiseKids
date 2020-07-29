import 'dart:async';
import 'dart:ui';
import 'dart:io' show Platform;

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';
import '../provider/audioProvider.dart';
import 'package:flutter_tts/flutter_tts.dart';
import '../provider/ttsProvider.dart';
import '../widget/slide_popup_dialog_read.dart' as readDialog;
import '../widget/slide_popup_dialog_arInteractive.dart' as arInteractiveDialog;

import 'home.dart';
import './stickerCollected.dart';

////////////////////////////////////////////////// Capitalize first charecter (to use => .capitalize() after string)
extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${this.substring(1)}";
  }
}

class UnityARBook extends StatefulWidget {
  @override
  _UnityARBookState createState() => _UnityARBookState();
}

class _UnityARBookState extends State<UnityARBook> {
  ////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////

  UnityWidgetController _unityWidgetController;
  //double _sliderValue = 0.0;

  ///////////// disable debuging in release mode
  bool debugingMode = !bool.fromEnvironment("dart.vm.product");
  bool objectPlaced = !bool.fromEnvironment("dart.vm.product");
  /////////////////////////////////

  bool _perventMultipleTab = true;

  //////////////////////////////////// read time
  var watch = Stopwatch();

  void _showFinishReadDialog() async {
    ///////////////////////////// go home
    /* Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => Home(),
      ),
    ); */
    //////////////////////////// show read Dialog
    /* readDialog.showSlideDialog(
      context: context,
      child: Container(),
    ); */
    /* Provider.of<AudioProvider>(context, listen: false).stopCandyMonsterTheme(); */
    if (Provider.of<DataProvider>(context, listen: false)
            .bookStatistic[Provider.of<DataProvider>(context, listen: false)
                .currentKids]['readBook']
            .length >
        0) {
      reloadSession();
      Provider.of<AudioProvider>(context, listen: false)
          .playSoundEffect("achievement1", 0.5);
      /* Provider.of<AudioProvider>(context, listen: false).resumeBgMusic(); */
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => Home(),
        ),
      );
      readDialog.showSlideDialog(
        context: context,
        child: Container(),
      );
    } else {
      //////////////////////////// collected Sticker page
      reloadSession();
      Provider.of<AudioProvider>(context, listen: false).playCongratTheme2();

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StickerCollected(),
        ),
      );
    }
  }

  void _showArInteractiveDialog() {
    Provider.of<AudioProvider>(context, listen: false)
        .playSoundEffect("Select", 1.0);
    arInteractiveDialog.showSlideDialog(
      context: context,
      child: Container(),
    );
  }

  /* CustomPopupMenu _selectedChoices = choices[0];

  void _select(CustomPopupMenu choice) {
    setState(() {
      _selectedChoices = choice;
    });

    print('Selected');

    _unityWidgetController.postMessage(
      'GameManager',
      'LoadGameScene',
      choice.scene.toString(),
    );
  } */

  int page = 1;
  var subtitleText = '';
  void subtite() {
    String kidsName = Provider.of<DataProvider>(context, listen: false)
        .kidsName[Provider.of<DataProvider>(context, listen: false).currentKids]
        .capitalize();
    ///////////////////////// if avatar == girl then use her else use he/him/his (if avatar == cat,boy)
    if (Provider.of<DataProvider>(context, listen: false).avatar[
            Provider.of<DataProvider>(context, listen: false).currentKids] ==
        'girl') {
      ///////////////////////////////////////////// girl avatar use she/her

      //// Content Level == Very Easy
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          1) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('$kidsName likes candy.', true);
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad told $kidsName to brush her teeth after she ate candy.',
              true);
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('$kidsName brushed her teeth.', true);
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'But she ate candies before her bedtime.', true);
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, $kidsName slept with candy in her mouth.', true);
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('She dreamed about the candy land.', true);
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName walked around and ate candies.', true);
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('$kidsName felt pain in her mouth.', true);
        } else if (page == 9) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'She looked at the mirror and opened her mouth.', true);
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Something moved in her mouth, $kidsName screamed.', true);
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName tried to pick them out but she couldn\'t.', true);
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Could anyone please help $kidsName?', true);
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There were ten candy monsters in $kidsName\'s mouth.', false);
          _showArInteractiveDialog();
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters left, but her teeth decayed.', true);
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName woke up and felt pain in her teeth then she cried.',
              true);
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad came to see $kidsName.', true);
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad saw candy on $kidsName\'s bed.', true);
        } else if (page == 18) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He knew that $kidsName ate candies before sleep.', true);
        } else if (page == 19) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad took $kidsName to see the dentist.', true);
        } else if (page == 20) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist treated $kidsName\'s teeth.', true);
        } else if (page == 21) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dentist told her not to eat dessert too much and brushed her teeth after eating twice a day.',
              true);
        } else if (page == 22) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('$kidsName promised to her dad.', true);
        } else if (page == 23) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName brushed her teeth twice a day and she won\'t eat candy before sleep again.',
              true);
        } else if (page == 24) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName now has clean white teeth and never has a toothache again.',
              true);
        }
      }

      //// Content Level == Easy
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          2) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName likes to eat dessert everyday.', true);
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad always told $kidsName to brush her teeth.', true);
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName brushed her teeth twice a day. But she often ate candies before her bedtime.',
              true);
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, $kidsName slept with candy in her mouth. She dreamed about the candy land.',
              true);
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName walked around and ate candies happily.', true);
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Suddenly, $kidsName felt pain in her mouth. She looked at the mirror and opened her mouth.',
              true);
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Something was moving in her mouth, $kidsName screamed.', true);
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName tried to pick them out but she couldn\'t. Could anyone please help $kidsName?',
              true);
        } else if (page == 9) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There were ten candy monsters in $kidsName\'s mouth.', false);
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters were gone but her teeth decayed.', true);
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName woke up and felt pain in her teeth then she cried.',
              true);
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad came to see $kidsName.', true);
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He saw candy on $kidsName\'s bed, then he knew that $kidsName ate candies before sleep.',
              true);
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad took $kidsName to see the dentist.', true);
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist treated $kidsName\'s teeth and told her not to eat dessert too much and brush her teeth twice a day',
              true);
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName sincerely promised to her dad that she will brush her teeth twice a day.',
              true);
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName now has clean white teeth and never has a toothache again',
              true);
        }
      }

      //// Content Level == Normal
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          3) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName likes to eat dessert. Candy is her favourite.', true);
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad always tells $kidsName to brush her teeth after eating desserts.',
              true);
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName brushes her teeth twice a day. But $kidsName has a secret. She often eats candies before her bedtime.',
              true);
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, $kidsName sleeps with candy in her mouth. She dreams about the candy town.',
              true);
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '"Wow, there are candies everywhere!" said $kidsName. $kidsName walks around and eats candies happily.',
              true);
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Suddenly, $kidsName feels pain in her mouth. She looks at the mirror and opens her mouth.',
              true);
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Something is moving in her mouth. "ahh, candy monster" screamed $kidsName.',
              true);
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName tries to pick them out but she can\'t. Could anyone please help $kidsName?',
              true);
        } else if (page == 9) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There are ten candy monsters in $kidsName\'s mouth.', false);
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters are gone but her teeth decayed.', true);
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName wakes up and feels pain in her teeth then she cries.',
              true);
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad comes to see $kidsName. He sees candy on $kidsName\'s bed then he knows that $kidsName secretly eats candies before sleep',
              true);
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad takes $kidsName to see the dentist.', true);
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist treats $kidsName\'s teeth and tells her not to eat dessert too much and brush her teeth after eating or twice a day.',
              true);
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName sincerely promises to her dad that she will brush her teeth twice a day and she won\'t eat candy before sleep again.',
              true);
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName now has a clean white teeth and never has toothache again',
              true);
        }
      }

      //// Content Level == Hard
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          4) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There was a little girl named $kidsName, she likes to eat dessert everyday. Candy was one of her favourites.',
              true);
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Her dad was really worried about $kidsName. He always told $kidsName to brush her teeth after eating desserts.',
              true);
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName usually brushed her teeth twice a day, but $kidsName had a secret, she often ate candies before her bedtime.',
              true);
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night $kidsName was sleeping in her bed with candy in her mouth, she dreamed that she went to play in the candy land.',
              true);
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName was looking around the candy land with her sparkle eyes, she wandered around the candy land happily.',
              true);
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '"Wow, there were candies everywhere!" $kidsName was surprised.',
              true);
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName ate candies in her hand as much as she wanted. $kidsName loved this place so much and felt very happy.',
              true);
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'While $kidsName was eating candies, she felt pain in her mouth. Suddenly, She saw the candy house.',
              true);
        } else if (page == 9) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'She went to see the mirror at the house. $kidsName looked at the mirror and opened her mouth.',
              true);
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName was really shocked. There was something moving in her mouth. "Ahh ! , candy monsters" screamed $kidsName.',
              true);
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName tried to pick them out with her fingers but she couldn\'t. Could anyone please help $kidsName?',
              true);
        } else if (page == 12) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName found that there were ten candy monsters in $kidsName\'s mouth.',
              false);
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters were gone but her teeth decayed.', true);
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName woke up and felt pain in her teeth then she cried.',
              true);
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad came to look after $kidsName anxiously, he saw candy on $kidsName\'s bed then he knew that $kidsName secretly ate candies before sleep',
              true);
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad took $kidsName to see the dentist, the next morning.', true);
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist checked and treated $kidsName\'s teeth.', true);
        } else if (page == 18) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'She told her not to eat dessert too much, brushed her teeth after eating twice a day.',
              true);
        } else if (page == 19) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName sincerely promised to her dad that she will brush her teeth twice a day and she won\'t eat candy before sleep again.',
              true);
        } else if (page == 20) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName now has clean white teeth and never has a toothache again.',
              true);
        }
      }
    } else {
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////
      /////////////////////////////////////////////////////////////////////////////////////////////////////////////
      ///////////////////////////////////////////////////////////////////////////////////////////////////////////// boy avatar use he/him/his

      //// Content Level == Very Easy
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          1) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('$kidsName likes candy.', true);
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad told $kidsName to brush his teeth after he ate candy.',
              true);
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('$kidsName brushed his teeth.', true);
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('But he ate candies before his bedtime.', true);
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, $kidsName slept with candy in his mouth.', true);
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('He dreamed about the candy land.', true);
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName walked around and ate candies.', true);
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('$kidsName felt pain in his mouth.', true);
        } else if (page == 9) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He looked at the mirror and opened his mouth.', true);
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Something moved in his mouth, $kidsName screamed.', true);
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName tried to pick them out but he couldn\'t.', true);
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Could anyone please help $kidsName?', true);
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There were ten candy monsters in $kidsName\'s mouth.', false);
          _showArInteractiveDialog();
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters left, but his teeth decayed.', true);
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName woke up and felt pain in his teeth then he cried.',
              true);
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad came to see $kidsName.', true);
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad saw candy on $kidsName\'s bed.', true);
        } else if (page == 18) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He knew that $kidsName ate candies before sleep.', true);
        } else if (page == 19) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad took $kidsName to see the dentist.', true);
        } else if (page == 20) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist treated $kidsName\'s teeth.', true);
        } else if (page == 21) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dentist told him not to eat dessert too much and brushed his teeth after eating twice a day.',
              true);
        } else if (page == 22) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('$kidsName promised to his dad.', true);
        } else if (page == 23) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName brushed his teeth twice a day and he won\'t eat candy before sleep again.',
              true);
        } else if (page == 24) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName now has clean white teeth and never has a toothache again.',
              true);
        }
      }

      //// Content Level == Easy
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          2) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName likes to eat dessert everyday.', true);
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad always told $kidsName to brush his teeth.', true);
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName brushed his teeth twice a day. But he often ate candies before his bedtime.',
              true);
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, $kidsName slept with candy in his mouth. He dreamed about the candy land.',
              true);
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName walked around and ate candies happily.', true);
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Suddenly, $kidsName felt pain in his mouth. He looked at the mirror and opened his mouth.',
              true);
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Something was moving in his mouth, $kidsName screamed.', true);
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName tried to pick them out but he couldn\'t. Could anyone please help $kidsName?',
              true);
        } else if (page == 9) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There were ten candy monsters in $kidsName\'s mouth.', false);
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters were gone but his teeth decayed.', true);
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName woke up and felt pain in his teeth then he cried.',
              true);
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad came to see $kidsName.', true);
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He saw candy on $kidsName\'s bed, then he knew that $kidsName ate candies before sleep.',
              true);
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad took $kidsName to see the dentist.', true);
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist treated $kidsName\'s teeth and told him not to eat dessert too much and brush his teeth twice a day',
              true);
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName sincerely promised to his dad that he will brush his teeth twice a day.',
              true);
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName now has clean white teeth and never has a toothache again',
              true);
        }
      }

      //// Content Level == Normal
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          3) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName likes to eat dessert. Candy is his favourite.', true);
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad always tells $kidsName to brush his teeth after eating desserts.',
              true);
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName brushes his teeth twice a day. But $kidsName has a secret. He often eats candies before his bedtime.',
              true);
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, $kidsName sleeps with candy in his mouth. He dreams about the candy town.',
              true);
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '"Wow, there are candies everywhere!" said $kidsName. $kidsName walks around and eats candies happily.',
              true);
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Suddenly, $kidsName feels pain in his mouth. He looks at the mirror and opens his mouth.',
              true);
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Something is moving in his mouth. "ahh, candy monster" screamed $kidsName.',
              true);
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName tries to pick them out but he can\'t. Could anyone please help $kidsName?',
              true);
        } else if (page == 9) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There are ten candy monsters in $kidsName\'s mouth.', false);
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters are gone but his teeth decayed.', true);
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName wakes up and feels pain in his teeth then he cries.',
              true);
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad comes to see $kidsName. He sees candy on $kidsName\'s bed then he knows that $kidsName secretly eats candies before sleep',
              true);
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad takes $kidsName to see the dentist.', true);
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist treats $kidsName\'s teeth and tells him not to eat dessert too much and brush his teeth after eating or twice a day.',
              true);
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName sincerely promises to his dad that he will brush his teeth twice a day and he won\'t eat candy before sleep again.',
              true);
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName now has a clean white teeth and never has toothache again',
              true);
        }
      }

      //// Content Level == Hard
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          4) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There was a little boy named $kidsName, he likes to eat dessert everyday. Candy was one of his favourites.',
              true);
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'His dad was really worried about $kidsName. He always told $kidsName to brush his teeth after eating desserts.',
              true);
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName usually brushed his teeth twice a day, but $kidsName had a secret, he often ate candies before his bedtime.',
              true);
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night $kidsName was sleeping in his bed with candy in his mouth, he dreamed that he went to play in the candy land.',
              true);
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName was looking around the candy land with his sparkle eyes, he wandered around the candy land happily.',
              true);
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '"Wow, there were candies everywhere!" $kidsName was surprised.',
              true);
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName ate candies in his hand as much as he wanted. $kidsName loved this place so much and felt very happy.',
              true);
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'While $kidsName was eating candies, he felt pain in his mouth. Suddenly, He saw the candy house.',
              true);
        } else if (page == 9) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He went to see the mirror at the house. $kidsName looked at the mirror and opened his mouth.',
              true);
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName was really shocked. There was something moving in his mouth. "Ahh ! , candy monsters" screamed $kidsName.',
              true);
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName tried to pick them out with his fingers but he couldn\'t. Could anyone please help $kidsName?',
              true);
        } else if (page == 12) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName found that there were ten candy monsters in $kidsName\'s mouth.',
              false);
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters were gone but his teeth decayed.', true);
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName woke up and felt pain in his teeth then he cried.',
              true);
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad came to look after $kidsName anxiously, he saw candy on $kidsName\'s bed then he knew that $kidsName secretly ate candies before sleep',
              true);
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad took $kidsName to see the dentist, the next morning.', true);
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist checked and treated $kidsName\'s teeth.', true);
        } else if (page == 18) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'She told him not to eat dessert too much, brushed his teeth after eating twice a day.',
              true);
        } else if (page == 19) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName sincerely promised to his dad that he will brush his teeth twice a day and he won\'t eat candy before sleep again.',
              true);
        } else if (page == 20) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '$kidsName now has clean white teeth and never has a toothache again.',
              true);
        }
      }
    }

    Provider.of<DataProvider>(context, listen: false).subtitleData();
  }

  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).resetSubtitleState();
    Provider.of<TTSProvider>(context, listen: false).initTts();
    Provider.of<DataProvider>(context, listen: false)
        .getUnityARBookContext(context);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<TTSProvider>(context, listen: false).disposeTTS();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    Provider.of<DataProvider>(context, listen: false).subtitleData();

    ///////////////////// start count read timer
    !watch.isRunning ? watch.start() : null;

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        ////////////////////// avoid bottom notch pading
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: <Widget>[
            Container(
              color: Colors.black,
            ),
            debugingMode
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                          'w' +
                              deviceWidth.toString() +
                              ' * h' +
                              deviceHeight.toString(),
                          style: TextStyle(
                              fontFamily: 'NunitoBold',
                              fontSize: 35,
                              color: Colors.white)),
                    ),
                  )
                : Container(),

            !debugingMode
                ? UnityWidget(
                    onUnityViewCreated: onUnityCreated,
                    isARScene: true,
                    onUnityMessage: onUnityMessage,
                  )
                : Container(),

            //////////////////////////////////////////////////
            /* Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Container(
                  margin: EdgeInsets.only(top: 300),
                  height: 50,
                  width: 50,
                  child: PopupMenuButton<CustomPopupMenu>(
                    elevation: 3.2,
                    color: Colors.white,
                    initialValue: choices[0],
                    onCanceled: () {
                      print('You have not chossed anything');
                    },
                    tooltip: 'This is tooltip',
                    onSelected: _select,
                    itemBuilder: (BuildContext context) {
                      return choices.map((CustomPopupMenu choice) {
                        return PopupMenuItem<CustomPopupMenu>(
                          value: choice,
                          child: Text(choice.title),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ), */
            /////////////////////// home Btn
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: GestureDetector(
                  onTap: _perventMultipleTab
                      ? () async {
                          !debugingMode ? reloadSession() : null;
                          setState(() {
                            _perventMultipleTab = false;
                          });

                          Timer(Duration(seconds: 1),
                              () => setState(() => _perventMultipleTab = true));
                          Provider.of<AudioProvider>(context, listen: false)
                              .playSoundEffect("click3", 1.0);
                          Provider.of<AudioProvider>(context, listen: false)
                              .playCandyMonsterTheme();
                          Navigator.pop(context);
                        }
                      : null,
                  child: Container(
                    margin: EdgeInsets.only(
                      top: deviceHeight > 500
                          ? deviceWidth * 0.02
                          : deviceWidth * 0.02,
                      left: deviceHeight > 500
                          ? deviceWidth * 0.02
                          : deviceWidth * 0.02,
                    ),
                    height: deviceHeight > 500
                        ? deviceHeight * 0.104
                        : deviceHeight * 0.17,
                    child: Image.asset('assets/images/enterBook/homeBtn.png'),
                  ),
                ),
              ),
            ),

            objectPlaced
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          //////////////////////// VoiceOver Btn
                          Consumer<DataProvider>(
                            builder: (context, provider, child) =>
                                GestureDetector(
                              onTap: () {
                                provider.toggleTtsSwitch();
                                Provider.of<AudioProvider>(context,
                                        listen: false)
                                    .playSoundEffect("select", 1.0);
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  top: deviceHeight > 500
                                      ? deviceWidth * 0.02
                                      : deviceWidth * 0.02,
                                  right: deviceHeight > 500
                                      ? deviceWidth * 0.02
                                      : deviceWidth * 0.02,
                                ),
                                height: deviceHeight > 500
                                    ? deviceHeight * 0.104
                                    : deviceHeight * 0.17,
                                child: provider.ttsSwitch
                                    ? Image.asset(
                                        'assets/images/arUI/soundOnButton.png')
                                    : Image.asset(
                                        'assets/images/arUI/soundButton.png'),
                              ),
                            ),
                          ),
                          //////////////////////// 3d Btn

                          /* GestureDetector(
                            onTap: () {
                              /*   print('tab3D! Send Char == ' +
                                  Provider.of<DataProvider>(context, listen: false)
                                      .avatar[Provider.of<DataProvider>(context,
                                          listen: false)
                                      .currentKids]);
                              //////////////////// send selected character message to unity
                              _unityWidgetController.postMessage(
                                'AR Session Origin',
                                'MainCharacterSelected',
                                Provider.of<DataProvider>(context, listen: false)
                                    .avatar[Provider.of<DataProvider>(context,
                                        listen: false)
                                    .currentKids],
                              ); */
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                top: deviceHeight > 500
                                    ? deviceWidth * 0.02
                                    : deviceWidth * 0.02,
                                right: deviceHeight > 500
                                    ? deviceWidth * 0.02
                                    : deviceWidth * 0.02,
                              ),
                              height: deviceHeight > 500
                                  ? deviceHeight * 0.104
                                  : deviceHeight * 0.17,
                              child:
                                  Image.asset('assets/images/arUI/3dBtn.png'),
                            ),
                          ), */
                        ],
                      ),
                    ),
                  )
                : Container(),

            //////////////////////// Subtitle Row
            objectPlaced
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        //alignment: Alignment.center,
                        height: deviceHeight > 500
                            ? deviceHeight * (140 / 1024)
                            : deviceHeight * (290 / 1024),
                        color: Color.fromRGBO(255, 255, 255, 0.93),
                        child: Row(
                          children: <Widget>[
                            //////////////////////// back Btn
                            objectPlaced
                                ? GestureDetector(
                                    onTap: () {
                                      Provider.of<AudioProvider>(context,
                                              listen: false)
                                          .playSoundEffect("select", 1.0);
                                      backwardPage();
                                    },
                                    child: Container(
                                      height: deviceHeight > 500
                                          ? deviceHeight * (140 / 1024) * 0.8
                                          : deviceHeight * (290 / 1024) * 0.8,
                                      child: Image.asset(
                                          'assets/images/arUI/button_book_back.png'),
                                    ),
                                  )
                                : Container(),
                            /* Spacer(), */
                            ///////////////////////////// Subtitle Text
                            Expanded(
                              child: Container(
                                height: double.infinity,
                                /*width: deviceWidth-((deviceHeight * (140 / 1024) * 0.8 * (149/140))*2), */
                                padding: EdgeInsets.only(
                                    top: deviceHeight > 500
                                        ? deviceHeight * (290 / 1024) * 0.06
                                        : deviceHeight * (290 / 1024) * 0.06,
                                    bottom: deviceHeight > 500
                                        ? deviceHeight * (290 / 1024) * 0.06
                                        : deviceHeight * (290 / 1024) * 0.06,
                                    left: deviceHeight > 500
                                        ? deviceHeight * (290 / 1024) * 0.2
                                        : deviceHeight * (290 / 1024) * 0.06,
                                    right: deviceHeight > 500
                                        ? deviceHeight * (290 / 1024) * 0.2
                                        : deviceHeight * (290 / 1024) * 0.06),
                                child: Consumer<DataProvider>(
                                  builder: (context, provider, child) => Wrap(
                                      alignment: WrapAlignment.center,
                                      runAlignment: WrapAlignment.center,
                                      children: provider.subtitleItems),
                                ),
                              ),
                            ),

                            //////////////////////// forward Btn
                            objectPlaced
                                ? GestureDetector(
                                    onTap: () {
                                      Provider.of<AudioProvider>(context,
                                              listen: false)
                                          .playSoundEffect("select", 1.0);
                                      forwardPage();
                                    },
                                    child: Container(
                                      height: deviceHeight > 500
                                          ? deviceHeight * (140 / 1024) * 0.8
                                          : deviceHeight * (290 / 1024) * 0.8,
                                      child: Image.asset(
                                          'assets/images/arUI/button_book_forward.png'),
                                    ),
                                  )
                                : Container(),
                            //////////////////////////
                          ],
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  void reloadSession() async {
    objectPlaced = false;
    page = 1;
    subtitleText = '';
    await _unityWidgetController.postMessage(
      'SessionReset',
      'ReloadSession',
      '',
    );
  }

  void forwardPage() {
    if (objectPlaced) {
      print('page == ' + page.toString());

      int limitedPageFollowContentLevel;

      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          1) {
        limitedPageFollowContentLevel = 24;
      } else if (Provider.of<DataProvider>(context, listen: false)
                  .kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          2) {
        limitedPageFollowContentLevel = 17;
      } else if (Provider.of<DataProvider>(context, listen: false)
                  .kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          3) {
        limitedPageFollowContentLevel = 16;
      } else if (Provider.of<DataProvider>(context, listen: false)
                  .kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          4) {
        limitedPageFollowContentLevel = 20;
      }

      setState(() {
        if (page <= limitedPageFollowContentLevel) {
          page++;
        }
      });
      subtite();
      ////////////////////////// finished reading
      if (page > limitedPageFollowContentLevel) {
        _showFinishReadDialog();
        Provider.of<DataProvider>(context, listen: false)
            .finishedReading(watch.elapsed.inSeconds, 'book1');

        !bool.fromEnvironment("dart.vm.product")
            ? print('readedTime == ' + watch.elapsed.inSeconds.toString())
            : null;
      }

      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          1) {
        if (page == 3 ||
            page == 7 ||
            page == 8 ||
            page == 15 ||
            page == 19 ||
            page == 24) {
          !debugingMode
              ? _unityWidgetController.postMessage(
                  'pageController',
                  'forwardScene',
                  '',
                )
              : null;
        }
      }
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          2) {
        if (page == 3 ||
            page == 5 ||
            page == 6 ||
            page == 11 ||
            page == 14 ||
            page == 17) {
          !debugingMode
              ? _unityWidgetController.postMessage(
                  'pageController',
                  'forwardScene',
                  '',
                )
              : null;
        }
      }
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          3) {
        if (page == 3 ||
            page == 5 ||
            page == 6 ||
            page == 11 ||
            page == 13 ||
            page == 16) {
          !debugingMode
              ? _unityWidgetController.postMessage(
                  'pageController',
                  'forwardScene',
                  '',
                )
              : null;
        }
      }
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          4) {
        if (page == 3 ||
            page == 5 ||
            page == 8 ||
            page == 14 ||
            page == 16 ||
            page == 20) {
          !debugingMode
              ? _unityWidgetController.postMessage(
                  'pageController',
                  'forwardScene',
                  '',
                )
              : null;
        }
      }
    }
  }

  void backwardPage() {
    if (objectPlaced) {
      setState(() {
        if (page > 1) {
          page--;
        }
      });
      subtite();
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          1) {
        if (page == 2 ||
            page == 6 ||
            page == 7 ||
            page == 14 ||
            page == 18 ||
            page == 23) {
          !debugingMode
              ? _unityWidgetController.postMessage(
                  'pageController',
                  'backwardScene',
                  '',
                )
              : null;
        }
      }
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          2) {
        if (page == 2 ||
            page == 4 ||
            page == 5 ||
            page == 10 ||
            page == 13 ||
            page == 16) {
          !debugingMode
              ? _unityWidgetController.postMessage(
                  'pageController',
                  'backwardScene',
                  '',
                )
              : null;
        }
      }
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          3) {
        if (page == 2 ||
            page == 4 ||
            page == 5 ||
            page == 10 ||
            page == 12 ||
            page == 15) {
          !debugingMode
              ? _unityWidgetController.postMessage(
                  'pageController',
                  'backwardScene',
                  '',
                )
              : null;
        }
      }
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          4) {
        if (page == 2 ||
            page == 4 ||
            page == 7 ||
            page == 13 ||
            page == 15 ||
            page == 19) {
          !debugingMode
              ? _unityWidgetController.postMessage(
                  'pageController',
                  'backwardScene',
                  '',
                )
              : null;
        }
      }
    }
  }

  void onUnityMessage(controller, message) {
    if (message == 'Placed object') {
      setState(() {
        objectPlaced = true;
        String kidsName = Provider.of<DataProvider>(context, listen: false)
            .kidsName[
                Provider.of<DataProvider>(context, listen: false).currentKids]
            .capitalize();

        if (Provider.of<DataProvider>(context, listen: false).avatar[
                Provider.of<DataProvider>(context, listen: false)
                    .currentKids] ==
            'girl') {
          if (Provider.of<DataProvider>(context, listen: false)
                      .kidsContentLevel[
                  Provider.of<DataProvider>(context, listen: false)
                      .currentKids] ==
              1) {
            subtitleText = "$kidsName likes candy.";
          } else if (Provider.of<DataProvider>(context, listen: false)
                      .kidsContentLevel[
                  Provider.of<DataProvider>(context, listen: false)
                      .currentKids] ==
              2) {
            subtitleText = "$kidsName likes to eat dessert everyday.";
          } else if (Provider.of<DataProvider>(context, listen: false)
                      .kidsContentLevel[
                  Provider.of<DataProvider>(context, listen: false)
                      .currentKids] ==
              3) {
            subtitleText =
                "$kidsName likes to eat dessert. Candy is her favourite.";
          } else if (Provider.of<DataProvider>(context, listen: false)
                      .kidsContentLevel[
                  Provider.of<DataProvider>(context, listen: false)
                      .currentKids] ==
              4) {
            subtitleText =
                "There was a little girl named $kidsName, she likes to eat dessert everyday. Candy was one of her favourites.";
          }
        } else {
          if (Provider.of<DataProvider>(context, listen: false)
                      .kidsContentLevel[
                  Provider.of<DataProvider>(context, listen: false)
                      .currentKids] ==
              1) {
            subtitleText = "$kidsName likes candy.";
          } else if (Provider.of<DataProvider>(context, listen: false)
                      .kidsContentLevel[
                  Provider.of<DataProvider>(context, listen: false)
                      .currentKids] ==
              2) {
            subtitleText = "$kidsName likes to eat dessert everyday.";
          } else if (Provider.of<DataProvider>(context, listen: false)
                      .kidsContentLevel[
                  Provider.of<DataProvider>(context, listen: false)
                      .currentKids] ==
              3) {
            subtitleText =
                "$kidsName likes to eat dessert. Candy is his favourite.";
          } else if (Provider.of<DataProvider>(context, listen: false)
                      .kidsContentLevel[
                  Provider.of<DataProvider>(context, listen: false)
                      .currentKids] ==
              4) {
            subtitleText =
                "There was a little boy named $kidsName, he likes to eat dessert everyday. Candy was one of his favourites.";
          }
        }
      });
    }
    print('Received message from unity: ${message.toString()}');
  }

  // Callback that connects the created controller to the unity controller
  void onUnityCreated(controller) {
    this._unityWidgetController = controller;
    //////////////////// send selected character message to unity
    _unityWidgetController.postMessage(
      'AR Session Origin',
      'MainCharacterSelected',
      Provider.of<DataProvider>(context, listen: false).avatar[
          Provider.of<DataProvider>(context, listen: false).currentKids],
    );
  }
}

class SubtitleSpeakable extends StatelessWidget {
  const SubtitleSpeakable({
    Key key,
    @required this.word,

    //@required this.textSelectedList,
    @required this.id,
  }) : super(key: key);

  final String word;

  //final List<bool> textSelectedList;
  final int id;

  @override
  Widget build(BuildContext context) {
    final assetsAudioPlayer = AssetsAudioPlayer();

    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<DataProvider>(
        builder: (context, provider, child) => MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
              child: AnimatedContainer(
                duration: Duration(milliseconds: 100),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: provider.textSelected[id]
                      ? Color.fromRGBO(69, 223, 224, 1.0)
                      : Color.fromRGBO(69, 223, 224, 0.0),
                ),
                padding: EdgeInsets.all(
                  deviceHeight > 500
                      ? deviceHeight * (140 / 1024) * 0.020
                      : deviceHeight * (290 / 1024) * 0.020,
                ),
                child: GestureDetector(
                  onTap: Provider.of<DataProvider>(context, listen: false)
                          .allowTab
                      ? () async {
                          //////////////////// highlight word selected
                          Provider.of<DataProvider>(context, listen: false)
                              .onTextSelected(id);

                          /* await assetsAudioPlayer.open(
                      Audio('assets/ttsAudio/candyMonster/level1/'+word.replaceAll(new RegExp(r'(?:_|[^\w\s])+'), '')+'.mp3'),
                    ); */

                          ////////////////// disable tab other word while speaking
                          Provider.of<DataProvider>(context, listen: false)
                              .disableTab();

                          ////////////////// speechTTS sound
                          Provider.of<TTSProvider>(context, listen: false)
                              .speak(word.toLowerCase().replaceAll(
                                  new RegExp(r'(?:_|[^\w\s])+'), ''));

                          ////////////////// play sound and auto dispose
                          /* AssetsAudioPlayer.playAndForget(Audio(
                              'assets/ttsAudio/candyMonster/level1/' +
                                  word.toLowerCase().replaceAll(
                                      new RegExp(r'(?:_|[^\w\s])+'), '') +
                                  '.mp3')); */
                          //assetsAudioPlayer.play();

                          //////////////////////////////// when finished speaking
                          Future.delayed(const Duration(milliseconds: 600), () {
                            ///////////////////////// dis highlight word
                            Provider.of<DataProvider>(context, listen: false)
                                .onTextSelectedFinished();
                            ///////////////////////// enable gesture detection
                            Provider.of<DataProvider>(context, listen: false)
                                .enableTab();
                          });
                        }
                      : () {},
                  child: Text(
                    word,
                    style: TextStyle(
                        fontFamily: 'NunitoBold',
                        fontSize: (() {
                          if (deviceWidth > 1100) {
                            return 28.0;
                          } // Big tablet
                          else if (deviceWidth < 1100 && deviceWidth > 910) {
                            return 23.0;
                          } // normal tablet
                          else if (deviceWidth < 910 && deviceWidth > 800) {
                            return 20.0;
                          } // phone large
                          else if (deviceWidth > 600 && deviceWidth < 800) {
                            return 17.0;
                          } // phone medium
                          else if (deviceWidth < 600) {
                            return 14.5;
                          } // phone small
                        }()),
                        color: provider.textSelected[id]
                            ? Colors.white
                            : Color.fromRGBO(112, 112, 112, 1.00)),
                  ),
                ),
              ),
            ));
  }
}
