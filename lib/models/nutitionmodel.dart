class NutritionModel{
  String?nutritionName;
  String?nutritionValue;
  String?ProductId;
  String?id;

  NutritionModel({this.nutritionName, this.nutritionValue, this.ProductId, this.id});
  NutritionModel.fromJson(Map<String, dynamic>json){
     nutritionName =json['nutrionName'];
     nutritionValue = json['nutritionValue'];
     ProductId = json['productId'];
     id = json['id'];

  }
  Map<String, dynamic> toJson(){
    final Map<String, dynamic> data ={};
    data['nutrionName'] =nutritionName;
    data['nutritionValue'] = nutritionValue;
    data['productId'] = ProductId;
    data['id'] = id;

    return data;
  }
}