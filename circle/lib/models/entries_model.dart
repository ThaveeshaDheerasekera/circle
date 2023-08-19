import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:circle/configs/url_location.dart';
import 'package:circle/entities/entry.dart';

class EntriesModel extends ChangeNotifier {
  // ------ Main Functions ------

  List<Entry> _entries = [];

  List<Entry> get entryList {
    return _entries;
  }

  // fetchEntryList Future Model
  Future<void> fetchEntryList() async {
    try {
      final url = Uri.parse('${UrlLocation.baseUrl}/entries/');
      final response = await http.get(url);

      if (response.statusCode >= 400) {
        throw response.body;
      }

      final List<dynamic> data = json.decode(response.body)['entries'];

      // Clear existing entries and add new entries in one operation
      _entries
        ..clear()
        ..addAll(
            // Using map to create Entry objects from entryListData
            data
                .map((item) => Entry(
                      entry_id: item['entry_id'],
                      title: item['title'],
                      content: item['content'],
                      image: item['image'] != null ? item['image'] : null,
                      created_at: DateTime.parse(item['created_at']
                          .substring(0, item['created_at'].length - 6)),
                    ))
                .toList());

      // Notify listeners after updating entries
      notifyListeners();
    } catch (e) {
      if (e is SocketException) {
        print('Socket Exception: $e');
        throw Exception('Failed to connect to the server.');
      } else if (e is FormatException) {
        print('Format Exception: $e');
        throw Exception('Failed to parse response data.');
      } else if (e is TimeoutException) {
        print('Timeout Exception: $e');
        throw Exception('Request timed out.');
      } else {
        print('Unknown Exception: $e');
        throw Exception('An unknown error occurred.');
      }
    }
  }

  // createEntry function
  Future<void> createEntry(
      String title, String content, File? image, int userId) async {
    try {
      final url = Uri.parse('${UrlLocation.baseUrl}/entries/');

      final request = http.MultipartRequest('POST', url)
        ..fields['title'] = title
        ..fields['content'] = content
        ..fields['user'] = userId.toString();

      if (image != null) {
        final imageBytes = await image.readAsBytes();
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: image.path.split('/').last, // Change the filename as needed
        ));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        // Entry creation successful
        print('Entry created successfully: $responseBody');
      } else {
        // Entry creation failed
        print('Failed to create entry: $responseBody');
        throw Exception('Failed to create entry');
      }
      fetchEntryList();
      notifyListeners();
    } catch (e) {
      if (e is SocketException) {
        print('Socket Exception: $e');
        throw Exception('Failed to connect to the server.');
      } else if (e is FormatException) {
        print('Format Exception: $e');
        throw Exception('Failed to parse response data.');
      } else if (e is TimeoutException) {
        print('Timeout Exception: $e');
        throw Exception('Request timed out.');
      } else {
        print('Unknown Exception: $e');
        throw Exception('An unknown error occurred.');
      }
    }
  }

  // updateEntry function
  Future<void> updateEntry(
      String entry_id, String title, String content, File? image) async {
    try {
      final url = Uri.parse('${UrlLocation.baseUrl}/entries/$entry_id/');

      final request = http.MultipartRequest('PUT', url)
        ..fields['title'] = title
        ..fields['content'] = content;

      if (image != null) {
        final imageBytes = await image.readAsBytes();
        request.files.add(http.MultipartFile.fromBytes(
          'image',
          imageBytes,
          filename: image.path.split('/').last,
        ));
      }

      final response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 200) {
        // Entry update successful
        print('Entry updated successfully: $responseBody');
      } else {
        // Entry update failed
        print('Failed to update entry: $responseBody');
        throw Exception('Failed to update entry');
      }
      fetchEntryList(); // Refresh the entry list
      notifyListeners();
    } catch (e) {
      if (e is SocketException) {
        print('Socket Exception: $e');
        throw Exception('Failed to connect to the server.');
      } else if (e is FormatException) {
        print('Format Exception: $e');
        throw Exception('Failed to parse response data.');
      } else if (e is TimeoutException) {
        print('Timeout Exception: $e');
        throw Exception('Request timed out.');
      } else {
        print('Unknown Exception: $e');
        throw Exception('An unknown error occurred.');
      }
    }
  }

  // deleteEntry function
  Future<void> deleteEntry(int index) async {
    try {
      final entry = _entries[index];
      final entry_id = entry.entry_id; // Get the entry_id from the entry
      final url = Uri.parse('${UrlLocation.baseUrl}/entries/$entry_id/');
      final response = await http.delete(url);

      if (response.statusCode == 200) {
        // Entry deletion successful
        print('Entry deleted successfully');
      } else {
        // Entry deletion failed
        print('Failed to delete entry: ${response.statusCode}');
        throw Exception('Failed to delete entry');
      }
      notifyListeners();
    } catch (e) {
      if (e is SocketException) {
        print('Socket Exception: $e');
        throw Exception('Failed to connect to the server.');
      } else if (e is FormatException) {
        print('Format Exception: $e');
        throw Exception('Failed to parse response data.');
      } else if (e is TimeoutException) {
        print('Timeout Exception: $e');
        throw Exception('Request timed out.');
      } else {
        print('Unknown Exception: $e');
        throw Exception('An unknown error occurred.');
      }
    }
  }

  // ------ Other Functions ------

  bool isCollapsed = false;

  void toggleCollapseState(int index) {
    final entry = _entries[index];
    entry.isCollapsed = !entry.isCollapsed;
    notifyListeners();
  }
}
