import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../providers/cart_provider.dart';
import '../../model/cart_info_model.dart';
import '../../config/index.dart';

//商品计数组件
class CartCount extends StatelessWidget {
  final CartInfoModel item;

  CartCount(this.item);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(165),
      margin: EdgeInsets.only(top: 5.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: KColor.defaultBorderColor),
      ),
      child: Row(
        children: <Widget>[
          _reduceBtn(context),
          _countArea(),
          _addBtn(context),
        ],
      ),
    );
  }

  //减少按钮
  Widget _reduceBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<CartProvider>(context).addOrReduceAction(item, 'reduce');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          //当前数量小于等于1时,按钮变成灰色
          color: item.count > 1 ? Colors.white : KColor.defaultBorderColor,
          border: Border(
              right: BorderSide(width: 1, color: KColor.defaultBorderColor)),
        ),
        child: item.count > 1 ? Text('-') : Text(' '),
      ),
    );
  }

  //增加按钮
  Widget _addBtn(BuildContext context) {
    return InkWell(
      onTap: () {
        Provider.of<CartProvider>(context).addOrReduceAction(item, 'add');
      },
      child: Container(
        width: ScreenUtil().setWidth(45),
        height: ScreenUtil().setHeight(45),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              left: BorderSide(width: 1, color: KColor.defaultBorderColor)),
        ),
        child: Text('+'),
      ),
    );
  }

  //显示数量
  Widget _countArea() {
    return Container(
      width: ScreenUtil().setWidth(70),
      height: ScreenUtil().setHeight(45),
      alignment: Alignment.center,
      color: Colors.white,
      child: Text('${item.count}'),
    );
  }
}
