import 'book.dart';

class BookResponse {
  int? count;
  String? next;
  String? previous;
  List<Book>? book;

  BookResponse({
    this.count,
    this.next,
    this.previous,
    this.book,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) => BookResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        book: json["results"] == null
            ? []
            : List<Book>.from(json["results"]!.map((x) => Book.fromJson(x))),
      );
}
