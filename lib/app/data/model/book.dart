import 'package:hive/hive.dart';
import 'formats.dart';
import 'author.dart';

part 'book.g.dart';

@HiveType(typeId: 0)
class Book {
  @HiveField(0)
  int? id;

  @HiveField(1)
  String? title;

  @HiveField(2)
  List<Author>? authors;

  @HiveField(3)
  List<String>? subjects;

  @HiveField(4)
  List<String>? bookshelves;

  @HiveField(5)
  bool? copyright;

  @HiveField(6)
  Formats? formats;

  @HiveField(7)
  int? downloadCount;

  @HiveField(8)
  bool isFavorite;

  Book({
    this.id,
    this.title,
    this.authors,
    this.subjects,
    this.bookshelves,
    this.copyright,
    this.formats,
    this.downloadCount,
    this.isFavorite = false,
  });

  Book copyWith({
    bool? isFavorite,
  }) =>
      Book(
        isFavorite: isFavorite ?? this.isFavorite,
      );

  factory Book.fromJson(Map<String, dynamic> json) => Book(
        id: json["id"],
        title: json["title"],
        authors: json["authors"] == null
            ? []
            : List<Author>.from(
                json["authors"]!.map((x) => Author.fromJson(x))),
        subjects: json["subjects"] == null
            ? []
            : List<String>.from(json["subjects"]!.map((x) => x)),
        bookshelves: json["bookshelves"] == null
            ? []
            : List<String>.from(json["bookshelves"]!.map((x) => x)),
        copyright: json["copyright"],
        formats:
            json["formats"] == null ? null : Formats.fromJson(json["formats"]),
        downloadCount: json["download_count"],
      );
}
