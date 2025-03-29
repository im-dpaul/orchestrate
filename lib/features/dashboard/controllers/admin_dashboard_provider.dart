import 'package:flutter/material.dart';

class AdminDashboardProvider with ChangeNotifier {
  int selectedIndex = 0;
  PageController pageController = PageController(initialPage: 0);

  void updateTabIndex(int index) {
    selectedIndex = index;
    pageController.animateToPage(index,
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn);
    notifyListeners();
  }
}
