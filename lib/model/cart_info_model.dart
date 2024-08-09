class CartInfoModel {
  late String goodsId;
  late String goodsName;
  late int count;
  late double price;
  late String images;
  late bool isCheck;

  CartInfoModel(
      {required this.goodsId,
      required this.goodsName,
      required this.count,
      required this.price,
      required this.images,
      required this.isCheck});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = json['price'];
    images = json['images'];
    isCheck = json['isCheck'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    data['isCheck'] = this.isCheck;
    return data;
  }
}
