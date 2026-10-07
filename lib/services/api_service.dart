// api_service.dart - mirrors iOS APIService.swift

import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/meal_model.dart';

class ApiService {
  static final ApiService shared = ApiService._internal();
  ApiService._internal();

  static const String _base = 'https://www.themealdb.com/api/json/v1/1/';

  static const List<String> vegCategories = ['Vegetarian', 'Vegan'];
  static const List<String> nonVegCategories = [
    'Chicken',
    'Beef',
    'Pork',
    'Lamb',
    'Seafood'
  ];
  static const List<String> allCategories = [
    'Vegetarian',
    'Vegan',
    'Chicken',
    'Beef',
    'Pork',
    'Lamb',
    'Seafood'
  ];

  Future<List<MealShort>> fetchByIngredient(String ingredient) async {
    try {
      final uri = Uri.parse('${_base}filter.php?i=$ingredient');
      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        return meals?.map((m) => MealShort.fromJson(m)).toList() ?? [];
      }
    } catch (_) {}
    return [];
  }

  Future<MealDetail?> lookup(String id) async {
    try {
      final uri = Uri.parse('${_base}lookup.php?i=$id');
      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        if (meals != null && meals.isNotEmpty) {
          return MealDetail.fromJson(meals.first);
        }
      }
    } catch (_) {}
    return null;
  }

  Future<List<MealShort>> fetchByCategory(String category) async {
    try {
      final uri = Uri.parse('${_base}filter.php?c=$category');
      final response = await http.get(uri).timeout(const Duration(seconds: 15));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final meals = data['meals'] as List?;
        return meals?.map((m) => MealShort.fromJson(m)).toList() ?? [];
      }
    } catch (_) {}
    return [];
  }

  Future<List<MealShort>> fetchVegMeals() async {
    List<MealShort> result = [];
    for (final cat in vegCategories) {
      final list = await fetchByCategory(cat);
      result.addAll(list);
    }
    result.sort((a, b) => a.strMeal.compareTo(b.strMeal));
    return result;
  }

  Future<List<MealShort>> fetchNonVegMeals() async {
    List<MealShort> result = [];
    for (final cat in nonVegCategories) {
      final list = await fetchByCategory(cat);
      result.addAll(list);
    }
    result.sort((a, b) => a.strMeal.compareTo(b.strMeal));
    return result;
  }

  Future<List<MealShort>> fetchAllMeals() async {
    List<MealShort> result = [];
    for (final cat in allCategories) {
      final list = await fetchByCategory(cat);
      result.addAll(list);
    }
    result.sort((a, b) => a.strMeal.compareTo(b.strMeal));
    return result;
  }
}
