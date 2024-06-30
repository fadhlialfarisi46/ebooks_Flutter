import 'package:hive/hive.dart';

part 'author.g.dart';

@HiveType(typeId: 1)
class Author {
  @HiveField(0)
  String name;

  @HiveField(1)
  int? birthYear;

  @HiveField(2)
  int? deathYear;

  Author({
    required this.name,
    required this.birthYear,
    required this.deathYear,
  });

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        name: json["name"],
        birthYear: json["birth_year"],
        deathYear: json["death_year"],
      );
}
