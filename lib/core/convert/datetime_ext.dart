extension DatetimeExt on DateTime {
  String toDDMMYYYY(){
    String dia = day.toString().padLeft(2, '0');
    String mes = month.toString().padLeft(2, '0');
    String ano = year.toString().padLeft(2, '0');

    return "$dia/$mes/$ano";
  }
}