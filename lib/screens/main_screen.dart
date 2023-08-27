import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isTurnO = true;
  List<String> xOrOList = ['', '', '', '', '', '', '', '', ''];
  int filledBoxes = 0;
  bool gameHasResult = false;
  int scoreX = 0;
  int scoreO = 0;
  String winnerTitle = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[900],
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  clearGame();
                },
                icon: const Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 35,
                ))
          ],
          centerTitle: true,
          backgroundColor: Colors.grey[900],
          title: const Text(
            "TIC TAC TOE",
            style: TextStyle(color: Colors.white),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20),
              getScoreBoard(),
              const SizedBox(
                height: 20,
              ),
              getResultButton(),
              const SizedBox(
                height: 20,
              ),
              getGridView(),
              getTurn(),
            ],
          ),
        ));
  }

  Text getTurn() {
    return Text(
      isTurnO ? "Turn O" : "Turn X",
      style: const TextStyle(
          color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),
    );
  }

  Widget getResultButton() {
    return Visibility(
      visible: gameHasResult,
      child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            foregroundColor: Colors.white,
            side: const BorderSide(
              color: Colors.white,
              width: 2,
            ),
          ),
          onPressed: () {
            gameHasResult = false;
            clearGame();
          },
          child: Text(
            "$winnerTitle, PLAY AGAIN!",
            style: const TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
          )),
    );
  }

  Widget getGridView() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: 9,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
            ),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  tapped(index);
                },
                child: Container(
                  height: 100,
                  width: 100,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Center(
                      child: Text(
                    xOrOList[index],
                    style: TextStyle(
                        color:
                            xOrOList[index] == "X" ? Colors.white : Colors.red,
                        fontSize: 50,
                        fontWeight: FontWeight.bold),
                  )),
                ),
              );
            }),
      ),
    );
  }

  void tapped(int index) {
    if (gameHasResult) {
      return;
    }
    setState(() {
      if (xOrOList[index] != "") {
        return;
      }
      if (isTurnO) {
        xOrOList[index] = "O";
        filledBoxes = filledBoxes + 1;
      } else {
        xOrOList[index] = "X";
        filledBoxes = filledBoxes + 1;
      }
      isTurnO = !isTurnO;
      checkWinner();
    });
  }

  void checkWinner() {
    if (xOrOList[0] == xOrOList[1] &&
        xOrOList[0] == xOrOList[2] &&
        xOrOList[0] != "") {
      setResult(xOrOList[0], "${xOrOList[0]} IS WINNER");
      return;
    }
    if (xOrOList[3] == xOrOList[4] &&
        xOrOList[3] == xOrOList[5] &&
        xOrOList[3] != "") {
      setResult(xOrOList[3], "${xOrOList[3]} IS WINNER");
      return;
    }
    if (xOrOList[6] == xOrOList[7] &&
        xOrOList[6] == xOrOList[8] &&
        xOrOList[6] != "") {
      setResult(xOrOList[6], "${xOrOList[6]} IS WINNER");
      return;
    }
    if (xOrOList[0] == xOrOList[3] &&
        xOrOList[0] == xOrOList[6] &&
        xOrOList[0] != "") {
      setResult(xOrOList[0], "${xOrOList[0]} IS WINNER");
      return;
    }
    if (xOrOList[1] == xOrOList[4] &&
        xOrOList[1] == xOrOList[7] &&
        xOrOList[1] != "") {
      setResult(xOrOList[1], "${xOrOList[1]} IS WINNER");
      return;
    }
    if (xOrOList[2] == xOrOList[5] &&
        xOrOList[2] == xOrOList[8] &&
        xOrOList[2] != "") {
      setResult(xOrOList[2], "${xOrOList[2]} IS WINNER");
      return;
    }
    if (xOrOList[0] == xOrOList[4] &&
        xOrOList[0] == xOrOList[8] &&
        xOrOList[0] != '') {
      setResult(xOrOList[0], "${xOrOList[0]} IS WINNER");
      return;
    }
    if (xOrOList[2] == xOrOList[4] &&
        xOrOList[2] == xOrOList[6] &&
        xOrOList[2] != '') {
      setResult(xOrOList[2], "${xOrOList[2]} IS WINNER");
      return;
    }
    if (filledBoxes == 9) {
      setResult("", "DRAW!");
    }
  }

  void setResult(String winner, String title) {
    setState(() {
      gameHasResult = true;
      winnerTitle = title;
      if (winner == 'X') {
        scoreX = scoreX + 1;
        return;
      } else if (winner == "O") {
        scoreO = scoreO + 1;
        return;
      } else {
        scoreX = scoreX + 1;
        scoreO = scoreO + 1;
      }
    });
  }

  void clearGame() {
    setState(() {
      for (int i = 0; i < xOrOList.length; i++) {
        xOrOList[i] = '';
      }
    });
    filledBoxes = 0;
  }

  Row getScoreBoard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Player O",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              scoreO.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          )
        ]),
        Column(children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              "Player X",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              scoreX.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
          )
        ]),
      ],
    );
  }
}
