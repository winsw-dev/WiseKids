import 'dart:async';
import 'dart:ui';

import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unity_widget/flutter_unity_widget.dart';
import 'package:provider/provider.dart';
import '../provider/dataProvider.dart';

import '../widget/slide_popup_dialog_read.dart' as readDialog;
import '../widget/slide_popup_dialog_arInteractive.dart' as arInteractiveDialog;

import 'home.dart';
import './stickerCollected.dart';

class UnityARBook extends StatefulWidget {
  @override
  _UnityARBookState createState() => _UnityARBookState();
}

/* class CustomPopupMenu {
  CustomPopupMenu({this.title, this.scene});

  String title;
  int scene;
} */

/* List<CustomPopupMenu> choices = <CustomPopupMenu>[
  CustomPopupMenu(title: 'AR World Map', scene: 0),
  CustomPopupMenu(title: 'Face Mesh', scene: 1),
  CustomPopupMenu(title: 'Check Support', scene: 2),
  CustomPopupMenu(title: 'Camera Image', scene: 3),
  CustomPopupMenu(title: 'Environment Probes', scene: 4),
  CustomPopupMenu(title: 'AR Core Face Regions', scene: 5),
  CustomPopupMenu(title: 'ARKit Face Blend Shapes', scene: 6),
  CustomPopupMenu(title: 'Face Pose', scene: 7),
  CustomPopupMenu(title: 'Human Body Tracking 2D', scene: 8),
  CustomPopupMenu(title: 'Human Body Tracking 3D', scene: 9),
  CustomPopupMenu(title: 'Human Segmentation Images', scene: 10),
  CustomPopupMenu(title: 'Image Tracking', scene: 11),
  CustomPopupMenu(title: 'Light Estimation', scene: 12),
  CustomPopupMenu(title: 'Object Tracking', scene: 13),
  CustomPopupMenu(title: 'Feathered planes', scene: 14),
  CustomPopupMenu(title: 'Toggle Plane Detection', scene: 15),
  CustomPopupMenu(title: 'Scale', scene: 16),
  CustomPopupMenu(title: 'Simple AR', scene: 17),
]; */

class _UnityARBookState extends State<UnityARBook> {
  static final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>();
  UnityWidgetController _unityWidgetController;
  //double _sliderValue = 0.0;

  ///////////// disable debuging in release mode
  bool debugingMode = !bool.fromEnvironment("dart.vm.product");
  bool objectPlaced = !bool.fromEnvironment("dart.vm.product");
  /////////////////////////////////

  bool _perventMultipleTab = true;

  //////////////////////////////////// read time
  var watch = Stopwatch();

