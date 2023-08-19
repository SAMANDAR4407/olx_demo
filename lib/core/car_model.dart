class CarModel {
  final int id;
  final String url;
  final String title;
  final DateTime lastRefreshTime;
  final DateTime createdTime;
  final String description;
  final List<Photo> photos;
  final List<Param> params;

  CarModel({
    required this.id,
    required this.url,
    required this.title,
    required this.lastRefreshTime,
    required this.createdTime,
    required this.description,
    required this.photos,
    required this.params,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) => CarModel(
    id: json["id"] ?? 0,
    url: json["url"] ?? "",
    title: json["title"] ?? "",
    lastRefreshTime: DateTime.parse(json["last_refresh_time"]??'==/==/===='),
    createdTime: DateTime.parse(json["created_time"]??'==/==/===='),
    description: json["description"] ?? "",
    photos: List<Photo>.from((json["photos"] ?? []).map((x) => Photo.fromJson(x))),
    params: List<Param>.from((json["params"] ?? []).map((x) => Param.fromJson(x))),
  );
}
class Param {
  final String key;
  final String name;
  final String type;
  final Value value;

  Param({
    required this.key,
    required this.name,
    required this.type,
    required this.value,
  });

  factory Param.fromJson(Map<String, dynamic> json) => Param(
    key: json["key"] ?? "",
    name: json["name"] ?? "",
    type: json["type"] ?? "",
    value: Value.fromJson((json["value"] ?? {})),
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "name": name,
    "type": type,
    "value": value.toJson(),
  };
}

class Value {
  final dynamic key;
  final String label;
  final int value;

  Value({
    required this.key,
    required this.label,
    required this.value,
  });

  factory Value.fromJson(Map<String, dynamic> json) => Value(
    key: json["key"] ?? "",
    label: json["label"]??"",
    value: json["value"]??0,
  );

  Map<String, dynamic> toJson() => {
    "key": key,
    "label": label,
    "value": value,
  };
}

class Photo {
  final int id;
  final String filename;
  final int rotation;
  final int width;
  final int height;
  final String link;

  Photo({
    required this.id,
    required this.filename,
    required this.rotation,
    required this.width,
    required this.height,
    required this.link,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json["id"] ?? 0,
      filename: json["filename"] ?? "",
      rotation: json["rotation"] ?? 0,
      width: json["width"] ?? 0,
      height: json["height"] ?? 0,
      link: (json["link"] ?? "").replaceAll(";s={width}x{height}", ""),
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "filename": filename,
    "rotation": rotation,
    "width": width,
    "height": height,
    "link": link,
  };
}

/*
class Category {
  final int id;
  final String type;

  Category({
    required this.id,
    required this.type,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["id"],
    type: json["type"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
  };
}

class Contact {
  final String name;
  final bool phone;
  final bool chat;
  final bool negotiation;
  final bool courier;

  Contact({
    required this.name,
    required this.phone,
    required this.chat,
    required this.negotiation,
    required this.courier,
  });

  factory Contact.fromJson(Map<String, dynamic> json) => Contact(
    name: json["name"],
    phone: json["phone"],
    chat: json["chat"],
    negotiation: json["negotiation"],
    courier: json["courier"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "chat": chat,
    "negotiation": negotiation,
    "courier": courier,
  };
}

class Delivery {
  final Rock rock;

  Delivery({
    required this.rock,
  });

  factory Delivery.fromJson(Map<String, dynamic> json) => Delivery(
    rock: Rock.fromJson(json["rock"]),
  );

  Map<String, dynamic> toJson() => {
    "rock": rock.toJson(),
  };
}

class Rock {
  final String offerId;
  final bool active;
  final String mode;

  Rock({
    required this.offerId,
    required this.active,
    required this.mode,
  });

  factory Rock.fromJson(Map<String, dynamic> json) => Rock(
    offerId: json["offer_id"],
    active: json["active"],
    mode: json["mode"],
  );

  Map<String, dynamic> toJson() => {
    "offer_id": offerId,
    "active": active,
    "mode": mode,
  };
}

class Location {
  final City city;
  final District district;
  final City region;

  Location({
    required this.city,
    required this.district,
    required this.region,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    city: City.fromJson(json["city"]),
    district: District.fromJson(json["district"]),
    region: City.fromJson(json["region"]),
  );

  Map<String, dynamic> toJson() => {
    "city": city.toJson(),
    "district": district.toJson(),
    "region": region.toJson(),
  };
}

class City {
  final int id;
  final String name;
  final String normalizedName;

  City({
    required this.id,
    required this.name,
    required this.normalizedName,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    name: json["name"],
    normalizedName: json["normalized_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "normalized_name": normalizedName,
  };
}

class District {
  final int id;
  final String name;

  District({
    required this.id,
    required this.name,
  });

  factory District.fromJson(Map<String, dynamic> json) => District(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}

class MapClass {
  final int zoom;
  final double lat;
  final double lon;
  final int radius;
  final bool showDetailed;

  MapClass({
    required this.zoom,
    required this.lat,
    required this.lon,
    required this.radius,
    required this.showDetailed,
  });

  factory MapClass.fromJson(Map<String, dynamic> json) => MapClass(
    zoom: json["zoom"],
    lat: json["lat"]?.toDouble(),
    lon: json["lon"]?.toDouble(),
    radius: json["radius"],
    showDetailed: json["show_detailed"],
  );

  Map<String, dynamic> toJson() => {
    "zoom": zoom,
    "lat": lat,
    "lon": lon,
    "radius": radius,
    "show_detailed": showDetailed,
  };
}

class Promotion {
  final bool highlighted;
  final bool urgent;
  final bool topAd;
  final List<String> options;
  final bool b2CAdPage;
  final bool premiumAdPage;

  Promotion({
    required this.highlighted,
    required this.urgent,
    required this.topAd,
    required this.options,
    required this.b2CAdPage,
    required this.premiumAdPage,
  });

  factory Promotion.fromJson(Map<String, dynamic> json) => Promotion(
    highlighted: json["highlighted"] ?? false,
    urgent: json["urgent"] ?? false,
    topAd: json["top_ad"] ?? false,
    options: List<String>.from((json["options"] ?? []).map((x) => x)),
    b2CAdPage: json["b2c_ad_page"] ?? false,
    premiumAdPage: json["premium_ad_page"] ?? false,
  );

  Map<String, dynamic> toJson() => {
    "highlighted": highlighted,
    "urgent": urgent,
    "top_ad": topAd,
    "options": List<dynamic>.from(options.map((x) => x)),
    "b2c_ad_page": b2CAdPage,
    "premium_ad_page": premiumAdPage,
  };
}

class Safedeal {
  final int weight;
  final int weightGrams;
  final String status;
  final bool safedealBlocked;

  Safedeal({
    required this.weight,
    required this.weightGrams,
    required this.status,
    required this.safedealBlocked,
  });

  factory Safedeal.fromJson(Map<String, dynamic> json) => Safedeal(
    weight: json["weight"],
    weightGrams: json["weight_grams"],
    status: json["status"],
    safedealBlocked: json["safedeal_blocked"],
  );

  Map<String, dynamic> toJson() => {
    "weight": weight,
    "weight_grams": weightGrams,
    "status": status,
    "safedeal_blocked": safedealBlocked,
  };
}

class Shop {
  final String subdomain;

  Shop({
    required this.subdomain,
  });

  factory Shop.fromJson(Map<String, dynamic> json) => Shop(
    subdomain: json["subdomain"],
  );

  Map<String, dynamic> toJson() => {
    "subdomain": subdomain,
  };
}

class User {
  final int id;
  final DateTime created;
  final bool otherAdsEnabled;
  final String name;
  final String logo;
  final String logoAdPage;
  final String socialNetworkAccountType;
  final dynamic photo;
  final String bannerMobile;
  final String bannerDesktop;
  final String companyName;
  final String about;
  final bool b2CBusinessPage;
  final bool isOnline;
  final DateTime lastSeen;
  final String sellerType;
  final String uuid;

  User({
    required this.id,
    required this.created,
    required this.otherAdsEnabled,
    required this.name,
    required this.logo,
    required this.logoAdPage,
    required this.socialNetworkAccountType,
    required this.photo,
    required this.bannerMobile,
    required this.bannerDesktop,
    required this.companyName,
    required this.about,
    required this.b2CBusinessPage,
    required this.isOnline,
    required this.lastSeen,
    required this.sellerType,
    required this.uuid,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    created: DateTime.parse(json["created"]),
    otherAdsEnabled: json["other_ads_enabled"],
    name: json["name"],
    logo: json["logo"],
    logoAdPage: json["logo_ad_page"],
    socialNetworkAccountType: json["social_network_account_type"],
    photo: json["photo"],
    bannerMobile: json["banner_mobile"],
    bannerDesktop: json["banner_desktop"],
    companyName: json["company_name"],
    about: json["about"],
    b2CBusinessPage: json["b2c_business_page"],
    isOnline: json["is_online"],
    lastSeen: DateTime.parse(json["last_seen"]),
    sellerType: json["seller_type"],
    uuid: json["uuid"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "created": created.toIso8601String(),
    "other_ads_enabled": otherAdsEnabled,
    "name": name,
    "logo": logo,
    "logo_ad_page": logoAdPage,
    "social_network_account_type": socialNetworkAccountType,
    "photo": photo,
    "banner_mobile": bannerMobile,
    "banner_desktop": bannerDesktop,
    "company_name": companyName,
    "about": about,
    "b2c_business_page": b2CBusinessPage,
    "is_online": isOnline,
    "last_seen": lastSeen.toIso8601String(),
    "seller_type": sellerType,
    "uuid": uuid,
  };
}

// void main() {
//   final model = Promotion.fromJson({});
//   //DateTime.parse("2000");
//   print("hello");
// }
*/
