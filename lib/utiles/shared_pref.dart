import 'package:shared_preferences/shared_preferences.dart';

class AuthPrefs {
  static const _usernameKey = "username";
  static const _emailKey = "email";
  static const _passKey = "password";
  static const _isLoggedInKey = "isLoggedIn";
  static const _bookmarksKey = "bookmarks";

  // --- Auth Methods ---
  static Future<void> saveUser({
    required String username,
    required String email,
    required String password,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usernameKey, username);
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passKey, password);
  }

  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passKey);
  }

  static Future<bool> checkIfUserExists(String email) async {
    final storedEmail = await getEmail();
    return storedEmail == email;
  }

  static Future<String?> validateLogin(String email, String password) async {
    final storedEmail = await getEmail();
    final storedPass = await getPassword();

    // Generic Security Feedback
    if (storedEmail == null || storedEmail != email || storedPass != password) {
      return "Invalid email or password";
    }
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, true);
    return null; // Success
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, false);
  }

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  // --- Bookmark Methods ---
  static Future<void> toggleBookmark(String newsTitle) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    if (bookmarks.contains(newsTitle)) {
      bookmarks.remove(newsTitle);
    } else {
      bookmarks.add(newsTitle);
    }
    await prefs.setStringList(_bookmarksKey, bookmarks);
  }

  static Future<bool> isBookmarked(String newsTitle) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> bookmarks = prefs.getStringList(_bookmarksKey) ?? [];
    return bookmarks.contains(newsTitle);
  }

  static Future<List<String>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(_bookmarksKey) ?? [];
  }
}
