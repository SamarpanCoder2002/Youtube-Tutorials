import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flip_card/flip_card.dart';
import './config.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<dynamic> _blockKeys =
      List.generate(9, (index) => GlobalKey<FlipCardState>());

  Player _currPlayer = Player.player1;

  bool _isWinnerFound = false;

  List<int> _playerBlockInput = [];

  Map<int, Widget> _blockInput = {
    1: const Center(),
    2: const Center(),
    3: const Center(),
    4: const Center(),
    5: const Center(),
    6: const Center(),
    7: const Center(),
    8: const Center(),
  };

  Map<Player, List<int>> _playerInput = {
    Player.player1: [],
    Player.player2: [],
  };

  final List<List<int>> _matchingPattern = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [1, 4, 7],
    [2, 5, 8],
    [3, 6, 9],
    [1, 5, 9],
    [3, 5, 7],
  ];

  _initialize() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        systemNavigationBarIconBrightness: Brightness.dark,
        statusBarIconBrightness: Brightness.dark,
        statusBarColor: Colors.transparent));
  }

  @override
  void initState() {
    _initialize();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
            _currPlayer == Player.player1 ? 'First Player' : 'Second Player'),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: Column(children: [
          const SizedBox(height: 30),
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height / 1.8,
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10),
                itemCount: 9,
                itemBuilder: (_, index) => _gameBlock(index)),
          ),
          const SizedBox(height: 20),
          Center(
            child: ElevatedButton(
                onPressed: _onReset,
                child: Text(
                  'Reset',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )),
          ),
        ]),
      ),
    );
  }

  _gameBlock(int index) {
    return FlipCard(
      key: _blockKeys[index],
      flipOnTouch: false,
      front: ElevatedButton(
        onPressed: () => _onInput(index),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            (index + 1).toString(),
            style: const TextStyle(
                fontSize: 35, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
      ),
      back: _blockInput[index + 1] ?? const Center(),
    );
  }

  void _onReset() {
    _blockKeys = List.generate(9, (index) => GlobalKey<FlipCardState>());
    _blockInput = {
      1: const Center(),
      2: const Center(),
      3: const Center(),
      4: const Center(),
      5: const Center(),
      6: const Center(),
      7: const Center(),
      8: const Center(),
    };
    _isWinnerFound = false;
    _playerInput = {
      Player.player1: [],
      Player.player2: [],
    };
    _playerBlockInput.clear();

    setState(() {});
  }

  Widget get _getCrossImage {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.blue[400],
      child: Image.asset(
        'assets/images/cross.png',
        color: Colors.white,
      ),
    );
  }

  Widget get _getCircleImage {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Colors.blue[400],
      child: Image.asset(
        'assets/images/circle.png',
        color: Colors.white,
      ),
    );
  }

  _onInput(int index) {
    if (_isWinnerFound) return;

    final _oppositePlayer =
        _currPlayer == Player.player1 ? Player.player2 : Player.player1;

    if (_playerInput[_currPlayer]!.contains(index + 1) ||
        _playerInput[_oppositePlayer]!.contains(index + 1)) return;

    _playerBlockInput.add(index + 1);

    if (_currPlayer == Player.player1) {
      _blockInput[index + 1] = _getCrossImage;
      _playerInput[Player.player1]?.add(index + 1);
      _currPlayer = Player.player2;
    } else {
      _blockInput[index + 1] = _getCircleImage;
      _playerInput[Player.player2]?.add(index + 1);
      _currPlayer = Player.player1;
    }

    _blockKeys[index].currentState.toggleCard();

    setState(() {});

    _detectWinner(
        _currPlayer == Player.player1 ? Player.player2 : Player.player1);
  }

  _detectWinner(Player _currPlayer) {
    final _currPlayerInputs =
        (_playerInput[_currPlayer] ?? <int>[]) as List<int>;

    final _setData = Set.of(_currPlayerInputs);

    final _resultCollection = _matchingPattern
        .map((pattern) => _setData.containsAll(pattern))
        .toList();

    if (_resultCollection.contains(true)) {
      _isWinnerFound = true;
      setState(() {});

      final _finalResult =
          "${_currPlayer == Player.player1 ? 'First Player' : 'Second Player'} is the winner";

      _showCustomDialog(_finalResult);
    } else if (_playerBlockInput.length == 9) {
      _showCustomDialog('Game is draw...');
    }
  }

  _showCustomDialog(String title) {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Center(child: Text(title)),
            ));
  }
}
