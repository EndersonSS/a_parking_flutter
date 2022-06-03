class ParkingSpaceEntity {
  final int id;
  final String vaga;
  final int carFk;
  final String veiculo;
  final int status;
  final String entrada;
  final String saida;

  const ParkingSpaceEntity({
    required this.id,
    required this.vaga,
    required this.status,
    this.carFk = 0,
    this.veiculo = '',
    this.entrada = '',
    this.saida = '',
  });
}
