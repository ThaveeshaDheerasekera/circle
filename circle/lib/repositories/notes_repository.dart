import 'package:circle/entities/note.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NotesRepository extends ChangeNotifier {
  // Firebase Authentication
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  // Firebase Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? get currentUserId => _firebaseAuth.currentUser?.uid;

  List<Note> notes = [];

  List<Note> get getNotes {
    return notes;
  }

  List<Note> get getFavoriteNotes {
    return notes.where((note) => note.isFav).toList();
  }

  Future<List<Note>> fetchNoteList() async {
    await _firestore
        .collection('users')
        .doc(currentUserId!)
        .collection('notes')
        .orderBy('created_at', descending: true)
        .snapshots(includeMetadataChanges: true)
        .listen((notes) {
      this.notes =
          notes.docs.map((doc) => Note.fromJson(doc.data(), doc.id)).toList();
      notifyListeners();
    });
    return notes;
  }

  // Function to create a new note
  Future<void> createNote(String title, String content) async {
    try {
      await _firestore.collection('users/${currentUserId!}/notes').add({
        'title': title,
        'content': content,
        'created_at': DateTime.now(),
        'isCollapsed': false,
        'isFav': false,
      });
    } catch (e) {
      // Handle errors
      print('Error creating note: $e');
    }
  }

  // Function to update a note
  Future<void> updateNote({
    required String noteId,
    required String title,
    required String content,
  }) async {
    try {
      if (noteId.isNotEmpty) {
        await _firestore
            .collection('users/${currentUserId!}/notes')
            .doc(noteId)
            .update({
          'title': title,
          'content': content,
          'created_at': DateTime.now(),
        });
        print(noteId);
        notifyListeners();
      } else {
        print('-- Error updating note -- ');
      }
    } catch (e) {
      // Handle errors
      print('Error updating note: $e');
    }
  }

  // Function to update isFav
  Future<void> updateIsFav({
    required String noteId,
    required bool isFav,
  }) async {
    try {
      await _firestore
          .collection('users/${currentUserId!}/notes')
          .doc(noteId)
          .update({'isFav': isFav});
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error updating note: $e');
    }
  }

  // Function to toggle collapse
  Future<void> toggleCollapse({
    required String noteId,
    required bool isCollapsed,
  }) async {
    try {
      await _firestore
          .collection('users/${currentUserId!}/notes')
          .doc(noteId)
          .update({'isCollapsed': isCollapsed});
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error updating note: $e');
    }
  }

// Function to delete a note
  Future<void> deleteNote(String noteId) async {
    try {
      await _firestore
          .collection('users/${currentUserId!}/notes')
          .doc(noteId)
          .delete();
      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error deleting note: $e');
    }
  }
}
