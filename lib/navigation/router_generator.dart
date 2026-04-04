import 'package:flutter/material.dart';
import '../screens/home.dart';
import '../screens/details.dart';
import '../screens/news.dart';
import '../screens/news_details.dart';
import '../screens/favorite.dart';
import '../model/news_item.dart';
import 'app_routes.dart';

class RouterGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final args = settings.arguments;

    switch (settings.name) {
      case AppRoutes.home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case AppRoutes.details:
        // DetailsScreen might take arguments if needed, for now it's simple
        return MaterialPageRoute(builder: (_) => const DetailsScreen());
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
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('Page not found')),
      );
    });
  }
}
