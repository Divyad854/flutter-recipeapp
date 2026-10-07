// user_model.dart

class UserModel {
  final String username;
  final String email;
  final String password;
  List<String> favouriteIDs;
  List<String> favouriteNames;
  List<String> favouriteImages;

  UserModel({
    required this.username,
    required this.email,
    required this.password,
    List<String>? favouriteIDs,
    List<String>? favouriteNames,
    List<String>? favouriteImages,
  })  : favouriteIDs = favouriteIDs ?? [],
        favouriteNames = favouriteNames ?? [],
        favouriteImages = favouriteImages ?? [];

  Map<String, dynamic> toJson() => {
        'username': username,
        'email': email,
        'password': password,
        'favouriteIDs': favouriteIDs,
        'favouriteNames': favouriteNames,
        'favouriteImages': favouriteImages,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      password: json['password'] ?? '',
      favouriteIDs: List<String>.from(json['favouriteIDs'] ?? []),
      favouriteNames: List<String>.from(json['favouriteNames'] ?? []),
      favouriteImages: List<String>.from(json['favouriteImages'] ?? []),
    );
  }
}
