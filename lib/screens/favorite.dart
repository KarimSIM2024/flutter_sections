import 'package:flutter/material.dart';
import '../domain/entities/news_item.dart' as entity;
import '../data/repositories/news_repository_impl.dart';
import '../data/datasources/database_helper.dart';
import '../navigation/app_routes.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  final NewsRepositoryImpl repository = NewsRepositoryImpl(DatabaseHelper.instance);
  List<entity.NewsItem> favoriteNews = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final favorites = await repository.getFavorites();
    setState(() {
      favoriteNews = favorites;
    });
  }

  Future<void> _toggleFavorite(entity.NewsItem item) async {
    await repository.toggleFavorite(item);
    _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmarks"),
        centerTitle: true,
      ),
      body: favoriteNews.isEmpty
          ? const Center(child: Text("No bookmarks yet."))
          : ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: favoriteNews.length,
              separatorBuilder: (_, _) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final item = favoriteNews[index];
                return ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      item.imagePath,
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, _, _) => Container(
                        width: 60,
                        height: 60,
                        color: Colors.grey[200],
                        child: const Icon(Icons.image_not_supported),
                      ),
                    ),
                  ),
                  title: Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.bookmark, color: Colors.amber),
                    onPressed: () => _toggleFavorite(item),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.newsDetails,
                      arguments: item,
                    ).then((_) => _loadFavorites());
                  },
                );
              },
            ),
    );
  }
}
