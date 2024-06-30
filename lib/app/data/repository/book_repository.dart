import 'dart:convert';

import 'package:connectivity/connectivity.dart';
import 'package:ebooks/app/common/constant.dart';
import 'package:ebooks/app/data/model/book.dart';
import 'package:ebooks/app/data/model/book_response.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class BookRepository {
  Future<bool> _isInternetConnected() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    return connectivityResult != ConnectivityResult.none;
  }

  Future<List<Book>?> fetchBooks(int currentPage, String query) async {
    bool isConnected = await _isInternetConnected();

    try {
      if (isConnected) {
        const url = 'https://gutendex.com/books/';
        final parameters = '?page=$currentPage&search=$query';
        var response = await http.get(Uri.parse(url + parameters));
        if (response.statusCode == 200) {
          var jsonData = jsonDecode(response.body);

          final bookResponse = BookResponse.fromJson(jsonData);
          final isClearCache = (currentPage == 1 && query == '');
          _saveBooksToHive(bookResponse.book!, isClearCache);
          return bookResponse.book;
        }
      }
      if (currentPage == 1) {
        final books = await _fetchBooksFromHive(query);
        if ((books == null || books.isEmpty) && currentPage == 1) {
          throw 'No internet';
        }
        return books;
      }
      throw 'No internet';
    } catch (e) {
      rethrow;
    }
  }

  Future<List<Book>?> _fetchBooksFromHive(String query) async {
    try {
      final box = await Hive.openBox<Book>(tableBook);
      final bookList = box.values;
      if (query.isEmpty) {
        return bookList.toList();
      }
      return bookList
          .where((book) =>
              book.title!.toLowerCase().contains(query) ||
              book.authors!
                  .any((author) => author.name.toLowerCase().contains(query)))
          .toList();
    } catch (e) {
      print('Error fetching data from Hive: $e');
    }
    return null;
  }

  Future<List<Book>?> fetchFavorites() async {
    try {
      final box = await Hive.openBox<Book>(tableFavorite);
      return box.values.toList();
    } catch (e) {
      print('Error fetching data from Hive: $e');
    }
    return null;
  }

  Future<Book?> getDetailBook(int id) async {
    try {
      final favoriteBook = await _getFavorite(id);
      if (favoriteBook != null) {
        return favoriteBook;
      }
      final book = await _getBook(id);
      return book;
    } catch (e) {
      print('Error fetching book from Hive: $e');
    }
    return null;
  }

  Future<void> addFavorite(Book book) async {
    try {
      final box = await Hive.openBox<Book>(tableFavorite);
      await box.put(book.id, book);
    } catch (e) {
      print('error addFavorite -> $e');
    }
  }

  Future<void> removeFavorite(Book book) async {
    try {
      final box = await Hive.openBox<Book>(tableFavorite);
      await box.delete(book.id);
    } catch (e) {
      print('error removeFavorite -> $e');
    }
  }

  Future<Book?> _getFavorite(int id) async {
    try {
      final box = await Hive.openBox<Book>(tableFavorite);
      final book = box.get(id);
      return book;
    } catch (e) {
      print('Error fetching _getFavorite: $e');
    }
    return null;
  }

  Future<Book?> _getBook(int id) async {
    try {
      final box = await Hive.openBox<Book>(tableBook);
      final book = box.get(id);
      return book;
    } catch (e) {
      print('Error fetching _getBook: $e');
    }
    return null;
  }

  Future<void> _saveBooksToHive(List<Book> books, bool isClearCache) async {
    try {
      final box = await Hive.openBox<Book>(tableBook);
      // if (isClearCache) await box.clear();
      for (var book in books) {
        await box.put(book.id, book);
      }
    } catch (e) {
      print('error save -> $e');
    }
  }
}
