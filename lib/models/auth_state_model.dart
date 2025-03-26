enum LocalAuthStatus { authenticated, notAuthenticated, authenticating }

class LocalAuthStateModel {
  final bool didAuth;
  final LocalAuthStatus status;
  final String message;

  LocalAuthStateModel({
    this.didAuth = false,
    this.status = LocalAuthStatus.notAuthenticated,
    this.message = '',
  });

  LocalAuthStateModel copyWith({
    bool? didAuth,
    LocalAuthStatus? status,
    String? message,
  }) {
    return LocalAuthStateModel(
      didAuth: didAuth ?? this.didAuth,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  String toString() {
    return '''
      didAuth: $didAuth,
      status: $status,
      message: $message
    ''';
  }
}
