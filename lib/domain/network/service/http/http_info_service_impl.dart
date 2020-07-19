import 'package:dio/dio.dart';
import 'package:flutter_app/domain/network/http_manager.dart';
import 'package:flutter_app/domain/network/service/command/api_info_service.dart';

class HttpInfoSerivceImpl extends  ApiInfoService {

  @override
  Future<String> fetchInfo() async{
    Response response =
        await HttpManager().dio.get("/raw/jmhKjPLD");
    return response.data;
  }

}