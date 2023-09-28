import 'package:circle/repositories/notes_repository.dart';
import 'package:circle/screens/manipulate_entry_screen.dart';
import 'package:circle/widget/global_widgets/elevated_button_widget.dart';
import 'package:circle/widget/home_screen_widgets/note_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<NotesRepository>(context, listen: false).fetchNoteList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Consumer<NotesRepository>(builder: (context, ref, child) {
            return RefreshIndicator(
              onRefresh: () async {
                await ref.fetchNoteList();
              },
              child: Padding(
                // Adding a bottom padding to
                // get the list items above the button
                padding: const EdgeInsets.only(bottom: 50),
                child: ref.getNotes.length != 0
                    ? ListView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: ref.getNotes.length,
                        physics: AlwaysScrollableScrollPhysics(),
                        itemBuilder: (BuildContext context, int index) {
                          return Container(
                            margin: EdgeInsets.only(
                                top: 15,
                                // Checking for the last item of the list
                                // adding padding (15) only to the last item on the list
                                bottom:
                                    index != ref.getNotes.length - 1 ? 0 : 15),
                            child: NoteWidget(note: ref.getNotes[index]),
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
            child: ElevatedButtonWidget(
              child: Text(
                'Add Note',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              width: double.infinity,
              height: 50,
              borderRadius: 2,
              onPressed: () {
                // Provider.of<NotesRepository>(context, listen: false)
                //     .createNote();
                // print('----- Add Note Executed ----');
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
