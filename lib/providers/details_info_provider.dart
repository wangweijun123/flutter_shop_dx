import 'package:flutter/material.dart';
import '../model/details_model.dart';

//切换底部导航栏
class DetailsInfoProvider with ChangeNotifier {
  late DetailsModel goodsInfo;
  bool isLeft = true;
  bool isRight = false;

  //改变tabBar的状态
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }
}
