import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fluro/fluro.dart';
import './config/index.dart';
import './providers/current_index_provider.dart';
import './pages/index_page.dart';
import './providers/category_provider.dart';
import './providers/category_goods_list_provider.dart';
import './routers/routes.dart';
import './routers/application.dart';
import './providers/details_info_provider.dart';
import './providers/cart_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final router = Router(
    //   routerDelegate: null,
    // );
    // Routes.configureRoutes(router);
    // Application.router = router;

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CategoryProvider()),
        ChangeNotifierProvider(create: (_) => CategoryGoodsListProvider()),
        ChangeNotifierProvider(create: (_) => DetailsInfoProvider()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CurrentIndexProvider()),
      ],
      child: Container(
        child: MaterialApp(
          title: KString.mainTitle,
          //Flutter女装商城
          debugShowCheckedModeBanner: false,
          // onGenerateRoute: Application.router.generator,
          //定制主题
          theme: ThemeData(
            primaryColor: KColor.primaryColor,
          ),
          home: IndexPage(),
        ),
      ),
    );
  }
}
