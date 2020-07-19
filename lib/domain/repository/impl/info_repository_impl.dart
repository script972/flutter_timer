import 'package:flutter_app/domain/network/service/command/api_info_service.dart';
import 'package:flutter_app/domain/network/service_connector_factory.dart';
import 'package:flutter_app/domain/repository/info_repository.dart';

class InfoRepositoryImpl extends InfoRepository {
  final ApiInfoService apiService = ServiceConnectorFactory.getAPIService(
      serviceType: ServiceClientEnum.INFO);

  @override
  Future<String> fetchInfoString() {
    return apiService.fetchInfo();
  }
}
