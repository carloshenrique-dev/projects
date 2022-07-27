import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:up_afv/core/models/api/api_return_login_model.dart';
import 'package:up_afv/core/models/login/login_model.dart';
import 'package:up_afv/core/models/configs/preferences_model.dart';
import 'package:up_afv/core/services/api/api_provider.dart';
import 'package:up_afv/core/services/db/db_service.dart';
import 'login_repository.dart';

class LoginRepositoryImpl implements LoginRepository {
  final ApiProvider _apiProvider;
  final DbService _dbService;

  LoginRepositoryImpl({
    required ApiProvider apiProvider,
    required DbService dbService,
  })  : _apiProvider = apiProvider,
        _dbService = dbService;

  @override
  Future<ApiReturnLoginModel> doLogin({required LoginModel loginModel}) async {
    try {
      var ret = await _apiProvider
          .post(path: 'http://192.168.56.1:5246/Login', data: {
        'user': loginModel.user,
        'password': loginModel.password,
      });
      if (ret.statusCode == 200) {
        var data = ApiReturnLoginModel.fromJson(ret.data);
        var update =
            await _dbService.updatePreferences(table: 'preferences', values: {
          'sellerName': data.nomeVend,
          'user': loginModel.user,
          'password': loginModel.password
        });
        if (update) {
          return data;
        } else {
          return ApiReturnLoginModel();
        }
      } else if (ret.statusCode == 400) {
        return ApiReturnLoginModel.fromJson(ret.data);
      }
      return ApiReturnLoginModel();
    } on DioError catch (e) {
      if (e.response != null && e.response?.statusCode == 400) {
        return ApiReturnLoginModel.fromJson(e.response!.data);
      }
      return ApiReturnLoginModel();
    } catch (e) {
      return ApiReturnLoginModel();
    }
  }

  @override
  setDevice({required int sellerCode, required String deviceId}) async {
    try {
      var response = await _apiProvider
          .put(path: 'http://192.168.56.1:5246/Login/returnLogin', data: {
        'SellerCode': sellerCode,
        'MobileId': deviceId,
      });
      if (response.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      log(e.toString());
      return false;
    }
  }

  @override
  Future<List<PreferencesModel>> getPreferences() async {
    try {
      return await _dbService.queryPreferences();
    } catch (e) {
      log(e.toString());
      return [];
    }
  }

  @override
  Future<bool> doLogout() async {
    try {
      return await _dbService.clearTables();
    } catch (e) {
      return false;
    }
  }
}
