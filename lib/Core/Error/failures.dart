import '../Network/error_message_model.dart';

abstract class Failure {
  final ErrorMessageModel errorModel;

  const Failure(this.errorModel);
}

// General failures
class ServerFailure extends Failure {
  const ServerFailure(super.model);
}
