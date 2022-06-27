// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final int id_review;
  final String nama;
  final int score;
  final String type;
  final String review;
  final String image;

  const Review({
    required this.id_review,
    required this.nama,
    required this.score,
    required this.type,
    required this.review,
    required this.image,
  });

  @override
  List<Object?> get props => [id_review];

  static Review dummy = const Review(
    id_review: 1,
    nama: 'dev noersy',
    score: 4,
    type: 'Fasilitas',
    review: 'Mohon Menjaga kebersihan, kemarin meja masih kotor',
    image: 'https://picsum.photos/300/200',
  );
}
