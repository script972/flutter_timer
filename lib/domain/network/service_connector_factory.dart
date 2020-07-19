import 'package:flutter/material.dart';
import 'package:flutter_app/domain/network/service/command/base_api_service.dart';
import 'package:flutter_app/domain/network/service/http/http_info_service_impl.dart';
import 'package:flutter_app/domain/network/service/mock/mock_info_service_impl.dart';

enum ServiceTypeEnum { HTTP, MOCK }

enum ServiceClientEnum { INFO }

class ServiceConnectorFactory {
  static BaseApiService getAPIService(
      {@required ServiceClientEnum serviceType,
      ServiceTypeEnum useMockedService = ServiceTypeEnum.HTTP}) {
    assert(serviceType != null);
    switch (serviceType) {
      case ServiceClientEnum.INFO:
        return useMockedService == ServiceTypeEnum.HTTP
            ? HttpInfoSerivceImpl()
            : MockInfoSerivceImpl();
        break;
    }
  }
}
