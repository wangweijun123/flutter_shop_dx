import 'package:flutter/material.dart';
import '../config/index.dart';
import 'package:provider/provider.dart';
import '../providers/cart_provider.dart';
import './cart_page/cart_item.dart';
import './cart_page/cart_bottom.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(KString.cartPageTitle), //购物车
      ),
      body: FutureBuilder(
          future: _getCartInfo(context),
          builder: (context, snapshot) {
            List cartList = Provider.of<CartProvider>(context).cartList;
            if (snapshot.hasData && cartList != null) {
              return Stack(
                children: <Widget>[
                  ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        return CartItem(cartList[index]);
                      }),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    child: CartBottom(),
                  ),
                ],
              );
            } else {
              return Text(KString.loading); //'加载中...'
            }
          }),
    );
  }

  Future _getCartInfo(BuildContext context) async {
    await Provider.of<CartProvider>(context).getCartInfo();
    return 'end';
  }
}
