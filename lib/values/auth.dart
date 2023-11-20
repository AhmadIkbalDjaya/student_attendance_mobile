class Auth {
  static String? token;
  static String? role;
  static int? id;
  static String? username;
  static String? email;
  static String? name;
  static String? phone;
  static String? gender;

  static void setAuth({
    String? token,
    String? role,
    int? id,
    String? username,
    String? email,
    String? name,
    String? phone,
    String? gender,
  }) {
    Auth.token = token;
    Auth.role = role;
    Auth.id = id;
    Auth.username = username;
    Auth.email = email;
    Auth.name = name;
    Auth.phone = phone;
    Auth.gender = gender;
  }

  static void resetAuth() {
    Auth.token = null;
    Auth.role = null;
    Auth.id = null;
    Auth.username = null;
    Auth.email = null;
    Auth.name = null;
    Auth.phone = null;
    Auth.gender = null;
  }
}
