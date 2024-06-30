import 'package:hive/hive.dart';

part 'formats.g.dart';

@HiveType(typeId: 2)
class Formats {
  @HiveField(0)
  String textHtml;

  @HiveField(1)
  String applicationEpubZip;

  @HiveField(2)
  String applicationXMobipocketEbook;

  @HiveField(3)
  String textPlainUsAscii;

  @HiveField(4)
  String applicationRdfXml;

  @HiveField(5)
  String imageJpeg;

  @HiveField(6)
  String applicationOctetStream;

  Formats({
    required this.textHtml,
    required this.applicationEpubZip,
    required this.applicationXMobipocketEbook,
    required this.textPlainUsAscii,
    required this.applicationRdfXml,
    required this.imageJpeg,
    required this.applicationOctetStream,
  });

  factory Formats.fromJson(Map<String, dynamic> json) => Formats(
        textHtml: json['text/html'] ?? '',
        applicationEpubZip: json['application/epub+zip'] ?? '',
        applicationXMobipocketEbook:
            json['application/x-mobipocket-ebook'] ?? '',
        textPlainUsAscii: json['text/plain; charset=us-ascii'] ?? '',
        applicationRdfXml: json['application/rdf+xml'] ?? '',
        imageJpeg: json['image/jpeg'] ?? '',
        applicationOctetStream: json['application/octet-stream'] ?? '',
      );
}
