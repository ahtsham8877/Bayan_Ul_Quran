// import 'package:flutter/material.dart';
// import 'package:bayanulquran/DatabaseHelper/DatabaseHelper.dart';
// import 'package:bayanulquran/Model/FolderModel.dart'; // Adjust the import path as per your project structure

// class FolderListScreen extends StatefulWidget {
//   @override
//   _FolderListScreenState createState() => _FolderListScreenState();
// }

// class _FolderListScreenState extends State<FolderListScreen> {
//   List<Folder> _folders = [];

//   @override
//   void initState() {
//     super.initState();
//     _loadFolders();
//   }

//   Future<void> _loadFolders() async {
//     List<Folder> folders = await DatabaseHelper().getFolders();
//     setState(() {
//       _folders = folders;
//     });
//   }

//   void _showAddFolderDialog(BuildContext context) {
//     TextEditingController folderNameController = TextEditingController();

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add Folder'),
//           content: TextField(
//             controller: folderNameController,
//             decoration: InputDecoration(hintText: 'Enter folder name'),
//           ),
//           actions: <Widget>[
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop(); // Close dialog
//               },
//               child: Text('Cancel'),
//             ),
//             TextButton(
//               onPressed: () async {
//                 String folderName = folderNameController.text.trim();
//                 if (folderName.isNotEmpty) {
//                   await DatabaseHelper().insertFolder(Folder(
//                     name: folderName,
//                     createdDate: DateTime.now(),
//                    // Assuming you handle ID generation in the database
//                   ));
//                   Navigator.of(context).pop();
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Folder added: $folderName')),
//                   );
//                   _loadFolders(); // Refresh the list of folders
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(content: Text('Please enter a folder name')),
//                   );
//                 }
//               },
//               child: Text('Save'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('List of Folders'),
//       ),
//       body: _folders.isEmpty
//           ? Center(child: Text('No folders found.'))
//           : ListView.builder(
//               itemCount: _folders.length,
//               itemBuilder: (context, index) {
//                 final folder = _folders[index];
//                 return ListTile(
//                   title: Text(folder.name),
//                   subtitle: Text('Created on: ${folder.createdDate}'),
//                 );
//               },
//             ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           _showAddFolderDialog(context); // Method to show add folder dialog
//         },
//         tooltip: 'Add Folder',
//         child: Icon(Icons.add),
//       ),
//     );
//   }
// }
