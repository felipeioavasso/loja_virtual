import 'package:flutter/cupertino.dart';

class PageManeger {

  final PageController _pageController;

  PageManeger(this._pageController);

  int page = 0;

  void setPage(int value){
    if( value == page ) return;
    page = value;
    _pageController.jumpToPage(value);
  }

}