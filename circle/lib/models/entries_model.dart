import 'dart:io';
import 'package:flutter/material.dart';

import 'package:circle/entities/entry.dart';

class EntriesModel extends ChangeNotifier {
  List<Entry> _entries = [
    Entry(
      entry_id: 1,
      title: 'Test Title 1',
      content:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
      created_at: DateTime.now(),
    ),
    Entry(
      entry_id: 2,
      title: 'Test Title 2',
      content:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
      created_at: DateTime.now(),
    ),
    Entry(
      entry_id: 3,
      title: 'Test Title 3',
      content:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
      created_at: DateTime.now(),
    ),
    Entry(
      entry_id: 4,
      title: 'Test Title 4',
      content:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
      created_at: DateTime.now(),
    ),
    Entry(
      entry_id: 5,
      title: 'Test Title 5',
      content:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
      created_at: DateTime.now(),
    ),
  ];

  List<Entry> _favoriteEntries = [];
  bool isCollapsed = false;

  void addEntry(String title, String content, File? image) {
    final newEntry = Entry(
      entry_id: _entries.length + 1, // Calculate a new entry_id
      title: title,
      content: content,
      image: image,
      created_at: DateTime.now(),
    );
    _entries.add(newEntry);
    notifyListeners();
  }

  void editEntry(int index, String title, String content, File? image) {
    final entry = _entries[index];
    entry.title = title;
    entry.content = content;
    entry.image = image;
    notifyListeners();
  }

  // Check if an entry is in favorites
  bool isEntryInFavorites(Entry entry) {
    return _favoriteEntries.contains(entry);
  }

  // Add an entry to favorites
  void addToFavorites(Entry entry) {
    _favoriteEntries.add(entry);
    notifyListeners();
  }

  // Remove an entry from favorites
  void removeFromFavorites(Entry entry) {
    _favoriteEntries.remove(entry);
    notifyListeners();
  }

  void toggleCollapseState(int index) {
    final entry = _entries[index];
    entry.isCollapsed = !entry.isCollapsed;
    notifyListeners();
  }

  List<Entry> getFavoriteEntriesList() {
    return _favoriteEntries;
  }

  List<Entry> getEntriesList() {
    return _entries;
  }
}
