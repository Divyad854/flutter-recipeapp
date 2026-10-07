// meal_model.dart - matches iOS Models.swift

class MealShort {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;

  MealShort({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
  });

  factory MealShort.fromJson(Map<String, dynamic> json) {
    return MealShort(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
    );
  }
}

class MealDetail {
  final String idMeal;
  final String strMeal;
  final String? strInstructions;
  final String? strMealThumb;
  final String? strCategory;
  final String? strArea;
  final String? strYoutube;

  MealDetail({
    required this.idMeal,
    required this.strMeal,
    this.strInstructions,
    this.strMealThumb,
    this.strCategory,
    this.strArea,
    this.strYoutube,
  });

  factory MealDetail.fromJson(Map<String, dynamic> json) {
    return MealDetail(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strInstructions: json['strInstructions'],
      strMealThumb: json['strMealThumb'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strYoutube: json['strYoutube'],
    );
  }
}
