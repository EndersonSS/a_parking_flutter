class CarEntity {
  final int id;
  String placa;
  final int status;
  int? parkingSpacelk;
  final String entrada;
  final String saida;

  CarEntity({
    this.id = 0,
    this.placa = '',
    this.status = 1,
    this.parkingSpacelk,
    this.entrada = '',
    this.saida = '',
  });
}
