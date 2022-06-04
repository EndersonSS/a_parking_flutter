class CarEntity {
  final int id;
  String placa;
  final int status;
  int parkingSpacelk;
  final String entrada;
  final String saida;

  CarEntity({
    required this.id,
    this.placa = '',
    this.status = 1,
    required this.parkingSpacelk,
    this.entrada = '',
    this.saida = '',
  });
}
