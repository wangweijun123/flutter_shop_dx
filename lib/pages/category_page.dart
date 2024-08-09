import 'package:easy_refresh/easy_refresh.dart';
import 'package:provider/provider.dart';
// import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../config/index.dart';
import '../service/http_service.dart';
import '../model/category_model.dart';
import '../providers/category_provider.dart';
import '../providers/category_goods_list_provider.dart';
import '../model/category_goods_list_model.dart';
import '../routers/application.dart';

//分类页面
class CategoryPage extends StatefulWidget {
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //商品分类
        title: Text(KString.categoryTitle),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

//左侧导航菜单
class LeftCategoryNav extends StatefulWidget {
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];
  var listIndex = 0; //索引

  @override
  void initState() {
    super.initState();
    _getCategory();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(builder: (BuildContext context,
        CategoryProvider categoryProvider, Widget? child) {
      listIndex = categoryProvider.firstCategoryIndex;
      //print("您点击了" + listIndex.toString() + "个一级分类");

      return Container(
        width: ScreenUtil().setWidth(180),
        decoration: BoxDecoration(
          border: Border(
              right: BorderSide(width: 1, color: KColor.defaultBorderColor)),
        ),
        child: ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _leftInkWel(index);
            }),
      );
    });
  }

  Widget _leftInkWel(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;

    return InkWell(
      onTap: () {
        var secondCategoryList = list[index].secondCategoryVO;
        var firstCategoryId = list[index].firstCategoryId;
        Provider.of<CategoryProvider>(context)
            .changeFirstCategory(firstCategoryId, index);
        Provider.of<CategoryProvider>(context)
            .getSecondCategory(secondCategoryList, firstCategoryId);
        //TODO 获取商品列表
        _getGoodList(context, firstCategoryId: firstCategoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(90),
        padding: EdgeInsets.only(left: 10, top: 10),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 238, 239, 1.0) : Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: KColor.defaultBorderColor),
            left: BorderSide(
                width: 2, color: isClick ? KColor.primaryColor : Colors.white),
          ),
        ),
        child: Text(
          list[index].firstCategoryName,
          style: TextStyle(
            color: isClick ? KColor.primaryColor : Colors.black,
            fontSize: ScreenUtil().setSp(28),
          ),
        ),
      ),
    );
  }

  //获取分类数据
  _getCategory() async {
    await request('getCategory', formData: null).then((val) {
      var data = json.decode(val.toString());
      CategoryModel category = CategoryModel.fromJson(data);

      setState(() {
        list = category.data;
      });

      Provider.of<CategoryProvider>(context)
          .getSecondCategory(list[0].secondCategoryVO, '4');
    });
  }

  _getGoodList(context, {required String firstCategoryId}) {
    var data = {
      'firstCategoryId': firstCategoryId == null
          ? Provider.of<CategoryProvider>(context).firstCategoryId
          : firstCategoryId,
      'secondCategoryId':
          Provider.of<CategoryProvider>(context).secondCategoryId,
      'page': 1
    };

    request('getCategoryGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      print('getCategoryGoods:::' + data.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      Provider.of<CategoryGoodsListProvider>(context)
          .getGoodsList(goodsList.data);
    });
  }
}

//右侧导航菜单
class RightCategoryNav extends StatefulWidget {
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<CategoryProvider>(builder: (BuildContext context,
          CategoryProvider categoryProvider, Widget? child) {
        return Container(
          height: ScreenUtil().setHeight(80),
          width: ScreenUtil().setWidth(570),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1, color: KColor.defaultBorderColor),
            ),
          ),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryProvider.secondCategoryList.length,
              itemBuilder: (context, index) {
                return _rightInkWel(
                    index, categoryProvider.secondCategoryList[index]);
              }),
        );
      }),
    );
  }

  Widget _rightInkWel(int index, SecondCategoryVO item) {
    bool isClick = false;
    isClick =
        (index == Provider.of<CategoryProvider>(context).secondCategoryIndex)
            ? true
            : false;

    return InkWell(
      onTap: () {
        Provider.of<CategoryProvider>(context)
            .changeSecondIndex(index, item.secondCategoryId);
        //TODO 获取商品列表
        _getGoodList(context, item.secondCategoryId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.secondCategoryName,
          style: TextStyle(
            fontSize: ScreenUtil().setSp(28),
            color: isClick ? KColor.primaryColor : Colors.black,
          ),
        ),
      ),
    );
  }

  _getGoodList(context, String secondCategoryId) {
    var data = {
      'firstCategoryId': Provider.of<CategoryProvider>(context).firstCategoryId,
      'secondCategoryId': secondCategoryId,
      'page': 1
    };

    request('getCategoryGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      print('getCategoryGoods secondCategory:::' + data.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provider.of<CategoryGoodsListProvider>(context).getGoodsList([]);
      } else {
        Provider.of<CategoryGoodsListProvider>(context)
            .getGoodsList(goodsList.data);
      }
    });
  }
}

