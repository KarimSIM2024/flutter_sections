import 'package:flutter/material.dart';
import '../model/news_item.dart';
import '../utiles/shared_pref.dart';
import '../navigation/app_routes.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  List<String> bookmarkedTitles = [];

  // Static list of news to match titles (In a real app, this would come from a data source)
  final List<NewsItem> allNews = [
    NewsItem(
      title: 'Phnom Penh named a top place to visit in 2026 by "BBC Travel"',
      description: 'The capital of Cambodia...',
      imagePath: 'assets/images/Phnom Penh.png',
      category: 'Home',
    ),
    NewsItem(
      title:
          'Elon Musk becomes first person worth \$700 billion following pay package ruling',
      description: 'Tesla CEO\'s wealth soars...',
      imagePath: 'assets/images/elon musk.png',
      category: 'Business',
    ),
    NewsItem(
      title: 'Elise Stefanik, loyal Trump ally, ends New York governor bid',
      description: 'The Congresswoman announces...',
      imagePath: "assets/images/Elise Stefanik's.png",
      category: 'Politics',
    ),
    NewsItem(
      title: 'McCullum wants to stay as England coach',
      description: 'Brendon McCullum expresses...',
      imagePath: 'assets/images/mccullum.png',
      category: 'Sports',
    ),
    NewsItem(
      title: 'Gold price climbs above \$4,400 to hit record high',
      description: 'Precious metal reaches...',
      imagePath: 'assets/images/gold .png',
      category: 'Business',
    ),
    NewsItem(
      title: "King's Foundation chair admits misleading electorate claim",
      description: 'A controversy arises...',
      imagePath: "assets/images/king's foundation.png",
      category: 'Politics',
    ),
    NewsItem(
      title: 'Man City to weigh players before Forest game',
      description: 'Pep Guardiola implements...',
      imagePath: 'assets/images/man city.png',
      category: 'Sports',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  Future<void> _loadBookmarks() async {
    final bookmarks = await AuthPrefs.getBookmarks();
    setState(() {
      bookmarkedTitles = bookmarks;
    });
  }

  @override
  Widget build(BuildContext context) {
    final favoriteNews = allNews
        .where((item) => bookmarkedTitles.contains(item.title))
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text("Bookmarks"), centerTitle: true),
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
                    ),
                  ),
                  title: Text(
                    item.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.newsDetails,
                      arguments: item,
                    ).then((_) => _loadBookmarks());
                  },
                );
              },
            ),
    );
  }
}