  void _showFinishReadDialog() {
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

    if (Provider.of<DataProvider>(context, listen: false)
            .bookStatistic[Provider.of<DataProvider>(context, listen: false)
                .currentKids]['readBook']
            .length >
        0) {
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => StickerCollected(),
        ),
      );
    }
  }

  void _showArInteractiveDialog() {
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
              .setInputSubtitle('Todd likes candy.');
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad told Todd to brush her teeth after she ate candy.');
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd brushed her teeth.');
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('But she ate candies before her bedtime.');
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, Todd slept with candy in her mouth.');
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('She dreamed about the candy land.');
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd walked around and ate candies.');
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd felt pain in her mouth.');
        } else if (page == 9) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'She looked at the mirror and opened her mouth.');
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Something moved in her mouth, Todd screamed.');
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd tried to pick them out but she couldn\'t.');
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Could anyone please help Todd?');
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There were ten candy monsters in Todd\'s mouth.');
          _showArInteractiveDialog();
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Candy monsters left, but her teeth decayed.');
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd woke up and felt pain in her teeth then she cried.');
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad came to see Todd.');
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad saw candy on Todd\'s bed.');
        } else if (page == 18) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('He knew that Todd ate candies before sleep.');
        } else if (page == 19) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad took Todd to see the dentist.');
        } else if (page == 20) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('The dentist treated Todd\'s teeth.');
        } else if (page == 21) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dentist told her not to eat dessert too much and brushed her teeth after eating twice a day.');
        } else if (page == 22) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd promised to her dad.');
        } else if (page == 23) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd brushed her teeth twice a day and she won\'t eat candy before sleep again.');
        } else if (page == 24) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd now has clean white teeth and never has a toothache again.');
        }
      }

      //// Content Level == Easy
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          2) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd likes to eat dessert everyday.');
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad always told Todd to brush her teeth.');
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd brushed her teeth twice a day. But she often ate candies before her bedtime.');
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, Todd slept with candy in her mouth. She dreamed about the candy land.');
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd walked around and ate candies happily.');
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Suddenly, Todd felt pain in her mouth. She looked at the mirror and opened her mouth.');
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Something was moving in her mouth, Todd screamed.');
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd tried to pick them out but she couldn\'t. Could anyone please help Todd?');
        } else if (page == 9) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There were ten candy monsters in Todd\'s mouth.');
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters were gone but her teeth decayed.');
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd woke up and felt pain in her teeth then she cried.');
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad came to see Todd.');
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He saw candy on Todd\'s bed, then he knew that Todd ate candies before sleep.');
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad took Todd to see the dentist.');
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist treated Todd\'s teeth and told her not to eat dessert too much and brush her teeth twice a day');
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd sincerely promised to her dad that she will brush her teeth twice a day.');
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd now has clean white teeth and never has a toothache again');
        }
      }

      //// Content Level == Normal
      if (page == 1) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Todd likes to eat dessert. Candy is her favourite.');
      } else if (page == 2) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Dad always tells Todd to brush her teeth after eating desserts.');
      } else if (page == 3) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Todd brushes her teeth twice a day. But Todd has a secret. She often eats candies before her bedtime.');
      } else if (page == 4) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'One night, Todd sleeps with candy in her mouth. She dreams about the candy town.');
      } else if (page == 5) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            '"Wow, there are candies everywhere!" said Todd. Todd walks around and eats candies happily.');
      } else if (page == 6) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Suddenly, Todd feels pain in her mouth. She looks at the mirror and opens her mouth.');
      } else if (page == 7) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Something is moving in her mouth. "ahh, candy monster" screamed Todd.');
      } else if (page == 8) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Todd tries to pick them out but she can\'t. Could anyone please help Todd?');
      } else if (page == 9) {
        _showArInteractiveDialog();
        Provider.of<DataProvider>(context, listen: false)
            .setInputSubtitle('There are ten candy monsters in Todd\'s mouth.');
      } else if (page == 10) {
        Provider.of<DataProvider>(context, listen: false)
            .setInputSubtitle('Candy monsters are gone but her teeth decayed.');
      } else if (page == 11) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Todd wakes up and feels pain in her teeth then she cries.');
      } else if (page == 12) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Dad comes to see Todd. He sees candy on Todd\'s bed then he knows that Todd secretly eats candies before sleep');
      } else if (page == 13) {
        Provider.of<DataProvider>(context, listen: false)
            .setInputSubtitle('Dad takes Todd to see the dentist.');
      } else if (page == 14) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'The dentist treats Todd\'s teeth and tells her not to eat dessert too much and brush her teeth after eating or twice a day.');
      } else if (page == 15) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Todd sincerely promises to her dad that she will brush her teeth twice a day and she won\'t eat candy before sleep again.');
      } else if (page == 16) {
        Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
            'Todd now has a clean white teeth and never has toothache again');
      }

      //// Content Level == Hard
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          4) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There was a little girl named Todd, she likes to eat dessert everyday. Candy was one of her favourites.');
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Her dad was really worried about Todd. He always told Todd to brush her teeth after eating desserts.');
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd usually brushed her teeth twice a day, but Todd had a secret, she often ate candies before her bedtime.');
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night Todd was sleeping in her bed with candy in her mouth, she dreamed that she went to play in the candy land.');
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd was looking around the candy land with her sparkle eyes, she wandered around the candy land happily.');
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '"Wow, there were candies everywhere!" Todd was surprised.');
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd ate candies in her hand as much as she wanted. Todd loved this place so much and felt very happy.');
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'While Todd was eating candies, she felt pain in her mouth. Suddenly, She saw the candy house.');
        } else if (page == 9) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'She went to see the mirror at the house. Todd looked at the mirror and opened her mouth.');
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd was really shocked. There was something moving in her mouth. "Ahh ! , candy monsters" screamed Todd.');
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd tried to pick them out with her fingers but she couldn\'t. Could anyone please help Todd?');
        } else if (page == 12) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd found that there were ten candy monsters in Todd\'s mouth.');
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters were gone but her teeth decayed.');
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd woke up and felt pain in her teeth then she cried.');
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad came to look after Todd anxiously, he saw candy on Todd\'s bed then he knew that Todd secretly ate candies before sleep');
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad took Todd to see the dentist, the next morning.');
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist checked and treated Todd\'s teeth.');
        } else if (page == 18) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'She told her not to eat dessert too much, brushed her teeth after eating twice a day.');
        } else if (page == 19) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd sincerely promised to her dad that she will brush her teeth twice a day and she won\'t eat candy before sleep again.');
        } else if (page == 20) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd now has clean white teeth and never has a toothache again.');
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
              .setInputSubtitle('Todd likes candy.');
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad told Todd to brush his teeth after he ate candy.');
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd brushed his teeth.');
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('But he ate candies before his bedtime.');
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, Todd slept with candy in his mouth.');
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('He dreamed about the candy land.');
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd walked around and ate candies.');
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd felt pain in his mouth.');
        } else if (page == 9) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He looked at the mirror and opened his mouth.');
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Something moved in his mouth, Todd screamed.');
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd tried to pick them out but he couldn\'t.');
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Could anyone please help Todd?');
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There were ten candy monsters in Todd\'s mouth.');
          _showArInteractiveDialog();
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Candy monsters left, but his teeth decayed.');
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd woke up and felt pain in his teeth then he cried.');
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad came to see Todd.');
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad saw candy on Todd\'s bed.');
        } else if (page == 18) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('He knew that Todd ate candies before sleep.');
        } else if (page == 19) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad took Todd to see the dentist.');
        } else if (page == 20) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('The dentist treated Todd\'s teeth.');
        } else if (page == 21) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dentist told him not to eat dessert too much and brushed his teeth after eating twice a day.');
        } else if (page == 22) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd promised to his dad.');
        } else if (page == 23) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd brushed his teeth twice a day and he won\'t eat candy before sleep again.');
        } else if (page == 24) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd now has clean white teeth and never has a toothache again.');
        }
      }

      //// Content Level == Easy
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          2) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd likes to eat dessert everyday.');
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad always told Todd to brush his teeth.');
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd brushed his teeth twice a day. But he often ate candies before his bedtime.');
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, Todd slept with candy in his mouth. He dreamed about the candy land.');
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Todd walked around and ate candies happily.');
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Suddenly, Todd felt pain in his mouth. He looked at the mirror and opened his mouth.');
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Something was moving in his mouth, Todd screamed.');
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd tried to pick them out but he couldn\'t. Could anyone please help Todd?');
        } else if (page == 9) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There were ten candy monsters in Todd\'s mouth.');
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters were gone but his teeth decayed.');
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd woke up and felt pain in his teeth then he cried.');
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad came to see Todd.');
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He saw candy on Todd\'s bed, then he knew that Todd ate candies before sleep.');
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad took Todd to see the dentist.');
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist treated Todd\'s teeth and told him not to eat dessert too much and brush his teeth twice a day');
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd sincerely promised to his dad that he will brush his teeth twice a day.');
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd now has clean white teeth and never has a toothache again');
        }
      }

      //// Content Level == Normal
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          3) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd likes to eat dessert. Candy is his favourite.');
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad always tells Todd to brush his teeth after eating desserts.');
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd brushes his teeth twice a day. But Todd has a secret. He often eats candies before his bedtime.');
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night, Todd sleeps with candy in his mouth. He dreams about the candy town.');
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '"Wow, there are candies everywhere!" said Todd. Todd walks around and eats candies happily.');
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Suddenly, Todd feels pain in his mouth. He looks at the mirror and opens his mouth.');
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Something is moving in his mouth. "ahh, candy monster" screamed Todd.');
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd tries to pick them out but he can\'t. Could anyone please help Todd?');
        } else if (page == 9) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There are ten candy monsters in Todd\'s mouth.');
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Candy monsters are gone but his teeth decayed.');
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd wakes up and feels pain in his teeth then he cries.');
        } else if (page == 12) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad comes to see Todd. He sees candy on Todd\'s bed then he knows that Todd secretly eats candies before sleep');
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false)
              .setInputSubtitle('Dad takes Todd to see the dentist.');
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist treats Todd\'s teeth and tells him not to eat dessert too much and brush his teeth after eating or twice a day.');
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd sincerely promises to his dad that he will brush his teeth twice a day and he won\'t eat candy before sleep again.');
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd now has a clean white teeth and never has toothache again');
        }
      }

      //// Content Level == Hard
      if (Provider.of<DataProvider>(context, listen: false).kidsContentLevel[
              Provider.of<DataProvider>(context, listen: false).currentKids] ==
          4) {
        if (page == 1) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'There was a little boy named Todd, he likes to eat dessert everyday. Candy was one of his favourites.');
        } else if (page == 2) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'His dad was really worried about Todd. He always told Todd to brush his teeth after eating desserts.');
        } else if (page == 3) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd usually brushed his teeth twice a day, but Todd had a secret, he often ate candies before his bedtime.');
        } else if (page == 4) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'One night Todd was sleeping in his bed with candy in his mouth, he dreamed that he went to play in the candy land.');
        } else if (page == 5) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd was looking around the candy land with his sparkle eyes, he wandered around the candy land happily.');
        } else if (page == 6) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              '"Wow, there were candies everywhere!" Todd was surprised.');
        } else if (page == 7) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd ate candies in his hand as much as he wanted. Todd loved this place so much and felt very happy.');
        } else if (page == 8) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'While Todd was eating candies, he felt pain in his mouth. Suddenly, He saw the candy house.');
        } else if (page == 9) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'He went to see the mirror at the house. Todd looked at the mirror and opened his mouth.');
        } else if (page == 10) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd was really shocked. There was something moving in his mouth. "Ahh ! , candy monsters" screamed Todd.');
        } else if (page == 11) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd tried to pick them out with his fingers but he couldn\'t. Could anyone please help Todd?');
        } else if (page == 12) {
          _showArInteractiveDialog();
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd found that there were ten candy monsters in Todd\'s mouth.');
        } else if (page == 13) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Candy monsters were gone but his teeth decayed.');
        } else if (page == 14) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd woke up and felt pain in his teeth then he cried.');
        } else if (page == 15) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad came to look after Todd anxiously, he saw candy on Todd\'s bed then he knew that Todd secretly ate candies before sleep');
        } else if (page == 16) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Dad took Todd to see the dentist, the next morning.');
        } else if (page == 17) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'The dentist checked and treated Todd\'s teeth.');
        } else if (page == 18) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'She told him not to eat dessert too much, brushed his teeth after eating twice a day.');
        } else if (page == 19) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd sincerely promised to his dad that he will brush his teeth twice a day and he won\'t eat candy before sleep again.');
        } else if (page == 20) {
          Provider.of<DataProvider>(context, listen: false).setInputSubtitle(
              'Todd now has clean white teeth and never has a toothache again.');
        }
      }
    }

    Provider.of<DataProvider>(context, listen: false).subtitleData();
  }

  @override
  void initState() {
    Provider.of<DataProvider>(context, listen: false).resetSubtitleState();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;

    Provider.of<DataProvider>(context, listen: false).subtitleData();

    ///////////////////// start count read timer
    !watch.isRunning ? watch.start() : null;

    return WillPopScope(
      onWillPop: () async => false,
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
                        ? deviceHeight * (80/768)
                        : deviceHeight * 0.17,
                    child: Image.asset('assets/images/enterBook/homeBtn.png',fit: BoxFit.contain,),
                  ),
                ),
              ),
            ),
            //////////////////////// 3d Btn
            objectPlaced
                ? Positioned.fill(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: GestureDetector(
                        onTap: () {
                          print('tab3D! Send Char == ' +
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
                          );
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
                          child: Image.asset('assets/images/arUI/3dBtn.png'),
                        ),
                      ),
                    ),
                  )
                : Container(),


            //////////////////////// VoiceOver Btn
            Positioned.fill(
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child:Container(
                          margin: EdgeInsets.only(
                            bottom: deviceHeight > 500
                            ? deviceHeight * (140 / 1024) + deviceWidth * 0.015
                            : deviceHeight * (290 / 1024)+ deviceWidth * 0.015,
                            right: deviceHeight > 500
                                ? deviceWidth * 0.02
                                : deviceWidth * 0.02,
                          ),
                          height: deviceHeight > 500
                              ? deviceHeight * (60/768)
                              : deviceHeight * 0.15,
                          child: Image.asset('assets/images/arUI/soundButton.png'),
                        ),),),


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
                                    onTap: backwardPage,
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
                                    onTap: forwardPage,
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

  void reloadSession() {
    objectPlaced = false;
    page = 1;
    subtitleText = '';
    _unityWidgetController.postMessage(
      'SessionReset',
      'ReloadSession',
      '',
    );
  }

  void forwardPage() {
    if (objectPlaced) {
      print('page == ' + page.toString());

      setState(() {
        if (page <= 16) {
          page++;
        }
      });
      ////////////////////////// finished reading
      if (page > 16) {
        _showFinishReadDialog();
        Provider.of<DataProvider>(context, listen: false)
            .finishedReading(watch.elapsed.inSeconds, 'book1');

        !bool.fromEnvironment("dart.vm.product")
            ? print('readedTime == ' + watch.elapsed.inSeconds.toString())
            : null;
      }
      subtite();
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
        subtitleText = "Todd likes to eat dessert. Candy is his favourite.";
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

                          ////////////////// play sound and auto dispose
                          AssetsAudioPlayer.playAndForget(Audio(
                              'assets/ttsAudio/candyMonster/' +
                                  word.toLowerCase().replaceAll(
                                      new RegExp(r'(?:_|[^\w\s])+'), '') +
                                  '.mp3'));
                          //assetsAudioPlayer.play();

                          //////////////////////////////// when finished speaking
                          assetsAudioPlayer.playlistFinished.listen((finished) {
                            Future.delayed(const Duration(milliseconds: 600),
                                () {
                              ///////////////////////// dis highlight word
                              Provider.of<DataProvider>(context, listen: false)
                                  .onTextSelectedFinished();
                              ///////////////////////// enable gesture detection
                              Provider.of<DataProvider>(context, listen: false)
                                  .enableTab();
                            });
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
