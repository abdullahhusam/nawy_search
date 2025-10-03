String formatPrice(int price) {
  if (price >= 1000000) {
    return '${(price / 1000000).toStringAsFixed(1)}M EGP';
  } else {
    return '${(price / 1000).toStringAsFixed(0)}K EGP';
  }
}
