class CategoryGoodsListModel {
  late String code;
  late String message;
  late List<CategoryListData> data;

  CategoryGoodsListModel(
      {required this.code, required this.message, required this.data});

  CategoryGoodsListModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(CategoryListData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CategoryListData {
  late String image;
  late double oriPrice;
  late double presentPrice;
  late String name;
  late String goodsId;

  CategoryListData(
      {required this.image,
      required this.oriPrice,
      required this.presentPrice,
      required this.name,
      required this.goodsId});

  CategoryListData.fromJson(Map<String, dynamic> json) {
    image = json['image'];
    oriPrice = json['oriPrice'];
    presentPrice = json['presentPrice'];
    name = json['name'];
    goodsId = json['goodsId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image'] = this.image;
    data['oriPrice'] = this.oriPrice;
    data['presentPrice'] = this.presentPrice;
    data['name'] = this.name;
    data['goodsId'] = this.goodsId;
    return data;
  }
}
