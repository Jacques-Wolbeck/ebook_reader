class BookModel {
  final int id;
  final String title;
  final String author;
  final String coverUrl;
  final String downloadUrl;
  bool isFavorite;

  BookModel(
      {required this.id,
      required this.title,
      required this.author,
      required this.coverUrl,
      required this.downloadUrl,
      this.isFavorite = false});

  factory BookModel.fromJson(Map<String, dynamic> json) {
    if (json['is_favorite'] == null) {
      json['is_favorite'] = 0;
    }
    return BookModel(
      id: json['id'],
      title: json['title'],
      author: json['author'],
      coverUrl: json['cover_url'],
      downloadUrl: json['download_url'],
      isFavorite: json['is_favorite'] == 0 ? false : true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'cover_url': coverUrl,
      'download_url': downloadUrl,
      'is_favorite': isFavorite ? 1 : 0,
    };
  }
}
