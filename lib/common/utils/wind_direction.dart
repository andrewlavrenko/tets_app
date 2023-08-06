String windDirection(int deg) {
  switch (deg) {
    case >=338 || <= 22:
      return 'северный';
    case >=23 && <= 67:
      return 'северо-восточный';
    case >=68 && <= 112:
      return 'восточный';
    case >=113 && <= 157:
      return 'юго-восточный';
    case >=158 && <= 202:
      return 'южный';
    case >=203 && <= 247:
      return 'юго-западный';
    case >=248 && <= 292:
      return 'западный';
    case >=293 && <= 337:
      return 'северо-западный';
    default:
      return 'северный';
  }
}