class DetailsModel {
  late String code;
  late String message;
  late DetailsGoodsData data;

  DetailsModel({required this.code, required this.message, required this.data});

  DetailsModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    data = (json['data'] != null
        ? new DetailsGoodsData.fromJson(json['data'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class DetailsGoodsData {
  late GoodInfo goodInfo;

  DetailsGoodsData({required this.goodInfo});

  DetailsGoodsData.fromJson(Map<String, dynamic> json) {
    goodInfo = (json['goodInfo'] != null
        ? GoodInfo.fromJson(json['goodInfo'])
        : null)!;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.goodInfo != null) {
      data['goodInfo'] = this.goodInfo.toJson();
    }
    return data;
  }
}

class GoodInfo {
  late int amount;
  late String goodsId;
  late String image1;
  late String goodsSerialNumber;
  late double oriPrice;
  late double presentPrice;
  late String shopId;
  late String goodsName;
  late String goodsDetail;

  GoodInfo(
      {required this.amount,
      required this.goodsId,
      required this.image1,
      required this.goodsSerialNumber,
      required this.oriPrice,
      required this.presentPrice,
      required this.shopId,
      required this.goodsName,
      required this.goodsDetail});

  GoodInfo.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    goodsId = json['goodsId'];
    image1 = json['image1'];
    goodsSerialNumber = json['goodsSerialNumber'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    shopId = json['shopId'];
    goodsName = json['goodsName'];
    goodsDetail = json['goodsDetail'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    data['goodsId'] = this.goodsId;
    data['image1'] = this.image1;
    data['goodsSerialNumber'] = this.goodsSerialNumber;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['shopId'] = this.shopId;
    data['goodsName'] = this.goodsName;
    data['goodsDetail'] = this.goodsDetail;
    return data;
  }
}
