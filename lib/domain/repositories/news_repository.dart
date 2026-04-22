import '../entities/news_item.dart';

abstract class NewsRepository {
  Future<List<NewsItem>> getFavorites();
  Future<void> toggleFavorite(NewsItem item);
  Future<bool> isFavorite(String id);
}
