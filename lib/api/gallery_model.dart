// To parse this JSON data, do
//
//     final gallerydata = gallerydataFromJson(jsonString);

import 'dart:convert';

Gallerydata gallerydataFromJson(String str) =>
    Gallerydata.fromJson(json.decode(str));

String gallerydataToJson(Gallerydata data) => json.encode(data.toJson());

class Gallerydata {
  Gallerydata({
    required this.gallerydata,
    required this.responseCode,
    required this.result,
    required this.responseMsg,
  });

  List<Gallerydatum> gallerydata;
  String responseCode;
  String result;
  String responseMsg;

  factory Gallerydata.fromJson(Map<String, dynamic> json) => Gallerydata(
        gallerydata: List<Gallerydatum>.from(
            json["gallerydata"].map((x) => Gallerydatum.fromJson(x))),
        responseCode: json["ResponseCode"],
        result: json["Result"],
        responseMsg: json["ResponseMsg"],
      );

  Map<String, dynamic> toJson() => {
        "gallerydata": List<dynamic>.from(gallerydata.map((x) => x.toJson())),
        "ResponseCode": responseCode,
        "Result": result,
        "ResponseMsg": responseMsg,
      };
}

class Gallerydatum {
  Gallerydatum({
    required this.title,
    required this.imglist,
  });

  String title;
  List<String> imglist;

  factory Gallerydatum.fromJson(Map<String, dynamic> json) => Gallerydatum(
        title: json["title"],
        imglist: List<String>.from(json["imglist"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "imglist": List<dynamic>.from(imglist.map((x) => x)),
      };
}
