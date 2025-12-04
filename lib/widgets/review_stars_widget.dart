import 'package:flutter/material.dart';

Widget starsRating(int rating) {
  return Row(
    children: List.generate(5, (index) {
      if (index < rating.floor()) {
        return const Icon(Icons.star_rounded, color: Colors.amber);
      } else {
        return const Icon(Icons.star_rounded, color: Colors.grey);
      }
    }),
  );
}
