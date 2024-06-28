class Bookmark {
  int? id;
  int surahID;
  String title;
  String content;
  String mainContent;
  DateTime timestamp;
  int folderId;

  Bookmark({
    this.id,
    required this.surahID,
    required this.title,
    required this.content,
    required this.mainContent,
    required this.timestamp,
    required this.folderId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'surahID': surahID,
      'title': title,
      'content': content,
      'mainContent': mainContent,
      'timestamp': timestamp.toIso8601String(),
      'folder_id': folderId,
    };
  }

  factory Bookmark.fromMap(Map<String, dynamic> map) {
    return Bookmark(
      id: map['id'],
      surahID: map['surahID'],
      title: map['title'],
      content: map['content'],
      mainContent: map['mainContent'],
      timestamp: DateTime.parse(map['timestamp']),
      folderId: map['folder_id'],
    );
  }
}
