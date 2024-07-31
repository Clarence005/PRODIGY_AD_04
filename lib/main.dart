import 'package:flutter/material.dart';

void main() {
  runApp(TicTacToeApp());
}

class TicTacToeApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tic Tac Toe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TicTacToeHomePage(),
    );
  }
}

class TicTacToeHomePage extends StatefulWidget {
  @override
  _TicTacToeHomePageState createState() => _TicTacToeHomePageState();
}

class _TicTacToeHomePageState extends State<TicTacToeHomePage> {
  static const int boardSize = 3;
  List<String> _board = List.filled(boardSize * boardSize, '');
  String _currentPlayer = 'X';
  String _winner = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tic Tac Toe'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          _buildBoard(),
          SizedBox(height: 20),
          _buildStatus(),
          SizedBox(height: 20),
          _buildResetButton(),
        ],
      ),
    );
  }

  Widget _buildBoard() {
    return GridView.builder(
      shrinkWrap: true,
      itemCount: boardSize * boardSize,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: boardSize,
      ),
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => _onTileTapped(index),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
            ),
            child: Center(
              child: Text(
                _board[index],
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatus() {
    return Text(
      _winner.isNotEmpty ? 'Winner: $_winner' : 'Current Player: $_currentPlayer',
      style: TextStyle(fontSize: 24),
    );
  }

  Widget _buildResetButton() {
    return ElevatedButton(
      onPressed: _resetGame,
      child: Text('Reset'),
    );
  }

  void _onTileTapped(int index) {
    if (_board[index].isEmpty && _winner.isEmpty) {
      setState(() {
        _board[index] = _currentPlayer;
        _checkWinner();
        _currentPlayer = _currentPlayer == 'X' ? 'O' : 'X';
      });
    }
  }

  void _checkWinner() {
    List<List<int>> winPatterns = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var pattern in winPatterns) {
      if (_board[pattern[0]] == _board[pattern[1]] &&
          _board[pattern[1]] == _board[pattern[2]] &&
          _board[pattern[0]].isNotEmpty) {
        setState(() {
          _winner = _board[pattern[0]];
        });
        break;
      }
    }
  }

  void _resetGame() {
    setState(() {
      _board = List.filled(boardSize * boardSize, '');
      _currentPlayer = 'X';
      _winner = '';
    });
  }
}
