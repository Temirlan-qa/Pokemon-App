import 'package:flutter/material.dart';

AnimatedContainer buildDot({int? index,int? currentPage}) {
  return AnimatedContainer(
    duration: const Duration(milliseconds: 500),
    margin: const EdgeInsets.only(right: 8),
    height: 9,
    width: currentPage == index  ? 40 : 9,
    decoration: BoxDecoration(
      color: currentPage == index
          ? const Color(0xFF173EA5)
          : const Color(0xFF4565B7).withOpacity(0.25),
      borderRadius: BorderRadius.circular(11),
    ),
  );
}