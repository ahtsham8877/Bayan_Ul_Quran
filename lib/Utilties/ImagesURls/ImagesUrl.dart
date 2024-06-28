String baseURl = "assets/images/";

final List<String> addfolderNames = [];




  // void _showSelectFolderDialog(BuildContext context) {
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Select Folder'),
  //         content: folderNames.isEmpty
  //             ? Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: [
  //                   const Text('No folders available'),
  //                   const SizedBox(height: 20),
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       Navigator.of(context).pop();
  //                       _showNewFolderDialog(context);
  //                     },
  //                     child: const Text('Create New Folder'),
  //                   ),
  //                 ],
  //               )
  //             : Column(
  //                 mainAxisSize: MainAxisSize.min,
  //                 children: folderNames.map((folderName) {
  //                   int folderIndex = folderNames.indexOf(folderName);
  //                   return ListTile(
  //                     title: Text(folderName),
  //                     onTap: () {
  //                       Navigator.of(context).pop();
  //                       _showNewItemDialog(context, folderIndex);
  //                     },
  //                   );
  //                 }).toList(),
  //               ),
  //         actions: [
  //           if (folderNames.isNotEmpty)
  //             TextButton(
  //               onPressed: () {
  //                 Navigator.of(context).pop();
  //                 _showNewFolderDialog(context);
  //               },
  //               child: const Text('Create New Folder'),
  //             ),
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

  // void _showNewItemDialog(BuildContext context, int folderIndex) {
  //   final TextEditingController itemNameController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: const Text('Add New Item'),
  //         content: TextField(
  //           controller: itemNameController,
  //           decoration: const InputDecoration(hintText: "Item Name"),
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () {
  //               setState(() {
  //                 String itemName = itemNameController.text;
  //                 if (itemName.isNotEmpty) {
  //                   Bookmark newBookmark = Bookmark(
  //                     id: 0,
  //                     title: itemName,
  //                     content: "Sample Content",
  //                     timestamp: DateTime.now(),
  //                   );
  //                   _folderItems[folderIndex].add(newBookmark);
  //                   _databaseHelper.insertBookmark(newBookmark);
  //                 }
  //               });
  //               Navigator.of(context).pop();
  //             },
  //             child: const Text('Add Item'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
