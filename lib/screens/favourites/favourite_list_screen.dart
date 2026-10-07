import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../services/user_manager.dart';
import '../../providers/auth_provider.dart';
import '../../models/meal_model.dart';
import '../recipes/recipe_detail_screen.dart';

class FavouriteListScreen extends StatefulWidget {
  const FavouriteListScreen({super.key});

  @override
  State<FavouriteListScreen> createState() =>
      _FavouriteListScreenState();
}

class _FavouriteListScreenState
    extends State<FavouriteListScreen> {
  List<String> _ids = [];
  List<String> _names = [];
  List<String> _images = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavourites();
  }

  Future<void> _loadFavourites() async {
    final auth = context.read<AuthProvider>();

    final user = await UserManager.shared.getUserByCredentials(
      email: auth.loggedInEmail,
      password: auth.loggedInPassword, // keep for login
    );

    if (mounted) {
      setState(() {
        _ids = user?.favouriteIDs ?? [];
        _names = user?.favouriteNames ?? [];
        _images = user?.favouriteImages ?? [];
        _isLoading = false;
      });
    }
  }

  Future<void> _removeFavourite(int index) async {
    final auth = context.read<AuthProvider>();

    // 🔥 FIXED (NO PASSWORD)
    await UserManager.shared.removeFavourite(
      email: auth.loggedInEmail,
      id: _ids[index],
    );

    await _loadFavourites();
  }

  void _openRecipe(int index) {
    final meal = MealShort(
      idMeal: _ids[index],
      strMeal: _names[index],
      strMealThumb: _images[index],
    );

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RecipeDetailScreen(recipe: meal),
      ),
    );
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
                      icon: const Icon(Icons.arrow_back,
                          color: Colors.white),
                      onPressed: () =>
                          Navigator.pop(context),
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      "My Favourites ❤️",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // 📜 BODY
              Expanded(
                child: _isLoading
                    ? const Center(
                  child: CircularProgressIndicator(
                      color: Colors.white),
                )
                    : _ids.isEmpty
                    ? const Center(
                  child: Column(
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Icon(Icons.favorite_border,
                          size: 80,
                          color: Colors.white54),
                      SizedBox(height: 16),
                      Text(
                        'No favourites yet',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18),
                      ),
                    ],
                  ),
                )
                    : ListView.builder(
                  padding:
                  const EdgeInsets.all(16),
                  itemCount: _ids.length,
                  itemBuilder:
                      (context, index) {
                    return Dismissible(
                      key: Key(_ids[index]),
                      direction:
                      DismissDirection
                          .endToStart,
                      onDismissed: (_) =>
                          _removeFavourite(
                              index),
                      background: Container(
                        alignment:
                        Alignment.centerRight,
                        padding:
                        const EdgeInsets.only(
                            right: 20),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius:
                          BorderRadius.circular(
                              20),
                        ),
                        child: const Icon(
                            Icons.delete,
                            color:
                            Colors.white),
                      ),
                      child: GestureDetector(
                        onTap: () =>
                            _openRecipe(index),
                        child: Container(
                          margin:
                          const EdgeInsets.only(
                              bottom: 16),
                          decoration:
                          BoxDecoration(
                            borderRadius:
                            BorderRadius
                                .circular(
                                20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black
                                    .withOpacity(
                                    0.3),
                                blurRadius: 10,
                                offset:
                                const Offset(
                                    0, 6),
                              )
                            ],
                          ),
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius:
                                BorderRadius
                                    .circular(
                                    20),
                                child:
                                CachedNetworkImage(
                                  imageUrl:
                                  _images[
                                  index],
                                  height: 180,
                                  width: double
                                      .infinity,
                                  fit: BoxFit
                                      .cover,
                                ),
                              ),

                              Container(
                                height: 180,
                                decoration:
                                BoxDecoration(
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                      20),
                                  gradient:
                                  LinearGradient(
                                    colors: [
                                      Colors.black
                                          .withOpacity(
                                          0.6),
                                      Colors
                                          .transparent
                                    ],
                                    begin: Alignment
                                        .bottomCenter,
                                    end: Alignment
                                        .topCenter,
                                  ),
                                ),
                              ),

                              Positioned(
                                bottom: 15,
                                left: 15,
                                right: 15,
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _names[
                                        index],
                                        style:
                                        const TextStyle(
                                          color: Colors
                                              .white,
                                          fontWeight:
                                          FontWeight
                                              .bold,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons
                                          .favorite,
                                      color: Colors
                                          .red,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
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