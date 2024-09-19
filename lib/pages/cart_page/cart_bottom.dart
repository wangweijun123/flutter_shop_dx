import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../providers/cart_provider.dart';
import '../../config/index.dart';
import '../../providers/details_info_provider.dart';

//购物车底部组件
class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    /**
     * BuildContext context,
        T value,
        Widget? child,
     */
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(5.0),
      color: Colors.white,
      width: ScreenUtil().setWidth(750),
      child: Consumer<CartProvider>(
        builder:
            (BuildContext context, CartProvider cartProvider, Widget? child) {
          return Row(
            children: <Widget>[
              selectAllBtn(context),
              allPriceArea(context),
              goButton(context),
            ],
          );
        },
      ),
    );
  }

  //全选按钮
  Widget selectAllBtn(BuildContext context) {
    bool isAllCheck = Provider.of<CartProvider>(context).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
            value: isAllCheck,
            activeColor: KColor.checkBoxColor,
            onChanged: (bool? val) {
              Provider.of<CartProvider>(context).changeAllCheckBtnState(val!);
            },
          ),
          const Text(KString.allCheck), //'全选'
        ],
      ),
    );
  }

  //合计区域
  Widget allPriceArea(BuildContext context) {
    double allPrice =
        Provider.of<CartProvider>(context, listen: false).allPrice;
    String allPriceStr = allPrice.toStringAsFixed(2);

    return Container(
      width: ScreenUtil().setWidth(430),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(200),
                child: Text(
                  KString.allPriceTitle, //'合计',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(230),
                child: Text(
                  '￥${allPriceStr}',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(36),
                    color: KColor.presentPriceTextColor,
                  ),
                ),
              ),
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            width: ScreenUtil().setWidth(430),
            child: Text(
              KString.allPriceAdv, //'满10元免配送费,预购免配送费',
              style: TextStyle(
                fontSize: ScreenUtil().setSp(22),
                color: Colors.black38,
              ),
            ),
          ),
        ],
      ),
    );
  }

  //结算按钮
  Widget goButton(BuildContext context) {
    num allGoodsCount =
        Provider.of<CartProvider>(context, listen: false).allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {
          //TODO 结算处理
        },
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: KColor.primaryColor,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
