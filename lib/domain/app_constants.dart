import 'package:tithe_box/domain/models/models.dart';

const kPadding = 10.0;
const kAnimationDuration = Duration(milliseconds: 200);

class Data {
  static List<StartVerseModel> startVerseData = [
    StartVerseModel(
      verse: 'Leviticus 27:30',
      reading: 'A tithe of everything from the land, whether grain from the soil or fruit from the trees, belongs to the Lord: it is holy to the Lord.',
    ),
    StartVerseModel(
      verse: 'Malachi 3:10',
      reading: 'For sure, I tell you, anyone who gives a cup of cold water to one of these little ones because he follows Me, will not lose his reward.',
    ),
    StartVerseModel(
      verse: 'Deuteronomy 8:18',
      reading: 'But remember the Lord your God. For it is He who is giving you power to become rich.',
    ),
  ];
}

const String defaultText = 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.';