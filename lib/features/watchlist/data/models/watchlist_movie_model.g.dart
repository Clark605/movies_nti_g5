// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watchlist_movie_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchlistMovieAdapter extends TypeAdapter<WatchlistMovieModel> {
  @override
  final int typeId = 0;

  @override
  WatchlistMovieModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchlistMovieModel(
      movieId: fields[0] as int,
      title: fields[1] as String,
      posterPath: fields[2] as String?,
      releaseDate: fields[3] as String,
      voteAverage: fields[4] as double,
      runtime: fields[5] as int,
      genre: fields[6] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WatchlistMovieModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.movieId)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.posterPath)
      ..writeByte(3)
      ..write(obj.releaseDate)
      ..writeByte(4)
      ..write(obj.voteAverage)
      ..writeByte(5)
      ..write(obj.runtime)
      ..writeByte(6)
      ..write(obj.genre);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchlistMovieAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
