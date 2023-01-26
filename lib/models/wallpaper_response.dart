class WallpaperResponse {
  WallpaperResponse({
      this.page, 
      this.perPage, 
      this.photos, 
      this.totalResults, 
      this.nextPage,});

  WallpaperResponse.fromJson(dynamic json) {
    page = json['page'];
    perPage = json['per_page'];
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(Photos.fromJson(v));
      });
    }
    totalResults = json['total_results'];
    nextPage = json['next_page'];
  }
  num? page;
  num? perPage;
  List<Photos>? photos;
  num? totalResults;
  String? nextPage;
WallpaperResponse copyWith({  num? page,
  num? perPage,
  List<Photos>? photos,
  num? totalResults,
  String? nextPage,
}) => WallpaperResponse(  page: page ?? this.page,
  perPage: perPage ?? this.perPage,
  photos: photos ?? this.photos,
  totalResults: totalResults ?? this.totalResults,
  nextPage: nextPage ?? this.nextPage,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['page'] = page;
    map['per_page'] = perPage;
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    map['total_results'] = totalResults;
    map['next_page'] = nextPage;
    return map;
  }

}

class Photos {
  Photos({
      this.id, 
      this.width, 
      this.height, 
      this.url, 
      this.photographer, 
      this.photographerUrl, 
      this.photographerId, 
      this.avgColor, 
      this.src, 
      this.liked, 
      this.alt,});

  Photos.fromJson(dynamic json) {
    id = json['id'];
    width = json['width'];
    height = json['height'];
    url = json['url'];
    photographer = json['photographer'];
    photographerUrl = json['photographer_url'];
    photographerId = json['photographer_id'];
    avgColor = json['avg_color'];
    src = json['src'] != null ? Src.fromJson(json['src']) : null;
    liked = json['liked'];
    alt = json['alt'];
  }
  num? id;
  num? width;
  num? height;
  String? url;
  String? photographer;
  String? photographerUrl;
  num? photographerId;
  String? avgColor;
  Src? src;
  bool? liked;
  String? alt;
Photos copyWith({  num? id,
  num? width,
  num? height,
  String? url,
  String? photographer,
  String? photographerUrl,
  num? photographerId,
  String? avgColor,
  Src? src,
  bool? liked,
  String? alt,
}) => Photos(  id: id ?? this.id,
  width: width ?? this.width,
  height: height ?? this.height,
  url: url ?? this.url,
  photographer: photographer ?? this.photographer,
  photographerUrl: photographerUrl ?? this.photographerUrl,
  photographerId: photographerId ?? this.photographerId,
  avgColor: avgColor ?? this.avgColor,
  src: src ?? this.src,
  liked: liked ?? this.liked,
  alt: alt ?? this.alt,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['width'] = width;
    map['height'] = height;
    map['url'] = url;
    map['photographer'] = photographer;
    map['photographer_url'] = photographerUrl;
    map['photographer_id'] = photographerId;
    map['avg_color'] = avgColor;
    if (src != null) {
      map['src'] = src?.toJson();
    }
    map['liked'] = liked;
    map['alt'] = alt;
    return map;
  }

}

class Src {
  Src({
      this.original, 
      this.large2x, 
      this.large, 
      this.medium, 
      this.small, 
      this.portrait, 
      this.landscape, 
      this.tiny,});

  Src.fromJson(dynamic json) {
    original = json['original'];
    large2x = json['large2x'];
    large = json['large'];
    medium = json['medium'];
    small = json['small'];
    portrait = json['portrait'];
    landscape = json['landscape'];
    tiny = json['tiny'];
  }
  String? original;
  String? large2x;
  String? large;
  String? medium;
  String? small;
  String? portrait;
  String? landscape;
  String? tiny;
Src copyWith({  String? original,
  String? large2x,
  String? large,
  String? medium,
  String? small,
  String? portrait,
  String? landscape,
  String? tiny,
}) => Src(  original: original ?? this.original,
  large2x: large2x ?? this.large2x,
  large: large ?? this.large,
  medium: medium ?? this.medium,
  small: small ?? this.small,
  portrait: portrait ?? this.portrait,
  landscape: landscape ?? this.landscape,
  tiny: tiny ?? this.tiny,
);
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['original'] = original;
    map['large2x'] = large2x;
    map['large'] = large;
    map['medium'] = medium;
    map['small'] = small;
    map['portrait'] = portrait;
    map['landscape'] = landscape;
    map['tiny'] = tiny;
    return map;
  }

}