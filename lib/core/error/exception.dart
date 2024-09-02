class ServerException implements Exception {
  final String message;
  const ServerException(this.message);
}

class HiveDataException implements Exception {
  final String message;

  const HiveDataException({required this.message});
}
