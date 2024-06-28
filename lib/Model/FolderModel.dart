class Folder {
  int? id;
  String name;
  DateTime createdDate;

  Folder({
    this.id,
    required this.name,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'created_date': createdDate.toIso8601String(),
    };
  }

  factory Folder.fromMap(Map<String, dynamic> map) {
    return Folder(
      id: map['id'],
      name: map['name'],
      createdDate: DateTime.parse(map['created_date']),
    );
  }
}
