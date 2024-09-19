import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:convert';
import '../config/index.dart';
import '../providers/details_info_provider.dart';
import './details_page/details_top_area.dart';
import './details_page/details_top_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/details_web.dart';
import './details_page/details_bottom.dart';
import '../service/http_service.dart';
import '../model/details_model.dart';

class DetailsPage extends StatefulWidget {
  final String goodsId;

  DetailsPage(this.goodsId);

  DetailsPageState createState() => DetailsPageState(this.goodsId);
}

class DetailsPageState extends State<DetailsPage> {
  //商品ID
  final String goodsId;

  DetailsPageState(this.goodsId);

  DetailsModel? goodsInfo;

  @override
  void initState() {
    super.initState();
    _getGoodsInfo();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                print('返回上一页');
                Navigator.pop(context);
              },
            ),
            title: Text(KString.detailsPageTitle), //'商品详情'
          ),
          body: (goodsInfo != null)
              ? Stack(
                  children: <Widget>[
                    ListView(
                      children: <Widget>[
                        DetailsTopArea(),
                        DetailsExplain(),
                        DetailsTabBar(),
                        DetailsWeb(),
                      ],
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      child: DetailBottom(),
                    ),
                  ],
                )
              : Text(KString.loading) //'加载中...'
          ),
    );
  }

  Future _getGoodsInfo() async {
    var formData = {'goodId': goodsId};

    await request('getGoodDetail', formData: formData).then((val) {
      var responseData = json.decode(val.toString());
      setState(() {
        goodsInfo = DetailsModel.fromJson(responseData);
      });
      Provider.of<DetailsInfoProvider>(context, listen: false).goodsInfo =
          goodsInfo!;
      print('getGoodDetail:::' + responseData.toString());
    });
  }
}
