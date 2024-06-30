class LoginResponse {
  final String username;
  final String email;
  final String token;

  LoginResponse({
    required this.username,
    required this.email,
    required this.token,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      username: json['username'],
      email: json['email'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'token': token,
    };
  }
}
