import 'package:circle/entities/note.dart';
import 'package:circle/repositories/notes_repository.dart';
import 'package:circle/screens/manipulate_note_screen.dart';
import 'package:circle/widget/global_widgets/elevated_button_widget.dart';
import 'package:circle/widget/global_widgets/title_widget.dart';
import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoteWidget extends StatefulWidget {
  const NoteWidget({
    Key? key,
    required this.note,
  }) : super(key: key);

  final Note note;

  @override
  State<NoteWidget> createState() => _NoteWidgetState();
}

class _NoteWidgetState extends State<NoteWidget> {
  @override
  Widget build(BuildContext context) {
    bool _isFav = false;
    final model = Provider.of<NotesRepository>(context, listen: false);
    // final note = model.getNotes[widget.index];

    return TitleWidget(
      title:
          DateFormat('dd-MMM-yyyy | HH:mm:ss').format(widget.note.created_at),
      actions: [
        // Edit button
        ElevatedButtonWidget(
          child: Text('Open'),
          width: 50,
          height: 30,
          borderRadius: 2,
          onPressed: () {
            print(widget.note.note_id);
            print(widget.note.title);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ManipulateNoteScreen(
                  note: widget.note,
                ),
              ),
            );
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: Colors.grey),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 'title' attribute of the Entry
                Expanded(
                  child: Container(
                    child: Text(
                      widget.note.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                // Button to collapse the content
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    model.toggleCollapse(
                        noteId: widget.note.note_id,
                        isCollapsed: !widget.note.isCollapsed);
                  },
                  icon: Icon(
                    !widget.note.isCollapsed
                        ? Icons.keyboard_arrow_down
                        : Icons.keyboard_arrow_right,
                    size: 20,
                  ),
                ),
              ],
            ),
          ),
          // If collapse button is toggled,
          // this column will not be visible
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Visibility(
              visible: !widget.note.isCollapsed,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 15),
                  // 'content' attribute of the Entry
                  Text(
                    widget.note.content,
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    left: BorderSide(width: 1, color: Colors.grey),
                    top: BorderSide(width: 1, color: Colors.grey),
                    bottom: BorderSide(width: 1, color: Colors.grey),
                  ),
                ),
                child: IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    model.updateIsFav(
                        noteId: widget.note.note_id, isFav: !widget.note.isFav);
                  },
                  icon: Icon(
                    !widget.note.isFav
                        ? FluentIcons.heart_20_regular
                        : FluentIcons.heart_20_filled,
                    size: 20,
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey),
                ),
                child: IconButton(
                  onPressed: () => _showModalBottomSheet(
                    context,
                    onPressed: () {
                      model.deleteNote(widget.note.note_id);
                      Navigator.pop(context);
                    },
                  ),
                  visualDensity: VisualDensity.compact,

                  icon: Icon(FluentIcons.delete_20_filled, size: 20),
                  // Icon(FluentIcons.delete_20_filled, size: 20),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  void _showModalBottomSheet(BuildContext context,
      {required VoidCallback onPressed}) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2)),
      builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Are you sure?'),
              Row(
                children: [
                  TextButton(
                    onPressed: onPressed,
                    child: Text('Yes'),
                  ),
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text('No'),
                    autofocus: true,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

// ---------------------------
// ------- image display -----
// widget.image != null
// ? Column(
// children: [
// const SizedBox(height: 15),
// // 'image' attribute of the Entry
// // Show empty SizedBox() widget if,
// // no image is there
// Container(
// height: 200,
// padding: EdgeInsets.all(1),
// decoration: BoxDecoration(
// border: Border.all(width: 1, color: Colors.grey),
// borderRadius: BorderRadius.circular(2),
// ),
// child: GestureDetector(
// onTap: () => Navigator.push(
// context,
// MaterialPageRoute(
// builder: (context) => ImageViewScreen(
// image: UrlLocation.baseUrl +
// widget.image!))),
// child: ClipRRect(
// borderRadius: BorderRadius.circular(2),
// child: Image.network(
// UrlLocation.baseUrl + widget.image!,
// fit: BoxFit.scaleDown),
// ),
// ),
// ),
// ],
// )
// : SizedBox(),
// ------------------------
