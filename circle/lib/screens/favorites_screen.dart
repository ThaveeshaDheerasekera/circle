import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:circle/models/entries_model.dart';
import 'package:circle/widget/home_screen_widgets/entry_widget.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EntriesModel>(builder: (context, entry, child) {
      return entry.getFavoriteEntriesList().length != 0
          ? ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: entry.getFavoriteEntriesList().length,
              physics: const BouncingScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  margin: EdgeInsets.only(
                      top: 15,
                      // Checking for the last item of the list
                      // adding padding (15) only to the last item on the list
                      bottom: index != entry.getFavoriteEntriesList().length - 1
                          ? 0
                          : 15),
                  child: EntryWidget(
                    index: index,
                    title: entry.getFavoriteEntriesList()[index].title,
                    content: entry
                        .getFavoriteEntriesList()[index]
                        .content, // Pass the content from the Entry object
                    image: entry
                        .getFavoriteEntriesList()[index]
                        .image, // Pass the image URL from the Entry object
                    created_at: entry
                        .getFavoriteEntriesList()[index]
                        .created_at, // Pass the created date and time from the Entry object
                    isFav: true,
                  ),
                );
              },
            )
          : Center(
              child: Text('No Favorite Entries...'),
            );
    });
  }
}
