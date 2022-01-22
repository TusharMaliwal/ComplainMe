class Beef{

  String id;
  String complainId;
  String name;
  String categoryId;
  double number;
  String imageUrl;
  String cityName;
  String stateName;
  String countryName;
  String categoryName;
  String complainName;

  Beef({required this.id, required this.complainId, required this.name, required this.categoryId,required this.number,required this.imageUrl,
      required this.cityName, required this.stateName, required this.countryName, required this.categoryName,required this.complainName});

  Map<String,Object> toJson(){
    return {
      'id' : id,
      'restaurant_id' : complainId,
      'name' : name,
      'category_id' : categoryId,
      'number':number,
      'image_url' : imageUrl,
      'city_name' : cityName,
      'state_name' : stateName,
      'country_name' : countryName,
      'category_name' : categoryName,
      'restaurant_name' : complainName,
    };
  }
}