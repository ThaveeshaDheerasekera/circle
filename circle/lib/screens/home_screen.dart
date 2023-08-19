import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:circle/models/entries_model.dart';
import 'package:circle/widget/home_screen_widgets/entry_widget.dart';
import 'package:circle/widget/global_widgets/elevated_button_widget.dart';
import 'package:circle/screens/manipulate_entry_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<EntriesModel>(context, listen: false).fetchEntryList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        children: [
          Consumer<EntriesModel>(builder: (context, ref, child) {
            return RefreshIndicator(
              onRefresh: () => ref.fetchEntryList(),
              child: Padding(
                // Adding a bottom padding to
                // get the list items above the button
                padding: const EdgeInsets.only(bottom: 50),
                child: ref.entryList.length != 0
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: ref.entryList.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                                top: 15,
                                // Checking for the last item of the list
                                // adding padding (15) only to the last item on the list
                                bottom:
                                    index != ref.entryList.length - 1 ? 0 : 15),
                            child: EntryWidget(
                              index: index,
                              title: ref.entryList[index].title,
                              content: ref.entryList[index]
                                  .content, // Pass the content from the Entry object
                              image: ref.entryList[index].image != null
                                  ? ref.entryList[index].image!
                                  : null, // Pass the image URL from the Entry object
                              created_at: ref.entryList[index]
                                  .created_at!, // Pass the created date and time from the Entry object
                            ),
                          );
                        },
                      )
                    : Center(
                        child: Text('No Entries yet...'),
                      ),
              ),
            );
          }),
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
  }
}
