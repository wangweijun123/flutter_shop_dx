import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_page.dart';
import 'category_page.dart';
import 'cart_page.dart';
import 'member_page.dart';
import '../config/index.dart';
import '../providers/current_index_provider.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    const BottomNavigationBarItem(
      icon: Icon(Icons.home),
      label: KString.homeTitle, //首页
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.category),
      label: KString.categoryTitle, //分类
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.shopping_cart),
      label: KString.shoppingCartTitle, //购物车
    ),
    const BottomNavigationBarItem(
      icon: Icon(Icons.person),
      label: KString.memberTitle, //会员中心
    ),
  ];

  final List<Widget> tabBodies = [
    HomePage(),
    CategoryPage(),
    CartPage(),
    MemberPage()
  ];

  @override
  Widget build(BuildContext context) {
    // ScreenUtil.instance = ScreenUtil(width: 750,height: 1334)..init(context);

    ScreenUtil.init(context, designSize: const Size(750, 1334));

    //取到当前索引状态值
    int currentIndex = Provider.of<CurrentIndexProvider>(context).currentIndex;

    return Scaffold(
      backgroundColor: Color.fromRGBO(244, 245, 245, 1.0),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: currentIndex,
        items: bottomTabs,
        onTap: (index) {
          Provider.of<CurrentIndexProvider>(context, listen: false)
              .changeIndex(index);
        },
      ),
      body: IndexedStack(
        index: currentIndex,
        children: tabBodies,
      ),
    );
  }
}
