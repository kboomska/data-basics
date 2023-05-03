import 'package:themoviedb/domain/data_providers/session_data_provider.dart';

class MyAppModel {
  final _sessionDataProvider = SessionDataProvider();
  var _isAuth = false;
  bool get isAuth => _isAuth;

  Future<void> chechAuth() async {
    final sessionId = await _sessionDataProvider.getSessionId();
    _isAuth = sessionId != null;
  }
}
