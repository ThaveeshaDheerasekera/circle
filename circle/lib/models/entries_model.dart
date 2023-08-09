import 'package:flutter/material.dart';

import 'package:circle/entities/entry.dart';

// final entriesModelProvider = Provider((ref) => EntriesModel());

class EntriesModel extends ChangeNotifier {
  final List<Entry> _entries = [
    Entry(
      entry_id: 1,
      title: 'Test Title 1',
      content:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
      image:
          'https://media.macphun.com/img/uploads/customer/how-to/579/15531840725c93b5489d84e9.43781620.jpg?q=85&w=1340',
      created_at: DateTime.now(),
    ),
    Entry(
      entry_id: 2,
      title: 'Test Title 2',
      content:
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered alteration in some form, by injected humour, or randomised words which don\'t look even slightly believable. If you are going to use a passage of Lorem Ipsum, you need to be sure there isn\'t anything embarrassing hidden in the middle of text. All the Lorem Ipsum generators on the Internet tend to repeat predefined chunks as necessary, making this the first true generator on the Internet. It uses a dictionary of over 200 Latin words, combined with a handful of model sentence structures, to generate Lorem Ipsum which looks reasonable. The generated Lorem Ipsum is therefore always free from repetition, injected humour, or non-characteristic words etc.',
      image:
          'https://a.travel-assets.com/findyours-php/viewfinder/images/res70/471000/471485-Kandy-Sri-Lanka.jpg',
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
      image:
          'https://www.travelandleisure.com/thmb/3PWDknqhSJFKHZkxNixokVoE33s=/750x0/filters:no_upscale():max_bytes(150000):strip_icc()/taj-mahal-agra-india-TAJ0217-9eab8f20d11d4391901867ed1ce222b8.jpg',
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

  final List<Entry> _favoriteEntries = [];
  bool isCollapsed = false;

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
