// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BookAdapter extends TypeAdapter<Book> {
  @override
  final int typeId = 0;

  @override
  Book read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Book(
      id: fields[0] as int?,
      title: fields[1] as String?,
      authors: (fields[2] as List?)?.cast<Author>(),
      subjects: (fields[3] as List?)?.cast<String>(),
      bookshelves: (fields[4] as List?)?.cast<String>(),
      copyright: fields[5] as bool?,
      formats: fields[6] as Formats?,
      downloadCount: fields[7] as int?,
      isFavorite: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Book obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.authors)
      ..writeByte(3)
      ..write(obj.subjects)
      ..writeByte(4)
      ..write(obj.bookshelves)
      ..writeByte(5)
      ..write(obj.copyright)
      ..writeByte(6)
      ..write(obj.formats)
      ..writeByte(7)
      ..write(obj.downloadCount)
      ..writeByte(8)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BookAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
