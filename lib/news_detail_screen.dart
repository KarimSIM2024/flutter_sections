import 'package:flutter/material.dart';

class NewsDetailScreen extends StatefulWidget {
  const NewsDetailScreen({super.key});

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
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Container(
            width: MediaQuery.of(context).size.width * 1.5, // to allow horizontal scrolling
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        'Phnom Penh named a top place to visit in 2026 by \'BBC Travel\'',
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
                          _isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                          color: _isBookmarked ? Colors.yellow[700] : Colors.grey[600],
                          size: 24,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                const Text(
                  'KHMER TIME | 2025-12-21',
                  style: TextStyle(color: Colors.grey, fontSize: 12, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 20),
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    'assets/images/img.png',
                    width: double.infinity,
                    height: 220,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => Container(
                      height: 220,
                      width: double.infinity,
                      color: Colors.grey[300],
                      child: const Icon(Icons.image, size: 50, color: Colors.grey),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Synopsis: Phnom Penh is entering \'a new era\', with creative and sustainable developments reshaping the city. Long overshadowed by Siem Reap, the capital is now stepping confidently into the \'global spotlight\'.\n\n'
                  'Phnom Penh has been recognised by \'BBC Travel\' as one of the world\'s 20 must-visit destinations for 2026, marking an exciting milestone for Cambodia\'s capital.\n\n'
                  'The prestigious list celebrates places that champion sustainable and meaningful travel, spotlighting destinations that offer rich cultural experiences while supporting local communities and protecting the environment.\n\n'
                  'According to \'BBC Travel\', Phnom Penh is entering \'a new era\', with creative and sustainable developments reshaping the city.\n\n'
                  'Long overshadowed by Siem Reap, the capital is now stepping confidently into the global spotlight.\n\n'
                  'A key highlight, \'BBC Travel\' emphasises, is the launch of Techo International Airport, Cambodia\'s largest-ever infrastructure project, which is set to significantly improve international access with new routes from the UAE, Turkey, China and Japan.\n\n'
                  '\"On the ground, the city\'s transformation is equally striking. Once home to just a single traffic light, Phnom Penh is now emerging as a model for sustainable urban tourism.\"\n\n'
                  '\"New attractions include the Chaktomuk Walk Street, a lively pedestrian riverfront that comes alive on weekends with Khmer street food, local crafts and live music.\"\n\n'
                  '\"Eco-friendly initiatives, such as electric tuk-tuks introduced by local hotels, further reflect the city\'s forward-looking vision.\"\n\n'
                  'Other places in the list are Abu Dhabi (UAE), Algeria, Colchagua Valley (Chile), Cook Islands, Costa Rica, Hebrides (Scotland), Ishikawa (Japan), Komodo Islands (Indonesia), Loreto, Baja California Sur (Mexico), Montenegro, Oregon Coast (US), Oulu (Finland), Philadelphia (US), Guimarães (Portugal) and Samburu (Kenya).',
                  style: TextStyle(
                    fontSize: 15,
                    height: 1.6,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
