// To parse this JSON data, do
//
//     final restdata = restdataFromJson(jsonString);

import 'dart:convert';

Restdata restdataFromJson(String str) => Restdata.fromJson(json.decode(str));

String restdataToJson(Restdata data) => json.encode(data.toJson());

class Restdata {
  Restdata({
    required this.restdata,
    required this.relatedRest,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  RestdataClass restdata;
  List<RelatedRest> relatedRest;
  String responseCode;
  String result;
  String responseMsg;

  factory Restdata.fromJson(Map<String, dynamic> json) => Restdata(
        restdata: RestdataClass.fromJson(json["restdata"]),
        relatedRest: List<RelatedRest>.from(
            json["related_rest"].map((x) => RelatedRest.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "restdata": restdata.toJson(),
        "related_rest": List<dynamic>.from(relatedRest.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class RelatedRest {
  RelatedRest({
    required this.id,
    required this.title,
    required this.costTwo,
    required this.sdesc,
    required this.landmark,
    required this.monthru,
    required this.frisun,
    required this.rate,
    required this.restDistance,
    required this.img,
  });

  String id;
  String title;
  String costTwo;
  String sdesc;
  String landmark;
  String monthru;
  String frisun;
  String rate;
  String restDistance;
  List<String> img;

  factory RelatedRest.fromJson(Map<String, dynamic> json) => RelatedRest(
        id: json["id"],
        title: json["title"],
        costTwo: json["cost_two"],
        sdesc: json["sdesc"],
        landmark: json["landmark"],
        monthru: json["monthru"],
        frisun: json["frisun"],
        rate: json["rate"],
        restDistance: json["rest_distance"],
        img: List<String>.from(json["img"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cost_two": costTwo,
        "sdesc": sdesc,
        "landmark": landmark,
        "monthru": monthru,
        "frisun": frisun,
        "rate": rate,
        "rest_distance": restDistance,
        "img": List<dynamic>.from(img.map((x) => x)),
      };
}

class RestdataClass {
  RestdataClass({
    required this.id,
    required this.title,
    required this.costTwo,
    required this.sdesc,
    required this.landmark,
    required this.monthru,
    required this.mdesc,
    required this.frisun,
    required this.address,
    required this.latitude,
    required this.longtitude,
    required this.popularDish,
    required this.sundesc,
    required this.rate,
    required this.openTime,
    required this.closeTime,
    required this.mobile,
    required this.featurelist,
    required this.restDistance,
    required this.img,
  });

  String id;
  String title;
  String costTwo;
  String sdesc;
  String landmark;
  String monthru;
  String mdesc;
  String frisun;
  String address;
  String latitude;
  String longtitude;
  String popularDish;
  String sundesc;
  String rate;
  String openTime;
  String closeTime;
  String mobile;
  List<Featurelist> featurelist;
  String restDistance;
  List<String> img;

  factory RestdataClass.fromJson(Map<String, dynamic> json) => RestdataClass(
        id: json["id"],
        title: json["title"],
        costTwo: json["cost_two"],
        sdesc: json["sdesc"],
        landmark: json["landmark"],
        monthru: json["monthru"],
        mdesc: json["mdesc"],
        frisun: json["frisun"],
        address: json["address"],
        latitude: json["latitude"],
        longtitude: json["longtitude"],
        popularDish: json["popular_dish"],
        sundesc: json["sundesc"],
        rate: json["rate"],
        openTime: json["open_time"],
        closeTime: json["close_time"],
        mobile: json["mobile"],
        featurelist: List<Featurelist>.from(
            json["featurelist"].map((x) => Featurelist.fromJson(x))),
        restDistance: json["rest_distance"],
        img: List<String>.from(json["img"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "cost_two": costTwo,
        "sdesc": sdesc,
        "landmark": landmark,
        "monthru": monthru,
        "mdesc": mdesc,
        "frisun": frisun,
        "address": address,
        "latitude": latitude,
        "longtitude": longtitude,
        "popular_dish": popularDish,
        "sundesc": sundesc,
        "rate": rate,
        "open_time": openTime,
        "close_time": closeTime,
        "mobile": mobile,
        "featurelist": List<dynamic>.from(featurelist.map((x) => x.toJson())),
        "rest_distance": restDistance,
        "img": List<dynamic>.from(img.map((x) => x)),
      };
}

class Featurelist {
  Featurelist({
    required this.title,
    required this.img,
  });

  String title;
  String img;

  factory Featurelist.fromJson(Map<String, dynamic> json) => Featurelist(
        title: json["title"],
        img: json["img"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "img": img,
      };
}
