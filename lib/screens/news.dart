import 'package:flutter/material.dart';
import '../domain/entities/news_item.dart';
import '../data/repositories/news_repository_impl.dart';
import '../data/datasources/database_helper.dart';
import '../navigation/app_routes.dart';
import '../utiles/shared_pref.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<String> categories = ['Home', 'Business', 'Politics', 'Sports'];
  String selectedCategory = 'Home';
  final NewsRepositoryImpl repository = NewsRepositoryImpl(DatabaseHelper.instance);
  List<String> bookmarkedIds = [];

  final List<NewsItem> allNews = [
    NewsItem(
      id: '1',
      title: 'Phnom Penh named a top place to visit in 2026 by "BBC Travel"',
      description: 'The capital of Cambodia...',
      imagePath: 'assets/images/Phnom Penh.png',
      category: 'Home',
    ),
    NewsItem(
      id: '2',
      title: 'Elon Musk becomes first person worth \$700 billion following pay package ruling',
      description: 'Tesla CEO\'s wealth soars...',
      imagePath: 'assets/images/elon musk.png',
      category: 'Business',
    ),
    NewsItem(
      id: '3',
      title: 'Elise Stefanik, loyal Trump ally, ends New York governor bid',
      description: 'The Congresswoman announces...',
      imagePath: "assets/images/Elise Stefanik's.png",
      category: 'Politics',
    ),
    NewsItem(
      id: '4',
      title: 'McCullum wants to stay as England coach',
      description: 'Brendon McCullum expresses...',
      imagePath: 'assets/images/mccullum.png',
      category: 'Sports',
    ),
    NewsItem(
      id: '5',
      title: 'Gold price climbs above \$4,400 to hit record high',
      description: 'Precious metal reaches...',
      imagePath: 'assets/images/gold .png',
      category: 'Business',
    ),
    NewsItem(
      id: '6',
      title: "King's Foundation chair admits misleading electorate claim",
      description: 'A controversy arises...',
      imagePath: "assets/images/king's foundation.png",
      category: 'Politics',
    ),
    NewsItem(
      id: '7',
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
    final favorites = await repository.getFavorites();
    setState(() {
      bookmarkedIds = favorites.map((e) => e.id).toList();
    });
  }

  Future<void> _toggleBookmark(NewsItem item) async {
    await repository.toggleFavorite(item);
    await _loadBookmarks();
  }

  Future<void> _logout() async {
    await AuthPrefs.logout();
    if (mounted) {
      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.login, (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<NewsItem> filteredNews = selectedCategory == 'Home'
        ? allNews
        : allNews.where((item) => item.category == selectedCategory).toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.logout, color: Colors.red),
          onPressed: _logout,
        ),
        title: const Text(
          'The News Post',
          style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite, color: Colors.red),
            onPressed: () {
              Navigator.pushNamed(context, AppRoutes.favorite).then((_) => _loadBookmarks());
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                children: categories.map((cat) {
                  final bool isSelected = selectedCategory == cat;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (bool selected) {
                        if (selected) {
                          setState(() {
                            selectedCategory = cat;
                          });
                        }
                      },
                      selectedColor: Colors.red,
                      labelStyle: TextStyle(
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                      showCheckmark: false,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(16.0),
              itemCount: filteredNews.length,
              separatorBuilder: (_, _) => const SizedBox(height: 20),
              itemBuilder: (context, index) {
                final item = filteredNews[index];
                final isBookmarked = bookmarkedIds.contains(item.id);

                return GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      AppRoutes.newsDetails,
                      arguments: item,
                    ).then((_) => _loadBookmarks());
                  },
                  child: index == 0 && selectedCategory == 'Home'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.asset(
                                    item.imagePath,
                                    height: 200,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, _, _) => Container(
                                      height: 200,
                                      color: Colors.grey[200],
                                      child: const Icon(Icons.image_not_supported),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: 10,
                                  right: 10,
                                  child: IconButton(
                                    icon: Icon(
                                      isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                      color: isBookmarked ? Colors.yellow[700] : Colors.white,
                                    ),
                                    onPressed: () => _toggleBookmark(item),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                item.imagePath,
                                height: 85,
                                width: 85,
                                fit: BoxFit.cover,
                                errorBuilder: (context, _, _) => Container(
                                  height: 85,
                                  width: 85,
                                  color: Colors.grey[200],
                                  child: const Icon(Icons.image_not_supported),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.title,
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 3,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            IconButton(
                              icon: Icon(
                                isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                                color: isBookmarked ? Colors.yellow[700] : Colors.grey,
                              ),
                              onPressed: () => _toggleBookmark(item),
                            ),
                          ],
                        ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
