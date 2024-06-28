import 'package:flutter/material.dart';
import 'package:bayanulquran/DatabaseHelper/DatabaseHelper.dart';
import 'package:bayanulquran/Model/BookMarksModel.dart';

class BookmarkListWidget extends StatefulWidget {
  const BookmarkListWidget({Key? key});

  @override
  _BookmarkListWidgetState createState() => _BookmarkListWidgetState();
}

class _BookmarkListWidgetState extends State<BookmarkListWidget> {
  late Future<List<Bookmark>> _bookmarksFuture;

  @override
  void initState() {
    super.initState();
    _loadBookmarks();
  }

  void _loadBookmarks() {
    setState(() {
      _bookmarksFuture = DatabaseHelper().getBookmarks();
    });
  }

  Future<void> _deleteBookmark(int id) async {
    await DatabaseHelper().deleteBookmark(id);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Bookmark deleted')),
    );
    _loadBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Bookmark>>(
      future: _bookmarksFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          List<Bookmark>? bookmarks = snapshot.data;
          if (bookmarks != null && bookmarks.isNotEmpty) {
            return ListView.builder(
              itemCount: bookmarks.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(bookmarks[index].title),
                  subtitle: Text(bookmarks[index].content),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () => _deleteBookmark(bookmarks[index].id!),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text('No bookmarks found'));
          }
        }
      },
    );
  }
}

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarks'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(8.0),
        child: BookmarkListWidget(),
      ),
    );
  }
}
