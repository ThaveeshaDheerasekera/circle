import 'dart:io';
import 'package:circle/screens/manipulate_entry_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:circle/widget/global_widgets/elevated_button_widget.dart';
import 'package:circle/models/entries_model.dart';

class EntryWidget extends StatefulWidget {
  const EntryWidget({
    Key? key,
    required this.index,
    required this.title,
    required this.content,
    required this.image,
    required this.created_at,
    this.isFav = false,
  }) : super(key: key);

  final int index;
  final String title;
  final String content;
  final File? image;
  final DateTime created_at;
  final bool? isFav;

  @override
  State<EntryWidget> createState() => _EntryWidgetState();
}

class _EntryWidgetState extends State<EntryWidget> {
  @override
  Widget build(BuildContext context) {
    final entriesModel = Provider.of<EntriesModel>(context, listen: false);
    final entry = entriesModel.getEntriesList()[widget.index];

    // List item - main container
    return Container(
      width: double.infinity,
      // Padding of the main container
      // No top padding
      padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(width: 1, color: Colors.grey),
        borderRadius: BorderRadius.circular(2),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // This is the header bar
          // grey color with 0.5 opacity
          Container(
            height: 50,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.5),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(2),
                bottomRight: Radius.circular(2),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // 'created_at' attribute of the Entry
                Expanded(
                  child: Container(
                    child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      child: Text(DateFormat('dd-MMM-yyyy | HH:mm:ss')
                          .format(widget.created_at)),
                    ),
                  ),
                ),
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: widget.isFav == false
                      ? () {
                          if (!entriesModel.isEntryInFavorites(entry)) {
                            entriesModel.addToFavorites(entry);
                            print(entriesModel.getFavoriteEntriesList());
                            _showSnackBar(context,
                                '[ Entry ID: ${entry.entry_id} ]    Added to favorites');
                          } else {
                            entriesModel.removeFromFavorites(entry);
                            print(entriesModel.getFavoriteEntriesList());
                            _showSnackBar(context,
                                '[ Entry ID: ${entry.entry_id} ]    Removed from favorites');
                          }
                        }
                      : null,
                  icon: widget.isFav == false
                      ? Icon(
                          entriesModel.isEntryInFavorites(entry)
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 20,
                        )
                      : Icon(Icons.favorite, size: 20),
                ),
                // Edit button
                ElevatedButtonWidget(
                  child: Text('Edit'),
                  width: 50,
                  height: 30,
                  borderRadius: 2,
                  onPressed: widget.isFav == false
                      ? () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ManipulateEntryScreen(
                                entry: entry,
                              ),
                            ),
                          );
                        }
                      : null,
                ),
              ],
            ),
          ),
          const SizedBox(height: 15),
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
                      widget.title,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
                // Button to collapse,
                // Content and images of the entry
                IconButton(
                  visualDensity: VisualDensity.compact,
                  onPressed: () {
                    entriesModel.toggleCollapseState(widget.index);
                  },
                  icon: Icon(
                    !entry.isCollapsed
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
          Visibility(
            visible: !entry.isCollapsed,
            child: Column(
              children: [
                const SizedBox(height: 15),
                // 'content' attribute of the Entry
                Container(
                  width: double.infinity,
                  child: Text(widget.content),
                ),
                widget.image != null
                    ? Column(
                        children: [
                          const SizedBox(height: 15),
                          // 'image' attribute of the Entry
                          // Show empty SizedBox() widget if,
                          // no image is there
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(1),
                            decoration: BoxDecoration(
                              border: Border.all(width: 1, color: Colors.grey),
                              borderRadius: BorderRadius.circular(2),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2),
                              child: widget.image is File
                                  ? Image.file(widget.image!,
                                      fit: BoxFit.fitWidth)
                                  : Image.asset(widget.image!.path,
                                      fit: BoxFit.fitWidth),
                            ),
                          ),
                        ],
                      )
                    : SizedBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
