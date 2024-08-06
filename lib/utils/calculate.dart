double calculateStepToKm(int steps) {
  const int height = 175;
  double stepLength = height * 0.413;
  return stepLength * steps / 100000;
}
