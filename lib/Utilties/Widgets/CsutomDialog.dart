import 'package:bayanulquran/Utilties/Colors/Colors.dart';
import 'package:flutter/material.dart';

class CustomFolderDialog extends StatelessWidget {
  final List<String> folderNames;
  final Function(int)? onFolderSelected;
  final VoidCallback? onCreateNewFolder;

  const CustomFolderDialog({
    super.key,
    required this.folderNames,
    this.onFolderSelected,
    this.onCreateNewFolder,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Center(child: Text('فولڈر منتخب کریں۔')),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (folderNames.isNotEmpty)
              Center(
                child: DropdownButton<String>(
                  dropdownColor: bgColor,
                  value: folderNames.isNotEmpty ? folderNames.first : null,
                  items: folderNames.toSet().toList().map((folder) {
                    return DropdownMenuItem<String>(
                      value: folder,
                      child: Container(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text(folder),
                          )),
                    );
                  }).toList(),
                  onChanged: (String? selectedFolder) {
                    int index = folderNames.indexOf(selectedFolder!);
                    if (onFolderSelected != null) {
                      onFolderSelected!(index);
                    }
                    Navigator.pop(context);
                  },
                ),
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
