bool isToday(DateTime? date) {
  if(date != null){
    DateTime now = DateTime.now();
    return DateTime(date.year, date.month, date.day).difference(DateTime(now.year, now.month, now.day)).inDays == 0;
  }
  return false;
}