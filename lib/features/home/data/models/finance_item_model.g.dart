// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'finance_item_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FinanceItemModelAdapter extends TypeAdapter<FinanceItemModel> {
  @override
  final int typeId = 0;

  @override
  FinanceItemModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FinanceItemModel(
      title: fields[0] as String,
      dateTime: fields[1] as DateTime,
      amount: fields[2] as double,
      categoryId: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, FinanceItemModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.dateTime)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.categoryId);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FinanceItemModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
