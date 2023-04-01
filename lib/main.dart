import 'dart:math';

import 'package:flutter/material.dart';
import 'package:jokee_app_flutter/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'widgets/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jokee App',
      debugShowCheckedModeBanner: false,
      theme: ThemeUtil.defaultTheme,
      home: JokeScreen(),
    );
  }
}

class JokeScreen extends StatefulWidget {
  @override
  _JokeScreenState createState() => _JokeScreenState();
}

class _JokeScreenState extends State<JokeScreen> {
  final List<String> _jokes = [
    'A child asked his father, "How were people born?" So his father said, "Adam and Eve made babies, then their babies became adults and made babies, and so on." The child then went to his mother, asked her the same question and she told him, "We were monkeys then we evolved to become like we are now." The child ran back to his father and said, "You lied to me!" His father replied, "No, your mom was talking about her side of the family."',
    'Teacher: "Kids,what does the chicken give you?" Student: "Meat!" Teacher: "Very good! Now what does the pig give you?" Student: "Bacon!" Teacher: "Great! And what does the fat cow give you?" Student: "Homework!"',
    'The teacher asked Jimmy, "Why is your cat at school today Jimmy?" Jimmy replied crying, "Because I heard my daddy tell my mommy, \'I am going to eat that pussy once Jimmy leaves for school today!\'"',
    'A housewife, an accountant and a lawyer were asked "How much is 2+2?" The housewife replies: "Four!". The accountant says: "I think it\'s either 3 or 4. Let me run those figures through my spreadsheet one more time." The lawyer pulls the drapes, dims the lights and asks in a hushed voice, "How much do you want it to be?"',
  ];

  bool vote = true;
  String _currentJoke = '';
  int _currentJokeIndex = -1;

  @override
  void initState() {
    super.initState();
    _showRandomJoke();
  }

  Future<void> _showRandomJoke() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<int> usedIndexes = prefs.containsKey('usedIndexes')
        ? prefs.getStringList('usedIndexes')!.map(int.parse).toList()
        : [];

    List<int> availableIndexes = List.generate(_jokes.length, (index) => index)
        .where((index) => !usedIndexes.contains(index))
        .toList();


    if (availableIndexes.isEmpty || vote == false) {
      setState(() {
        _currentJoke = "That's all the jokes for today! Come back another day!";
      });
      return;
    }
    

    int randomIndex =
        availableIndexes[Random().nextInt(availableIndexes.length)];

    setState(() {
      _currentJoke = _jokes[randomIndex];
      _currentJokeIndex = randomIndex;
    });
  }

  void _vote(bool like) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    List<int> usedIndexes = prefs.containsKey('usedIndexes')
        ? prefs.getStringList('usedIndexes')!.map(int.parse).toList()
        : [];

    if (_currentJokeIndex != -1 && !usedIndexes.contains(_currentJokeIndex)) {
      usedIndexes.add(_currentJokeIndex);
      prefs.setStringList(
          'usedIndexes', usedIndexes.map((e) => e.toString()).toList());
      if (like) {
        prefs.setInt('likedJokes', prefs.getInt('likedJokes') ?? 0 + 1);
      } else {
        prefs.setInt('dislikedJokes', prefs.getInt('dislikedJokes') ?? 0 + 1);
      }
    }

    _showRandomJoke();
  }

  Widget button() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: vote == false ? Color.fromARGB(255, 213, 213, 213) :ColorUtil.blue,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            padding: const EdgeInsets.all(10),
          ),
          onPressed: () {
            
            setState(() {
              vote = false;
            });
            _vote(true);
          },
          child: const FittedBox(
            child: Text(
              '  This is Funny!  ',
              style: TextStyle(
                color: ColorUtil.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
        SizedBox(width: 20),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            primary: vote == false ? Color.fromARGB(255, 213, 213, 213):ColorUtil.green,
            elevation: 0,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
            ),
            padding: const EdgeInsets.all(10),
          ),
          onPressed: () => _vote(false),
          child: const FittedBox(
            child: Text(
              'This is not funny.',
              style: TextStyle(
                color: ColorUtil.white,
                fontSize: 14,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget content() {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Text(
        _currentJoke,
        style: const TextStyle(
          color: ColorUtil.black,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            JokeHeader(),
            JokeTitle(),
            SizedBox(height: 40),
            Expanded(child: content()),
            //Button
            button(),
            SizedBox(
              height: 40,
            ),
            Divider(
              color: ColorUtil.grey,
            ),
            JokeFooter(),
          ],
        ),
      ),
    );
  }
}
