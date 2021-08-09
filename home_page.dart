import 'package:flutter/material.dart';

import 'swipe_screen.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/searching-screen';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow,
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(
            'What are you looking for?',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          SizedBox(height: 22),
          _buildButton(context),
        ]),
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      child: ElevatedButton(
        child: Container(
          padding: EdgeInsets.all(15),
          child: Text('Jokes', style: TextStyle(color: Colors.black)),
        ),
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Colors.yellow.shade600),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
          ),
        ),
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => SwipeScreen()),
        ),
      ),
    );
  }
}
