// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';

class Review extends Equatable {
  final int id_review;
  final String nama;
  final double score;
  final String type;
  final String review;
  final String? image;

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

  /// From json
  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id_review: json['id_review'] as int,
      nama: json['nama'] as String,
      score: json['score'] as double,
      type: json['type'] as String,
      review: json['review'] as String,
      image: json['image'] as String?,
    );
  }

  static Review dummy = const Review(
    id_review: 1,
    nama: 'dev noersy',
    score: 4,
    type: 'Fasilitas',
    review: 'Mohon Menjaga kebersihan, kemarin meja masih kotor',
    image: 'https://picsum.photos/300/200',
  );
}

class ListReviewRes {
  final int status_code;
  final String? message;
  final List<Review>? data;

  const ListReviewRes({
    required this.status_code,
    this.message,
    this.data,
  });

  /// From json
  factory ListReviewRes.fromJson(Map<String, dynamic> json) {
    return ListReviewRes(
      status_code: json['status_code'] as int,
      message: json['message'] as String?,
      data: json['status_code'] == 200
          ? json['data'].map<Review>((e) => Review.fromJson(e)).toList()
          : null,
    );
  }
}
