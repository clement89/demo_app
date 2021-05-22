import 'package:flutter/cupertino.dart';

class RootProvider extends ChangeNotifier {
  int pageIndex = 0;
  void updatePageIndex(int index) {
    pageIndex = index;
    notifyListeners();
  }
}
