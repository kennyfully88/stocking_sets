import 'dart:math';

import 'package:flutter/widgets.dart';

/// Possible colors on the stocking
/// ストッキングにある可能な色
enum StockingColors {
  white(color: Color(0xFFFFFFFF)),
  red(color: Color(0xFFF40F40)),
  green(color: Color(0xFF40B040));

  const StockingColors({required this.color});
  final Color color;
}

class StockingItem {
  StockingItem({
    required this.id,
    required this.colorL1,
    required this.colorL3,
  });

  final int id;
  StockingColors colorL1;
  StockingColors colorL3;
}

/// Game business logic
/// ゲームビジネスロジック
class GameLogic extends ChangeNotifier {
  /// Current points of the game
  /// 現在のゲームポイント
  int _points = 0;

  int get points => _points;

  bool _activeGame = true;

  bool get activeGame => _activeGame;

  List<StockingItem> stockingItems = [
    StockingItem(
      id: 0,
      colorL1: StockingColors.values[Random().nextInt(3)],
      colorL3: StockingColors.values[Random().nextInt(3)],
    ),
    StockingItem(
      id: 1,
      colorL1: StockingColors.values[Random().nextInt(3)],
      colorL3: StockingColors.values[Random().nextInt(3)],
    ),
    StockingItem(
      id: 2,
      colorL1: StockingColors.values[Random().nextInt(3)],
      colorL3: StockingColors.values[Random().nextInt(3)],
    ),
  ];

  List<StockingItem> matchingStockingItems = [
    StockingItem(
      id: 0,
      colorL1: StockingColors.values[Random().nextInt(3)],
      colorL3: StockingColors.values[Random().nextInt(3)],
    ),
    StockingItem(
      id: 1,
      colorL1: StockingColors.values[Random().nextInt(3)],
      colorL3: StockingColors.values[Random().nextInt(3)],
    ),
  ];

  /// Add points
  /// ポイントを加算する
  void addPoints({required StockingItem stocking}) {
    if (!_activeGame) return;

    if (stocking.colorL1.color == stocking.colorL3.color) {
      _points += 8;
    } else {
      _points += 2;
    }

    notifyListeners();
  }

  void resetPoints() {
    _points = 0;
    notifyListeners();
  }

  void shuffleStockingColors({required int id}) {
    stockingItems[id].colorL1 = StockingColors.values[Random().nextInt(3)];

    stockingItems[id].colorL3 = StockingColors.values[Random().nextInt(3)];
    notifyListeners();
  }

  void shuffleAllStockingColors() {
    for (StockingItem stocking in stockingItems) {
      stocking.colorL1 = StockingColors.values[Random().nextInt(3)];

      stocking.colorL3 = StockingColors.values[Random().nextInt(3)];
      notifyListeners();
    }
  }

  void shuffleMatchingStockingColors({required int id}) {
    matchingStockingItems[id].colorL1 =
        StockingColors.values[Random().nextInt(3)];

    matchingStockingItems[id].colorL3 =
        StockingColors.values[Random().nextInt(3)];
    notifyListeners();
  }

  void shuffleAllMatchingStockingColors() {
    for (StockingItem stocking in stockingItems) {
      stocking.colorL1 = StockingColors.values[Random().nextInt(3)];
      stocking.colorL3 = StockingColors.values[Random().nextInt(3)];
      notifyListeners();
    }
  }

  /// Set rather the game is active or inactive
  /// ゲームがアクティブか非アクティブかを設定します
  void setActiveGame({required bool isActive}) {
    _activeGame = isActive;
    notifyListeners();
  }

  /// Reset all variables in the game
  /// ゲームのすべての変数をリセットします
  void resetGame() {
    resetPoints();
    shuffleAllStockingColors();
    shuffleAllMatchingStockingColors();
    setActiveGame(isActive: true);
  }
}
