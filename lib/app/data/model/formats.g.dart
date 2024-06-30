// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'formats.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FormatsAdapter extends TypeAdapter<Formats> {
  @override
  final int typeId = 2;

  @override
  Formats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Formats(
      textHtml: fields[0] as String,
      applicationEpubZip: fields[1] as String,
      applicationXMobipocketEbook: fields[2] as String,
      textPlainUsAscii: fields[3] as String,
      applicationRdfXml: fields[4] as String,
      imageJpeg: fields[5] as String,
      applicationOctetStream: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Formats obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.textHtml)
      ..writeByte(1)
      ..write(obj.applicationEpubZip)
      ..writeByte(2)
      ..write(obj.applicationXMobipocketEbook)
      ..writeByte(3)
      ..write(obj.textPlainUsAscii)
      ..writeByte(4)
      ..write(obj.applicationRdfXml)
      ..writeByte(5)
      ..write(obj.imageJpeg)
      ..writeByte(6)
      ..write(obj.applicationOctetStream);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FormatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
