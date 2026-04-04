import 'package:flutter/material.dart';
import '../model/news_item.dart';

class NewsDetailScreen extends StatefulWidget {
  final NewsItem newsItem;
  const NewsDetailScreen({super.key, required this.newsItem});

  @override
  State<NewsDetailScreen> createState() => _NewsDetailScreenState();
}

class _NewsDetailScreenState extends State<NewsDetailScreen> {
  bool _isBookmarked = false;

  void _toggleBookmark() {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'News Detail',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 20.0,
            vertical: 10.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      widget.newsItem.title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _toggleBookmark,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        _isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: _isBookmarked
                            ? Colors.yellow[700]
                            : Colors.grey[600],
                        size: 24,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'KHMER TIME | 2025-12-21 | ${widget.newsItem.category}',
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  widget.newsItem.imagePath,
                  width: double.infinity,
                  height: 220,
                  fit: BoxFit.cover,
                  errorBuilder: (context, _, __) => Container(
                    height: 220,
                    color: Colors.grey[200],
                    child: const Icon(Icons.image_not_supported),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.newsItem.description + '\n\n' +
                'Phnom Penh has been recognised by \'BBC Travel\' as one of the world\'s 20 must-visit destinations for 2026, marking an exciting milestone for Cambodia\'s capital.\n\n'
                'The prestigious list celebrates places that champion sustainable and meaningful travel, spotlighting destinations that offer rich cultural experiences while supporting local communities and protecting the environment.\n\n'
                'According to \'BBC Travel\', Phnom Penh is entering \'a new era\', with creative and sustainable developments reshaping the city.\n\n'
                'Long overshadowed by Siem Reap, the capital is now stepping confidently into the global spotlight.\n\n'
                'A key highlight, \'BBC Travel\' emphasises, is the launch of Techo International Airport, Cambodia\'s largest-ever infrastructure project, which is set to significantly improve international access with new routes from the UAE, Turkey, China and Japan.',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.6,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
