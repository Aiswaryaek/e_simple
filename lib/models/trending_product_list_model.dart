// To parse this JSON data, do
//
//     final trendingProductModel = trendingProductModelFromJson(jsonString);

import 'dart:convert';

TrendingProductModel trendingProductModelFromJson(String str) => TrendingProductModel.fromJson(json.decode(str));

String trendingProductModelToJson(TrendingProductModel data) => json.encode(data.toJson());

class TrendingProductModel {
  TrendingProductModel({
    this.trendingItems,
    this.maxPrice,
    this.minPrice,
    this.totalPages,
    this.totalElements,
    this.first,
    this.numberOfElements,
    this.size,
    this.number,
    this.empty,
    this.last,
    this.status,
  });

  List<TrendingItems> ? trendingItems;
  String ? maxPrice;
  String ? minPrice;
  int ? totalPages;
  int ? totalElements;
  bool ? first;
  int ? numberOfElements;
  int ? size;
  int ? number;
  bool ? empty;
  bool ? last;
  String ? status;

  factory TrendingProductModel.fromJson(Map<String, dynamic> json) => TrendingProductModel(
    trendingItems: List<TrendingItems>.from(json["content"].map((x) => TrendingItems.fromJson(x))),
    maxPrice: json["maxPrice"],
    minPrice: json["minPrice"],
    totalPages: json["totalPages"],
    totalElements: json["totalElements"],
    first: json["first"],
    numberOfElements: json["numberOfElements"],
    size: json["size"],
    number: json["number"],
    empty: json["empty"],
    last: json["last"],
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "content": List<dynamic>.from(trendingItems!.map((x) => x.toJson())),
    "maxPrice": maxPrice,
    "minPrice": minPrice,
    "totalPages": totalPages,
    "totalElements": totalElements,
    "first": first,
    "numberOfElements": numberOfElements,
    "size": size,
    "number": number,
    "empty": empty,
    "last": last,
    "status": status,
  };
}

class TrendingItems {
  TrendingItems({
    this.model,
    this.name,
    this.sku,
    this.desc,
    this.specification,
    this.id,
    this.price,
    this.review,
    this.slug,
    this.updown,
    this.images,
    this.stock,
    this.imgUrl,
    this.category,
  });

  String ? model;
  String ? name;
  String ? sku;
  dynamic desc;
  dynamic specification;
  dynamic id;
  Price ? price;
  Review ? review;
  String ? slug;
  dynamic updown;
  List<dynamic> ? images;
  int ? stock;
  String ? imgUrl;
  Category ? category;

  factory TrendingItems.fromJson(Map<String, dynamic> json) => TrendingItems(
    model: json["model"],
    name: json["name"],
    sku: json["sku"],
    desc: json["desc"],
    specification: json["specification"],
    id: json["id"],
    price: Price.fromJson(json["price"]),
    review: Review.fromJson(json["review"]),
    slug: json["slug"],
    updown: json["updown"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
    stock: json["stock"],
    imgUrl: json["imgUrl"],
    category: Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "model": model,
    "name": name,
    "sku": sku,
    "desc": desc,
    "specification": specification,
    "id": id,
    "price": price!.toJson(),
    "review": review!.toJson(),
    "slug": slug,
    "updown": updown,
    "images": List<dynamic>.from(images!.map((x) => x)),
    "stock": stock,
    "imgUrl": imgUrl,
    "category": category!.toJson(),
  };
}

class Category {
  Category({
    this.id,
    this.name,
    this.pid,
    this.desc,
    this.image,
    this.slug,
  });

  String ? id;
  String ? name;
  String ? pid;
  String ? desc;
  dynamic image;
  String ? slug;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    name: json["name"],
    pid: json["pid"],
    desc: json["desc"],
    image: json["image"],
    slug: json["slug"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "pid": pid,
    "desc": desc,
    "image": image,
    "slug": slug,
  };
}

class Price {
  Price({
    this.sale,
    this.dis,
  });

  String ? sale;
  String ? dis;

  factory Price.fromJson(Map<String, dynamic> json) => Price(
    sale: json["sale"],
    dis: json["dis"],
  );

  Map<String, dynamic> toJson() => {
    "sale": sale,
    "dis": dis,
  };
}

class Review {
  Review({
    this.reviewDetails,
    this.reviewCount,
  });

  List<dynamic> ? reviewDetails;
  int ? reviewCount;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    reviewDetails: List<dynamic>.from(json["reviewDetails"].map((x) => x)),
    reviewCount: json["reviewCount"],
  );

  Map<String, dynamic> toJson() => {
    "reviewDetails": List<dynamic>.from(reviewDetails!.map((x) => x)),
    "reviewCount": reviewCount,
  };
}
