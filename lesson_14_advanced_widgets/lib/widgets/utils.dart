double getPercentFromRange(double start, double end, double value) {
  if (value <= start) {
    return 0.0;
  } else if (value >= end) {
    return 1.0;
  } else {
    return (value - start) / (end - start);
  }
}
