class CategoriesModel {
  bool status;
  CategoriesDataModel data;
  CategoriesModel.fromJson(Map<String, dynamic> categoriesjson) {
    status = categoriesjson["status"];
    data = CategoriesDataModel.fromJson(categoriesjson["data"]);
  }
}

class CategoriesDataModel {
  dynamic current_page;
  List<DataModel> data = [];
  CategoriesDataModel.fromJson(Map<String, dynamic> jsondata) {
    current_page = jsondata["current_page"];
    jsondata["data"].forEach((element) {
      data.add(DataModel.fromJson(element));
    });
  }
}

class DataModel {
  dynamic id;
  String name;
  String image;
  DataModel.fromJson(Map<String, dynamic> json) {
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
}
