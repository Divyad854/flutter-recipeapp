import 'package:flutter/material.dart';

class ContactScreen extends StatelessWidget {
  const ContactScreen({super.key});

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
                      "Recipe Providers",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // 📜 BODY
              Expanded(
                child: SingleChildScrollView(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  child: Column(
                    children: const [
                      ProviderCard(
                        icon: Icons.person,
                        name: 'Krisha Kitchen',
                        contact: '+91 98765 43210',
                        location: 'Surat, Gujarat',
                        about:
                        'Authentic homemade recipes curated with traditional spices and fresh ingredients.',
                      ),
                      SizedBox(height: 16),
                      ProviderCard(
                        icon: Icons.restaurant,
                        name: 'Taste of Home',
                        contact: '+91 91234 56789',
                        location: 'Ahmedabad, Gujarat',
                        about:
                        'Daily homemade dishes inspired by traditional Gujarati and North Indian cuisine.',
                      ),
                      SizedBox(height: 16),
                      ProviderCard(
                        icon: Icons.takeout_dining,
                        name: "Foodie's Choice",
                        contact: '+91 90000 11223',
                        location: 'Vadodara, Gujarat',
                        about:
                        'Unique fusion recipes crafted using both modern and traditional cooking styles.',
                      ),
                      SizedBox(height: 30),
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

// 🔥 PREMIUM CARD
class ProviderCard extends StatelessWidget {
  final IconData icon;
  final String name;
  final String contact;
  final String location;
  final String about;

  const ProviderCard({
    super.key,
    required this.icon,
    required this.name,
    required this.contact,
    required this.location,
    required this.about,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.95),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👤 HEADER ROW
          Row(
            children: [
              CircleAvatar(
                radius: 28,
                backgroundColor: const Color(0xFF0D47A1),
                child: Icon(icon, color: Colors.white, size: 26),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),

          const SizedBox(height: 14),

          // 📞 CONTACT
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.green, size: 18),
              const SizedBox(width: 8),
              Text(
                contact,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // 📍 LOCATION
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.red, size: 18),
              const SizedBox(width: 8),
              Text(
                location,
                style: const TextStyle(color: Colors.black54),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // 📘 ABOUT
          const Text(
            "About Provider",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            about,
            style: const TextStyle(
              color: Colors.black54,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}