import 'package:flutter/material.dart';
import '../screens/news.dart';
import '../screens/news_details.dart';
import '../screens/favorite.dart';
import '../screens/signup.dart';
import '../screens/login.dart';
import '../model/news_item.dart';
import 'app_routes.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());
      case AppRoutes.login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case AppRoutes.news:
        return MaterialPageRoute(builder: (_) => const NewsScreen());
      case AppRoutes.newsDetails:
        if (args is NewsItem) {
          return MaterialPageRoute(
            builder: (_) => NewsDetailScreen(newsItem: args),
          );
        }
        return _errorRoute();
      case AppRoutes.favorite:
        return MaterialPageRoute(builder: (_) => const FavoriteScreen());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(title: const Text('Error')),
          body: const Center(child: Text('Page not found')),
        );
      },
    );
  }
}
