class NewsDetailsModel{
  String id;
  String title;
  String fullPost;
  String image;
  String date;
  String cat;

  NewsDetailsModel({this.id,this.title,this.image,this.fullPost,this.date,this.cat});

  NewsDetailsModel.fromJson(Map<String, dynamic> json){
    title = json['Title'];
    id = json['ID'];
    image = json['Image'];
    fullPost = json['FullPost'];
    date = json['Date'];
    cat = json['Cat'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['Title'] = this.title;
    data['Image'] = this.image;
    data['FullPost'] = this.fullPost;
    data['Date'] = this.date;
    data['Cat'] = this.cat;
    return data;
  }

  Map<String,dynamic> toMap(){
    var map = new Map<String,dynamic>();
    map['Title'] = title;
    map['FullPost'] = fullPost;
    map['Image'] = image;
    map['Date'] = date;
    map['Cat'] = cat;
    if(id != null){
      map['ID'] = id;
    }
    return map;
  }
}

class CategoryModel{
  String id;
  String title;
  String icon;

  CategoryModel({this.id, this.title, this.icon});

  CategoryModel.fromJson(Map<String, dynamic> json){
    id = json['ID'];
    title = json['Title'];
    icon = json['Icon'];
  }

  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.id;
    data['Title'] = this.title;
    data['Icon'] = this.icon;
    return data;
  }
}