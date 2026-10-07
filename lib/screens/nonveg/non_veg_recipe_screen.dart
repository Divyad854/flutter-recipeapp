import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/meal_model.dart';
import '../../services/api_service.dart';
import '../recipes/recipe_detail_screen.dart';

class NonVegRecipeScreen extends StatefulWidget {
  const NonVegRecipeScreen({super.key});

  @override
  State<NonVegRecipeScreen> createState() => _NonVegRecipeScreenState();
}

class _NonVegRecipeScreenState extends State<NonVegRecipeScreen> {
  List<MealShort> _meals = [];
  bool _isLoading = true;
  String _searchText = '';
  final _searchController = TextEditingController();

  List<MealShort> get _filteredMeals {
    if (_searchText.isEmpty) return _meals;
    return _meals
        .where((m) =>
        m.strMeal.toLowerCase().contains(_searchText.toLowerCase()))
        .toList();
  }

  @override
  void initState() {
    super.initState();
    _loadNonVegMeals();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadNonVegMeals() async {
    try {
      final meals = await ApiService.shared.fetchNonVegMeals();
      if (mounted) {
        setState(() {
          _meals = meals;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0F2027),
              Color(0xFF2C5364),
              Color(0xFF4CA1AF),
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              // 🔵 HEADER
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    IconButton(
                      icon:
                      const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () => Navigator.pop(context),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "Non-Veg Recipes 🍗",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // 🔍 SEARCH BAR
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.search, color: Colors.grey),
                      const SizedBox(width: 8),
                      Expanded(
                        child: TextField(
                          controller: _searchController,
                          decoration: const InputDecoration(
                            hintText: 'Search recipes...',
                            border: InputBorder.none,
                          ),
                          onChanged: (val) =>
                              setState(() => _searchText = val),
                        ),
                      ),
                      if (_searchText.isNotEmpty)
                        GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() => _searchText = '');
                          },
                          child: const Icon(Icons.close, size: 20),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // 📜 BODY
              Expanded(
                child: _isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                      color: Colors.white),
                )
                    : _filteredMeals.isEmpty
                    ? const Center(
                  child: Text(
                    "No Recipes Found",
                    style: TextStyle(color: Colors.white),
                  ),
                )
                    : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _filteredMeals.length,
                  itemBuilder: (context, index) {
                    final meal = _filteredMeals[index];
                    return _RecipeCard(meal: meal);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔥 PREMIUM CARD
class _RecipeCard extends StatelessWidget {
  final MealShort meal;

  const _RecipeCard({required this.meal});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => RecipeDetailScreen(recipe: meal),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            )
          ],
        ),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: CachedNetworkImage(
                imageUrl: meal.strMealThumb,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // 🌑 OVERLAY
            Container(
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),

            // 📌 TITLE
            Positioned(
              bottom: 15,
              left: 15,
              right: 15,
              child: Text(
                meal.strMeal,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            // ❤️ ICON
            const Positioned(
              top: 10,
              right: 10,
              child: Icon(Icons.set_meal, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}