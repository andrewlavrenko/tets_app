String humidityDescription(int humidity) {
  switch (humidity) {
    case <=33:
      return 'Низкая влажность';
    case >=33 && <= 66:
      return 'Средняя влажность';
    case >= 67:
      return 'Высокая влажность';
    default:
      return 'Средняя влажность';
  }
}