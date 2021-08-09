import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tcard/tcard.dart';

import 'sentence.dart';

class SwipeScreen extends StatefulWidget {
  SwipeScreen({Key? key}) : super(key: key);

  @override
  _SwipeScreenState createState() => _SwipeScreenState();
}

class _SwipeScreenState extends State<SwipeScreen> {
  TCardController _controller = TCardController(); // controller for tcard

  List<Sentence> _allMySentences = []; // all jokes

  List<Widget> _allJokeCards = []; // all joke cards

  @override
  void initState() {
    super.initState();

    getAllMySentences(); // initialize all sentences from json
  }

  void getAllMySentences() async {
    print('INIT_ get all jokes');
    // SET empty list to fill with all jokes from json
    final _sentences = <Sentence>[];

    try {
      // UNPACK the json file
      final _jsonJokes = await rootBundle
          .loadString('assets/data/jokes.json')
          .then((value) => jsonDecode(value));

      // LOOP through the unpacked json file and add all jokes
      // __ to empty joke list, with Joke model
      for (final _item in _jsonJokes) {
        _sentences.add(Sentence.fromJson(_item));
      }

      // SET the filled json jokes list to '_allMySentences' empty list
      setState(() => _allMySentences = _sentences);

      await loadCards(); // create cardList from AllJokeList

    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> loadCards() async {
    print('INIT_ load all cards from all jokes');

    _allJokeCards.clear();

    _allJokeCards = List.generate(
      _allMySentences.length, // use length of allJokes
      (int index) {
        // for each index, create a container/joke
        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: Colors.purple,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).shadowColor,
                  spreadRadius: 1.0,
                  blurRadius: 3.0,
                  offset: Offset(0, 2),
                )
              ]),
          child: Text(
            // use index to get the correct content/type
            '${_allMySentences[index].content}',
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        );
      },
    );

    _allJokeCards.shuffle(); // randomize the list of cards
  }

  void reloadCards() async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('pressed stuff');
        },
        tooltip: 'Next Joke',
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  Widget _body(BuildContext context) {
    debugPrint('rebuild _body');

    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.8,
        child: _allJokeCards.isNotEmpty
            // check if not empty because it needs a few seconds to load from jokes to cards
            ? _tCard()
            : CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation(Colors.white),
              ),
      ),
    );
  }

  Widget _tCard() {
    debugPrint('rebuild _tCard');

    // build tCard from the package
    return TCard(
      cards: _allJokeCards,
      controller: _controller,
      onForward: (index, info) {
        // _index = index;
        print(info.direction);
        // setState(() {});
      },
      onBack: (index, info) {
        // _index = index;
        // setState(() {});
      },
      onEnd: () async {
        print('end');
        await loadCards().whenComplete(() => _controller.reset());
      },
    );
  }
}
