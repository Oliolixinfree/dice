import 'dart:math';

import 'package:flutter/material.dart';

class DiceScreen extends StatefulWidget {
  const DiceScreen({super.key});

  @override
  State<DiceScreen> createState() => _DiceScreenState();
}

class _DiceScreenState extends State<DiceScreen> {
  bool roll = false;
  int score = 0;

  final Map<String, int> diceMap = {
    'dice/dice1.png': 1,
    'dice/dice2.png': 2,
    'dice/dice3.png': 3,
    'dice/dice4.png': 4,
    'dice/dice5.png': 5,
    'dice/dice6.png': 6,
  };

  Map<String, int> playingDice = {};

  List<Image> myDice = [];

  Random random = Random();

  @override
  void initState() {
    super.initState();

    playingDice.addAll(diceMap);
    myDice = [
      Image.asset('dice/dice1.png'),
      Image.asset('dice/dice1.png'),
    ];
  }

  void rollDice() {
    setState(() {
      roll = true;
    });

    myDice = [];

    String? firstDice;
    String? secondDice;

    if (roll) {
      firstDice =
          playingDice.keys.elementAt(random.nextInt(playingDice.length));
      secondDice =
          playingDice.keys.elementAt(random.nextInt(playingDice.length));
    }

    myDice.add(Image.asset(firstDice!));
    myDice.add(Image.asset(secondDice!));

    score = diceMap[firstDice]! + diceMap[secondDice]!;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: 200,
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: myDice.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(10),
                  child: myDice[index],
                );
              },
            ),
          ),
          roll
              ? Text(
                  'Score: $score',
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 30,
                  ),
                )
              : Container(
                  height: 43,
                ),
          ElevatedButton(
            onPressed: rollDice,
            child:  Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'roll the dice'.toUpperCase(),
                style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 25),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
