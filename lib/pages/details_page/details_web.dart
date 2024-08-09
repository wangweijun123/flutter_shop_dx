import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:flutter_html/flutter_html.dart';
import '../../providers/details_info_provider.dart';

//商品详细
class DetailsWeb extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetail = Provider.of<DetailsInfoProvider>(context)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;

    var isLeft = Provider.of<DetailsInfoProvider>(context).isLeft;

    if (isLeft) {
      return Container(
        child: Html(
          data: goodsDetail.toString(),
        ),
      );
    } else {
      return Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.all(10),
        alignment: Alignment.center,
        child: Text('暂时没有数据'),
      );
    }
  }
}
