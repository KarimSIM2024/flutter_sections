class NewsItem {
  final String id;
  final String title;
  final String description;
  final String imagePath;
  final String category;

  NewsItem({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'imagePath': imagePath,
      'category': category,
    };
  }

  factory NewsItem.fromMap(Map<String, dynamic> map) {
    return NewsItem(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      imagePath: map['imagePath'],
      category: map['category'],
    );
  }
}
