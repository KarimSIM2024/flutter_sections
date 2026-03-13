import 'package:flutter/material.dart';

class NewsItem {
  final String title;
  final String description;
  final String imageUrl;
  final String category;

  NewsItem({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.category,
  });
}

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  final List<String> categories = ['Home', 'Business', 'Politics', 'Sports'];
  String selectedCategory = 'Home';

  final List<NewsItem> allNews = [
    NewsItem(
      title: 'Phnom Penh named a top place to visit in 2026 by "BBC Travel"',
      description: 'The capital of Cambodia has been recognized for its vibrant culture and history.',
      imageUrl: 'https://picsum.photos/id/10/400/200',
      category: 'Home',
    ),
    NewsItem(
      title: 'Elon Musk becomes first person worth \$700 billion following pay package ruling',
      description: 'Tesla CEO\'s wealth soars after a favorable court decision regarding his compensation.',
      imageUrl: 'https://picsum.photos/id/20/400/200',
      category: 'Business',
    ),
    NewsItem(
      title: 'Elise Stefanik, loyal Trump ally, ends New York governor bid and will leave politics',
      description: 'The Congresswoman announces a major shift in her political career.',
      imageUrl: 'https://picsum.photos/id/30/400/200',
      category: 'Politics',
    ),
    NewsItem(
      title: 'McCullum wants to stay as England coach',
      description: 'Brendon McCullum expresses his desire to continue leading the England cricket team.',
      imageUrl: 'https://picsum.photos/id/40/400/200',
      category: 'Sports',
    ),
    NewsItem(
      title: 'Gold price climbs above \$4,400 to hit record high',
      description: 'Precious metal reaches new heights amid global economic uncertainty.',
      imageUrl: 'https://picsum.photos/id/50/200/200',
      category: 'Business',
    ),
    NewsItem(
      title: 'King\'s Foundation chair and nominee peer admits misleading electorate claim',
      description: 'A controversy arises over statements made during a campaign.',
      imageUrl: 'https://picsum.photos/id/60/200/200',
      category: 'Politics',
    ),
    NewsItem(
      title: 'Man City to weigh players before Forest game',
      description: 'Pep Guardiola implements strict fitness monitoring for his squad.',
      imageUrl: 'https://picsum.photos/id/70/200/200',
      category: 'Sports',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    List<NewsItem> filteredNews = selectedCategory == 'Home'
        ? allNews
        : allNews.where((item) => item.category == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.menu, color: Colors.red),
        title: const Text(
          'The News Post',
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontFamily: 'Serif',
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: categories.map((category) {
                  bool isSelected = selectedCategory == category;
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: ChoiceChip(
                      label: Text(
                        category,
                        style: TextStyle(
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                      ),
                      selected: isSelected,
                      selectedColor: Colors.red,
                      backgroundColor: Colors.grey[200],
                      onSelected: (selected) {
                        setState(() {
                          selectedCategory = category;
                        });
                      },
                      showCheckmark: isSelected && category != 'Home',
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
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final news = filteredNews[index];
                if (index == 0 && selectedCategory == 'Home') {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          news.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        news.title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  );
                } else {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          news.imageUrl,
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          news.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
