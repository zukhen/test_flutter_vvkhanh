import 'package:dio/dio.dart';

import '../model/address.model.dart';

class ApiService {
  static const String _baseUrl = 'https://autosuggest.search.hereapi.com/v1/autosuggest';
  static const String _apiKey = 'eyJhbGciOiJSUzUxMiIsImN0eSI6IkpXVCIsImlzcyI6IkhFUkUiLCJhaWQiOiJteHJEU3hpOWNZS1A5TDRPV2djcCIsImlhdCI6MTcyNTkzMjQ3OSwiZXhwIjoxNzI2MDE4ODc5LCJraWQiOiJqMSJ9.ZXlKaGJHY2lPaUprYVhJaUxDSmxibU1pT2lKQk1qVTJRMEpETFVoVE5URXlJbjAuLmZpdGJhUTNKUlRkQnNPRlRHWnU0aFEuMU1uWHhoZ3NNRTlUWGtycU5yaGJSN1pJS2gySkNKT0VMTVVoakpYc291OUQ3LWFLUWQtY09HRkEtdHN0TVhmYWtoR1NmdEY0YjlzZUtnYWlVeFVmTkpGdGJUQzlab2N2QzdxWHJFYjhuRmF4dXotbGZ1WkJ2d01Ja3NqMzdtUUViUnlxQ1pKOWhvSE9ReFhnR0VKOGMxaXNaNkxjQk5uTzlzRzVsbUoyaXpzLkJKQUdoU3JQU3lqN2xqS08yMExGcWYyUFgwdWxyeEVjamRXVkhEV2tlekU.pm1xTyp4ZxYXUTqXebSRD628Mg7jPVLU0AcCbJV70zodl9oMRV0zklAAtkdWW1je8FDE_FFfDJ1_okGJ_I5lAeGAR6Ojf1qpSyVEcRSZTx_vn16_LcCGE0qu7JeM4vdAOR6fGl1YB_vlL_FarHv8sSgycsFa0NGpAfvMSygrb5g5KYUhhljhrlin6sLGIp-cJzwMXxUgY4BQMAgqZ3SIis71BTT2Y7l_np5xnRRcdpnDkXNu55gtrvscWnv3-xNkyFrrYrGlOQtS10557HyPqOHvBPDBdAx7N0AgAcTUc97QM5JXTrB5R3DmLgcjyL11eO7XNkWAINV-PeSx6phZmA'; 
  static final Dio _dio = Dio();

  static Map<String, dynamic> header(String token) {
    return {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
  }

  static Future<List<AddressModel>> searchAddress(String query) async {
    const  hanoiPos='at=21.020493,105.785576';
    final url = '$_baseUrl?q=$query&$hanoiPos';

    try {
      final response = await _dio.get(url, options: Options(headers: header(_apiKey)));

      if (response.statusCode == 200) {
        final data = response.data;
        List<AddressModel> addresses = (data['items']as List)
            .map((item) => AddressModel.fromJson(item))
            .toList();
        print("===========================${data['items'].runtimeType}");
        return addresses;
      }
      else{
        print("loi api");
        return [];
      }
    } on DioException catch (e) {
      throw Exception('Dio error: ${e.message}');
    }
  }
}
