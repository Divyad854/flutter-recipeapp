# Recipe App - Flutter

A full Flutter conversion of the iOS SwiftUI Recipe App.

## Features

- **Login / Register** — stored locally via SharedPreferences (mirrors CoreData)
- **Home Screen** — welcome message + Explore Recipes button
- **Veg Recipes** — fetches Vegetarian & Vegan meals from TheMealDB API, with search
- **Non-Veg Recipes** — fetches Chicken, Beef, Pork, Lamb, Seafood meals, with search
- **Recipe Detail** — full instructions + ❤️ favourite toggle per user
- **Favourites** — saved per user account, swipe-to-delete
- **Contact** — Recipe provider cards (Krisha Kitchen, Taste of Home, Foodie's Choice)
- **Profile** — Welcome message, My Favourites link, Logout

## API

Uses [TheMealDB](https://www.themealdb.com/api.php) free API — no key needed.

## Setup

### Prerequisites
- Flutter SDK ≥ 3.0.0
- Android Studio (for Android) or Xcode (for iOS)

### Steps

```bash
# 1. Open this folder in Android Studio or VS Code
cd recipe_app

# 2. Get dependencies
flutter pub get

# 3. Run on Android emulator or device
flutter run
```

### Open in Android Studio
1. Open Android Studio
2. Click **Open** → select the `recipe_app` folder
3. Wait for Gradle sync
4. Click **Run ▶**

## Project Structure

```
lib/
├── main.dart                  # Entry point
├── main_tab_view.dart         # Bottom nav (5 tabs)
├── models/
│   ├── meal_model.dart        # MealShort, MealDetail
│   └── user_model.dart        # UserModel
├── services/
│   ├── api_service.dart       # TheMealDB API calls
│   └── user_manager.dart      # Register/Login/Favourites
├── providers/
│   └── auth_provider.dart     # Login state
└── screens/
    ├── auth/                  # Login, Register
    ├── home/                  # Home screen
    ├── veg/                   # Veg recipes
    ├── nonveg/                # Non-veg recipes
    ├── recipes/               # Main, List, Detail
    ├── favourites/            # Favourites list
    ├── contact/               # Provider contacts
    └── profile/               # Profile + logout
```
