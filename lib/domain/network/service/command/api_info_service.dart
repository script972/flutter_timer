import 'package:flutter_app/domain/network/service/command/base_api_service.dart';

abstract class ApiInfoService extends BaseApiService {
  Future<String> fetchInfo();
}