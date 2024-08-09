import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../providers/cart_provider.dart';
import '../../providers/current_index_provider.dart';
import '../../config/index.dart';
import '../../providers/details_info_provider.dart';

class DetailBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo =
        Provider.of<DetailsInfoProvider>(context).goodsInfo.data.goodInfo;

    var goodsID = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  //跳转到购物车页面
                  Provider.of<CurrentIndexProvider>(context).changeIndex(2);
                  Navigator.pop(context);
                },
                child: Container(
                  width: ScreenUtil().setWidth(110),
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.shopping_cart,
                    size: 35,
                    color: Colors.red,
                  ),
                ),
              ),
              //购物车商品数据
              Consumer<CartProvider>(
                builder: (BuildContext context, CartProvider cartProvider,
                    Widget? child) {
                  num goodsCount = cartProvider.allGoodsCount;
                  return Positioned(
                    top: 0,
                    right: 10,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                      decoration: BoxDecoration(
                        color: KColor.primaryColor,
                        border: Border.all(width: 2, color: Colors.white),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Text(
                        '${goodsCount}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(22),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
          InkWell(
            onTap: () async {
              //添加至购物车
              await Provider.of<CartProvider>(context)
                  .save(goodsID, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text(
                KString.addToCartText, //'加入购物车'
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () async {
              //TODO 马上购买
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: KColor.primaryColor,
              child: Text(
                KString.buyGoodsText, //马上购买
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(28),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
