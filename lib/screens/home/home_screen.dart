import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../recipes/recipe_main_screen.dart';
import '../profile/profile_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final username =
        context.watch<AuthProvider>().loggedInUsername;

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
                padding:
                const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Recipe App",
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const ProfileScreen(),
                          ),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor:
                        Colors.white.withOpacity(0.2),
                        child: Text(
                          username.isNotEmpty
                              ? username[0].toUpperCase()
                              : "U",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      // 👋 HERO
                      Text(
                        "Hello ${username.isNotEmpty ? username : "Chef"} 👋",
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Text(
                        "Cook something delicious today 🍳",
                        style: TextStyle(color: Colors.white70),
                      ),

                      const SizedBox(height: 25),

                      // 🍽 FEATURE
                      Container(
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
                            const Text(
                              "Explore Recipes",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight:
                                  FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              "Find recipes based on ingredients and categories.",
                              style: TextStyle(
                                  color: Colors.black54),
                            ),
                            const SizedBox(height: 20),

                            SizedBox(
                              width: double.infinity,
                              height: 50,
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) =>
                                      const RecipeMainScreen(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  const Color(0xFF0D47A1),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                        14),
                                  ),
                                ),
                                child: const Text(
                                  "Explore Recipes",
                                  style: TextStyle(
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 🍱 CATEGORIES
                      const Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 15),

                      SizedBox(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            _CategoryItem("Breakfast",
                                Icons.free_breakfast),
                            _CategoryItem(
                                "Lunch", Icons.lunch_dining),
                            _CategoryItem(
                                "Dinner",
                                Icons.dinner_dining),
                            _CategoryItem(
                                "Non-Veg", Icons.set_meal),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 🔥 POPULAR
                      const Text(
                        "Popular Dishes",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(height: 15),

                      Column(
                        children: const [
                          _InfoCard("Paneer Butter Masala 🍛"),
                          _InfoCard("Chicken Biryani 🍗"),
                          _InfoCard("Veg Fried Rice 🍚"),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // 📘 ABOUT APP
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color:
                          Colors.white.withOpacity(0.95),
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: const [
                            Row(
                              children: [
                                Icon(Icons.info_outline,
                                    color: Color(0xFF1565C0)),
                                SizedBox(width: 8),
                                Text(
                                  "About App",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            _FeatureItem(Icons.search,
                                "Discover new recipes easily"),
                            _FeatureItem(Icons.filter_alt,
                                "Filter by ingredients"),
                            _FeatureItem(Icons.favorite,
                                "Save your favorites"),
                            _FeatureItem(Icons.speed,
                                "Simple and fast UI"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 💡 COOKING TIPS
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color:
                          Colors.white.withOpacity(0.95),
                          borderRadius:
                          BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: const [
                            Row(
                              children: [
                                Icon(Icons.lightbulb_outline,
                                    color: Colors.orange),
                                SizedBox(width: 8),
                                Text(
                                  "Cooking Tips",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight:
                                      FontWeight.bold),
                                ),
                              ],
                            ),
                            SizedBox(height: 15),
                            _FeatureItem(Icons.eco,
                                "Use fresh ingredients"),
                            _FeatureItem(Icons.timer,
                                "Follow proper timing"),
                            _FeatureItem(Icons.restaurant_menu,
                                "Taste while cooking"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 🔵 CATEGORY
class _CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const _CategoryItem(this.title, this.icon);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Color(0xFF1565C0)),
          const SizedBox(height: 8),
          Text(title, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

// 🔵 INFO CARD
class _InfoCard extends StatelessWidget {
  final String text;

  const _InfoCard(this.text);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.restaurant,
              color: Color(0xFF1565C0)),
          const SizedBox(width: 10),
          Text(text),
        ],
      ),
    );
  }
}

// 🔥 FEATURE ITEM
class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String text;

  const _FeatureItem(this.icon, this.text);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor:
            const Color(0xFF1565C0).withOpacity(0.1),
            child: Icon(icon,
                size: 16, color: Color(0xFF1565C0)),
          ),
          const SizedBox(width: 12),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}


