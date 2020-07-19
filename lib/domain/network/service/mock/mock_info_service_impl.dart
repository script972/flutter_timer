import 'package:flutter_app/domain/network/service/command/api_info_service.dart';

class MockInfoSerivceImpl extends ApiInfoService {
  @override
  Future<String> fetchInfo() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return "Mock string for debuging in future";
  }

}