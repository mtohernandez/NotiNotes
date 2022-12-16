class Note {
  final String id;
  final String title;
  final String content;
  final List<String> tags;
  final DateTime dateCreated;
  final String imageUrl;

  Note(
    this.tags,
    this.imageUrl, {
    required this.id,
    required this.title,
    required this.content,
    required this.dateCreated,
  });
}