//商品列表
class CategoryGoodsList extends StatefulWidget {
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  // GlobalKey<RefreshFooterState> _footerKey =
  //     new GlobalKey<RefreshFooterState>();

  //滚动控制
  var scrollController = new ScrollController();

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryGoodsListProvider>(
      builder: (BuildContext context,
          CategoryGoodsListProvider categoryGoodsListProvider, Widget? child) {
//    return Provide<CategoryGoodsListProvider>(
//      builder: (context, child, data) {
        try {
          //分类切换时滚动到顶部处理
          if (Provider.of<CategoryProvider>(context).page == 1) {
            scrollController.jumpTo(0.0);
          }
        } catch (e) {
          print('进入页面第一次初始化:${e}');
        }

        if (categoryGoodsListProvider.goodsList.length > 0) {
          return Expanded(
            child: Container(
              width: ScreenUtil().setWidth(570),
              child: EasyRefresh(
                /*footer: ClassicsFooter(
                  key: _footerKey,
                  bgColor: Colors.white,
                  textColor: KColor.refreshTextColor,
                  moreInfoColor: KColor.refreshTextColor,
                  showMore: true,
                  noMoreText: Provider.of<CategoryProvider>(context).noMoreText,
                  moreInfo: KString.loading,
                  //'加载中',
                  loadReadyText: KString.loadReadyText, //'上拉加载',
                ),*/
                child: ListView.builder(
                  controller: scrollController,
                  itemCount: categoryGoodsListProvider.goodsList.length,
                  itemBuilder: (context, index) {
                    //列表项
                    return _ListWidget(
                        categoryGoodsListProvider.goodsList, index);
                  },
                ),
                /*loadMore: () async {
                  //没有更多了
                  if (Provider.of<CategoryProvider>(context).noMoreText ==
                      KString.noMoreText) {
                    Fluttertoast.showToast(
                        msg: KString.toBottomed,
                        //'已经到底了',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.CENTER,
                        timeInSecForIos: 1,
                        backgroundColor: KColor.refreshTextColor,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  } else {
                    _getMoreList();
                  }
                },*/
              ),
            ),
          );
        } else {
          return Text(KString.noMoreData); //'暂时没有数据'
        }
      },
    );
  }

  //上拉加载更多的方法
  void _getMoreList() {
    Provider.of<CategoryProvider>(context).addPage();
    var data = {
      'firstCategoryId': Provider.of<CategoryProvider>(context).firstCategoryId,
      'secondCategoryId':
          Provider.of<CategoryProvider>(context).secondCategoryId,
      'page': Provider.of<CategoryProvider>(context).page
    };

    request('getCategoryGoods', formData: data).then((val) {
      var data = json.decode(val.toString());
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      if (goodsList.data == null) {
        Provider.of<CategoryProvider>(context)
            .chageNoMore(KString.noMoreText); //'没有更多了'
      } else {
        Provider.of<CategoryGoodsListProvider>(context)
            .addGoodsList(goodsList.data);
      }
    });
  }

  //商品列表项
  Widget _ListWidget(List newList, int index) {
    return InkWell(
      onTap: () {
        //TODO 跳转到商品详情页
        // Application.router
        //     .navigateTo(context, "/detail?id=${newList[index].goodsId}");
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              bottom: BorderSide(width: 1.0, color: KColor.defaultBorderColor),
            )),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            ),
          ],
        ),
      ),
    );
  }

  //商品图片
  Widget _goodsImage(List newList, int index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  //商品名称
  Widget _goodsName(List newList, int index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].name,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(List newList, int index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格:￥${newList[index].presentPrice}',
            style: TextStyle(color: KColor.presentPriceTextColor),
          ),
          Text(
            '￥${newList[index].oriPrice}',
            style: KFont.oriPriceStyle,
          ),
        ],
      ),
    );
  }
}
