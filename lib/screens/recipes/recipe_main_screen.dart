import 'package:flutter/material.dart';
import '../favourites/favourite_list_screen.dart';
import 'recipe_list_screen.dart';

class RecipeMainScreen extends StatefulWidget {
  const RecipeMainScreen({super.key});

  @override
  State<RecipeMainScreen> createState() => _RecipeMainScreenState();
}

class _RecipeMainScreenState extends State<RecipeMainScreen> {
  String _selectedVegetable = '';
  String _selectedMealType = '';

  final List<String> _vegetables = [
    'Tomato','Onion','Carrot','Spinach',
    'Broccoli','Cauliflower','Cabbage','Peas',
    'Garlic','Ginger'
  ];

  // ✅ DIFFERENT ICONS ADDED
  final Map<String, IconData> _vegIcons = {
    'Tomato': Icons.circle,
    'Onion': Icons.bubble_chart,
    'Carrot': Icons.park,
    'Spinach': Icons.eco,
    'Broccoli': Icons.grass,
    'Cauliflower': Icons.filter_vintage,
    'Cabbage': Icons.layers,
    'Peas': Icons.grid_on,
    'Garlic': Icons.spa,
    'Ginger': Icons.local_fire_department,
  };

  final List<String> _mealTypes = ['Breakfast','Lunch','Dinner'];

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
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Select Recipe",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.favorite, color: Colors.red),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                            const FavouriteListScreen(),
                          ),
                        );
                      },
                    )
                  ],
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Text(
                        "Choose Ingredients 🥕",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _vegetables.length,
                        gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 1,
                        ),
                        itemBuilder: (context, index) {
                          final veg = _vegetables[index];
                          final isSelected = _selectedVegetable == veg;

                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedVegetable = veg),
                            child: Container(
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF0D47A1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // 🔥 ICON FIX HERE
                                  Icon(
                                    _vegIcons[veg] ?? Icons.eco,
                                    size: 30,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.green,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    veg,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      const SizedBox(height: 25),

                      const Text(
                        "Meal Type 🍽",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 12),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: _mealTypes.map((meal) {
                          final isSelected = _selectedMealType == meal;

                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedMealType = meal),
                            child: Container(
                              width: 100,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color(0xFF0D47A1)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                children: [
                                  Icon(
                                    meal == "Breakfast"
                                        ? Icons.free_breakfast
                                        : meal == "Lunch"
                                        ? Icons.lunch_dining
                                        : Icons.dinner_dining,
                                    color: isSelected
                                        ? Colors.white
                                        : Colors.orange,
                                  ),
                                  const SizedBox(height: 6),
                                  Text(
                                    meal,
                                    style: TextStyle(
                                      color: isSelected
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                          onPressed: _selectedVegetable.isEmpty
                              ? null
                              : () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    RecipeListScreen(
                                      vegetable: _selectedVegetable,
                                      mealType: _selectedMealType,
                                    ),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF0D47A1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: const Text(
                            "Show Recipes",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),

                      const SizedBox(height: 30),
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