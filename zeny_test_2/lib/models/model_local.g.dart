// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LocalModelAdapter extends TypeAdapter<LocalModel> {
  @override
  final int typeId = 0;

  @override
  LocalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LocalModel(
      transactionId: fields[0] as int,
      transactionDate: fields[1] as int,
      transactionType: fields[2] as String,
      transactionAmount: fields[3] as double,
      transactionCategory: fields[4] as String,
      transactionCurrency: fields[5] as String,
      transactionName: fields[6] as String,
      isDelete: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, LocalModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.transactionId)
      ..writeByte(1)
      ..write(obj.transactionDate)
      ..writeByte(2)
      ..write(obj.transactionType)
      ..writeByte(3)
      ..write(obj.transactionAmount)
      ..writeByte(4)
      ..write(obj.transactionCategory)
      ..writeByte(5)
      ..write(obj.transactionCurrency)
      ..writeByte(6)
      ..write(obj.transactionName)
      ..writeByte(7)
      ..write(obj.isDelete);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
