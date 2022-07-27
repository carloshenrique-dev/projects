import 'dart:developer';
import 'package:up_afv/core/models/api/api_return_auth_model.dart';
import 'package:up_afv/core/models/auth/auth_model.dart';
import 'package:up_afv/core/models/configs/config_model.dart';
import 'package:up_afv/core/models/configs/preferences_model.dart';
import 'package:up_afv/core/services/api/api_provider.dart';
import 'package:up_afv/core/services/db/db_service.dart';
import './auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiProvider _apiProvider;
  final DbService _dbService;

  AuthRepositoryImpl({
    required ApiProvider apiProvider,
    required DbService dbService,
  })  : _apiProvider = apiProvider,
        _dbService = dbService;

  @override
  Future<ApiReturnAuthModel> doAuth({required AuthModel authModel}) async {
    try {
      var isValidAuthentication = await isValidAuth(authModel);
      var prefs = await _dbService.queryPreferences();
      if (isValidAuthentication.active!) {
        if (prefs.isEmpty) {
          Future.wait([
            _dbService.insertData(
              args: PreferencesModel(
                clientId: authModel.clientId,
                passwordClient: authModel.password,
                sellerCode: authModel.sellerCode,
                token: '',
              ),
              table: 'preferences',
            ),
            _dbService.insertData(
                args: ConfigModel(
                  codFilterCli: 0,
                  codFilterProd: 0,
                ),
                table: 'config'),
          ]);
          return isValidAuthentication;
        } else if (prefs[0].clientId == authModel.clientId &&
            prefs[0].passwordClient == authModel.password &&
            prefs[0].sellerCode == authModel.sellerCode) {
          return isValidAuthentication;
        } else {
          await _dbService.updatePreferences(
            values: {
              'clientId': authModel.clientId,
              'passwordClient': authModel.password,
              'sellerCode': authModel.sellerCode,
              'token': '',
            },
            table: 'preferences',
          );
          return isValidAuthentication;
        }
      }
      return isValidAuthentication;
    } catch (e) {
      log(e.toString());
      return ApiReturnAuthModel(active: false, idUp: false);
    }
  }

  Future<ApiReturnAuthModel> isValidAuth(AuthModel authModel) async {
    try {
      var ret = await _apiProvider
          .post(path: 'http://192.168.56.1:5246/Auth', data: {
        'idClient': authModel.clientId,
        'sellerCode': authModel.sellerCode,
        'password': authModel.password,
      });
      if (ret.statusCode == 200 && ret.data['active'] == true) {
        return ApiReturnAuthModel.fromMap(ret.data);
      } else if (ret.statusCode == 400 && ret.data['active'] == false) {
        return ApiReturnAuthModel.fromJson(ret.data);
      }
      return ApiReturnAuthModel(active: false, idUp: false);
    } catch (e) {
      return ApiReturnAuthModel(active: false, idUp: false);
    }
  }
}
