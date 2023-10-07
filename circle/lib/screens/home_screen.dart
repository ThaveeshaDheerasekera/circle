import 'package:circle/repositories/notes_repository.dart';
import 'package:circle/screens/manipulate_note_screen.dart';
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
    return Stack(
      children: [
        Consumer<NotesRepository>(builder: (context, ref, child) {
          return ref.getNotes.length != 0
              ? ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: ref.getNotes.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      margin: EdgeInsets.only(
                          top: 15,
                          // Checking for the last item of the list
                          // adding padding (15) only to the last item on the list
                          bottom: index != ref.getNotes.length - 1 ? 0 : 80),
                      child: NoteWidget(note: ref.getNotes[index]),
                    );
                  },
                )
              : Center(
                  child: Text('No Entries yet...'),
                );
        }),
        // Position the 'Add Entry' button
        // on the bottom of the page
        Positioned(
          right: 0,
          left: 0,
          bottom: 15,
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
              // Navigate to AddEntryScreen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ManipulateNoteScreen(),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
