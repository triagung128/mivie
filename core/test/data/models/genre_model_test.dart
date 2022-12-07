import 'package:core/data/models/genre_model.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  const tGenreModel = GenreModel(
    id: 1,
    name: 'name',
  );

  const tGenre = Genre(
    id: 1,
    name: 'name',
  );

  const tGenreJson = {
    'id': 1,
    'name': 'name',
  };

  test('should be a subclass of Genre entity', () {
    final result = tGenreModel.toEntity();
    expect(result, tGenre);
  });

  test('should be a subclass of Genre json', () {
    final result = tGenreModel.toJson();
    expect(result, tGenreJson);
  });
}
