import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/details_info_provider.dart';
import '../../config/index.dart';

//商品详细评论切换组件
class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsInfoProvider>(
      builder: (BuildContext context, DetailsInfoProvider detailsInfoProvider,
          Widget? child) {
        var isLeft = detailsInfoProvider.isLeft;
        var isRight = detailsInfoProvider.isRight;

        return Container(
          margin: EdgeInsets.only(top: 15.0),
          child: Row(
            children: <Widget>[
              _myTabBarLeft(context, isLeft),
              _myTabBarRight(context, isRight),
            ],
          ),
        );
      },
    );
  }

  Widget _myTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provider.of<DetailsInfoProvider>(context, listen: false).changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color:
                  isLeft ? KColor.detailsTextColor : KColor.defaultBorderColor,
            ),
          ),
        ),
        child: Text(
          '详细',
          style: TextStyle(
            color: isLeft ? KColor.detailsTextColor : Colors.black,
          ),
        ),
      ),
    );
  }

  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provider.of<DetailsInfoProvider>(context, listen: false).changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color:
                  isRight ? KColor.detailsTextColor : KColor.defaultBorderColor,
            ),
          ),
        ),
        child: Text(
          '评论',
          style: TextStyle(
            color: isRight ? KColor.detailsTextColor : Colors.black,
          ),
        ),
      ),
    );
  }
}
