import 'package:circle/screens/manipulate_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:circle/models/entries_model.dart';
import 'package:circle/widget/home_screen_widgets/entry_widget.dart';
import 'package:circle/widget/global_widgets/elevated_button_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<EntriesModel>(builder: (context, entry, child) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15),
        child: Stack(
          children: [
            Padding(
              // Adding a bottom padding to
              // get the list items above the button
              padding: const EdgeInsets.only(bottom: 50),
              child: entry.getEntriesList().length != 0
                  ? ListView.builder(
                      padding: EdgeInsets.zero,
                      itemCount: entry.getEntriesList().length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        return Container(
                          margin: EdgeInsets.only(
                              top: 15,
                              // Checking for the last item of the list
                              // adding padding (15) only to the last item on the list
                              bottom: index != entry.getEntriesList().length - 1
                                  ? 0
                                  : 15),
                          child: EntryWidget(
                            index: index,
                            title: entry.getEntriesList()[index].title,
                            content: entry
                                .getEntriesList()[index]
                                .content, // Pass the content from the Entry object
                            image: entry
                                .getEntriesList()[index]
                                .image, // Pass the image URL from the Entry object
                            created_at: entry
                                .getEntriesList()[index]
                                .created_at, // Pass the created date and time from the Entry object
                          ),
                        );
                      },
                    )
                  : Center(
                      child: Text('No Entries yet...'),
                    ),
            ),
            // Position the 'Add Entry' button
            // on the bottom of the page
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ElevatedButtonWidget(
                child: Text(
                  'Add Entry',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                width: double.infinity,
                height: 50,
                borderRadius: 2,
                onPressed: () {
                  // Navigate to AddEntryScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManipulateEntryScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      );
    });
  }
}
