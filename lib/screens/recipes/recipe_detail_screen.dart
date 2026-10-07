import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../models/meal_model.dart';
import '../../services/api_service.dart';
import '../../services/user_manager.dart';
import '../../providers/auth_provider.dart';

class RecipeDetailScreen extends StatefulWidget {
  final MealShort recipe;
  const RecipeDetailScreen({super.key, required this.recipe});

  @override
  State<RecipeDetailScreen> createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  MealDetail? _detail;
  bool _isFav = false;
  bool _loadingFav = false;

  @override
  void initState() {
    super.initState();
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    final detail =
    await ApiService.shared.lookup(widget.recipe.idMeal);

    final auth = context.read<AuthProvider>();

    final user = await UserManager.shared.getUserByCredentials(
      email: auth.loggedInEmail,
      password: auth.loggedInPassword,
    );

    if (mounted) {
      setState(() {
        _detail = detail;

        // 🔥 CHECK FAV USING LIST
        _isFav = user != null
            ? user.favouriteIDs.contains(widget.recipe.idMeal)
            : false;
      });
    }
  }

  Future<void> _toggleFavourite() async {
    final auth = context.read<AuthProvider>();

    setState(() => _loadingFav = true);

    if (_isFav) {
      await UserManager.shared.removeFavourite(
        email: auth.loggedInEmail,
        id: widget.recipe.idMeal,
      );
    } else {
      await UserManager.shared.addFavourite(
        email: auth.loggedInEmail,
        id: widget.recipe.idMeal,
        name: widget.recipe.strMeal,
        image: widget.recipe.strMealThumb,
      );
    }

    if (mounted) {
      setState(() {
        _isFav = !_isFav;
        _loadingFav = false;
      });
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 🖼️ IMAGE
                Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: widget.recipe.strMealThumb,
                      height: 280,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),

                    // 🔙 BACK
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back,
                            color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    // ❤️ FAV BUTTON
                    Positioned(
                      top: 10,
                      right: 10,
                      child: _loadingFav
                          ? const CircularProgressIndicator(
                          color: Colors.white)
                          : IconButton(
                        icon: Icon(
                          _isFav
                              ? Icons.favorite
                              : Icons.favorite_border,
                          color: Colors.red,
                          size: 30,
                        ),
                        onPressed: _toggleFavourite,
                      ),
                    ),

                    // TITLE
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.black.withOpacity(0.7),
                              Colors.transparent
                            ],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Text(
                          _detail?.strMeal ??
                              widget.recipe.strMeal,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // CONTENT
                Container(
                  margin:
                  const EdgeInsets.symmetric(horizontal: 16),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Wrap(
                        spacing: 8,
                        children: [
                          if (_detail?.strCategory != null)
                            Chip(
                              label:
                              Text(_detail!.strCategory!),
                            ),
                          if (_detail?.strArea != null)
                            Chip(
                              label: Text(_detail!.strArea!),
                            ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      const Text(
                        "Instructions",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      _detail == null
                          ? const Center(
                          child:
                          CircularProgressIndicator())
                          : Text(
                        _detail!.strInstructions ??
                            "No instructions",
                        style: const TextStyle(
                          height: 1.7,
                        ),
                      ),

                      const SizedBox(height: 30),

                      const Text(
                        "Cooking Tips 👨‍🍳",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 10),

                      const Text("✔ Use fresh ingredients"),
                      const Text("✔ Follow steps"),
                      const Text("✔ Taste while cooking"),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}