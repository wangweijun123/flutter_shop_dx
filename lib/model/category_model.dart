class CategoryModel {
  late String code;
  late String message;
  late List<Data> data;

  CategoryModel(
      {required this.code, required this.message, required this.data});

  CategoryModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    message = json['message'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  late String firstCategoryId;
  late String firstCategoryName;
  late List<SecondCategoryVO> secondCategoryVO;
  late Null comments;
  late String image;

  Data(
      {required this.firstCategoryId,
      required this.firstCategoryName,
      required this.secondCategoryVO,
      this.comments,
      required this.image});

  Data.fromJson(Map<String, dynamic> json) {
    firstCategoryId = json['firstCategoryId'];
    firstCategoryName = json['firstCategoryName'];
    if (json['secondCategoryVO'] != null) {
      secondCategoryVO = [];
      json['secondCategoryVO'].forEach((v) {
        secondCategoryVO.add(SecondCategoryVO.fromJson(v));
      });
    }
    comments = json['comments'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['firstCategoryId'] = this.firstCategoryId;
    data['firstCategoryName'] = this.firstCategoryName;
    if (this.secondCategoryVO != null) {
      data['secondCategoryVO'] =
          this.secondCategoryVO.map((v) => v.toJson()).toList();
    }
    data['comments'] = this.comments;
    data['image'] = this.image;
    return data;
  }
}

class SecondCategoryVO {
  late String secondCategoryId;
  late String firstCategoryId;
  late String secondCategoryName;
  late String comments;

  SecondCategoryVO(
      {required this.secondCategoryId,
      required this.firstCategoryId,
      required this.secondCategoryName,
      required this.comments});

  SecondCategoryVO.fromJson(Map<String, dynamic> json) {
    secondCategoryId = json['secondCategoryId'];
    firstCategoryId = json['firstCategoryId'];
    secondCategoryName = json['secondCategoryName'];
    comments = json['comments'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['secondCategoryId'] = secondCategoryId;
    data['firstCategoryId'] = this.firstCategoryId;
    data['secondCategoryName'] = this.secondCategoryName;
    data['comments'] = this.comments;
    return data;
  }
}
