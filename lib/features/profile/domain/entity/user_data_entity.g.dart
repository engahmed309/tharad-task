// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataEntityAdapter extends TypeAdapter<UserDataEntity> {
  @override
  final int typeId = 1;

  @override
  UserDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataEntity(
      id: fields[0] as int?,
      username: fields[1] as String?,
      email: fields[2] as String?,
      image: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserDataEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.username)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.image);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
