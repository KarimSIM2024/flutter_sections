import '../../domain/entities/news_item.dart';
import '../../domain/repositories/news_repository.dart';
import '../datasources/database_helper.dart';

class NewsRepositoryImpl implements NewsRepository {
  final DatabaseHelper dbHelper;

  NewsRepositoryImpl(this.dbHelper);

  @override
  Future<List<NewsItem>> getFavorites() async {
    return await dbHelper.getFavorites();
  }

  @override
  Future<void> toggleFavorite(NewsItem item) async {
    final isFav = await dbHelper.isFavorite(item.id);
    if (isFav) {
      await dbHelper.deleteFavorite(item.id);
    } else {
      await dbHelper.insertFavorite(item);
    }
  }

  @override
  Future<bool> isFavorite(String id) async {
    return await dbHelper.isFavorite(id);
  }
}
