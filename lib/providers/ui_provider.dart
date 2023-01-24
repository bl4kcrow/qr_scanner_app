import 'package:flutter/foundation.dart';

class UIProvider extends ChangeNotifier {
  int _selectedMenuOption = 0;

  int get selectedMenuOption => _selectedMenuOption;

  set selectedMenuOption(int value) {
    _selectedMenuOption = value;
    notifyListeners();
  }
}
