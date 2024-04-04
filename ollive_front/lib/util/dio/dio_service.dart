import 'dart:collection';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';

class DioService {
  Dio? _authDio;
  final _requestQueue = Queue<RequestOptions>();
  static final DioService _instance = DioService._internal();

  factory DioService() {
    return _instance;
  }

  DioService._internal() {
    _authDio = Dio(BaseOptions(baseUrl: "http://j10a508.p.ssafy.io"));
    _authDio!.options.headers['userAgent'] =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Whale/3.23.214.17 Safari/537.36';
    _authDio!.options.headers['Content-Type'] = 'application/json';

    _authDio!.interceptors.clear();

    _authDio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = Get.find<StatusController>().token;
          options.headers['Authorization'] =
              'Bearer eyJhbGciOiJIUzI1NiJ9.eyJpZCI6NSwicm9sZSI6IlJPTEVfUkVHSVNURVJFRF9NRU1CRVIiLCJpYXQiOjE3MTE3ODQ5NjQsImV4cCI6MTc3MTc4NDk2NH0.tcoSpH9vbomZxLqs1_gzbuuPjLNyqUwsmwZFcdKlKm0';
          if (token.accessToken == null) {
            return handler.next(options);
          }

          options.headers['Authorization'] = 'Bearer ${token.accessToken}';
          return handler.next(options);
        },
        onResponse: (response, handler) async {
          handler.next(response);
        },
        onError: (error, handler) async {
          if (error.response?.statusCode == 401) {
            _requestQueue.add(error.requestOptions);

            final token = Get.find<StatusController>().token;
            // refresh token이 없으면 로그인 페이지로 이동
            if (token.refreshToken == null) {
              // moveToLoginScreen();
              return;
            }

            try {
              var refreshDio =
                  Dio(BaseOptions(baseUrl: "http://j10a508.p.ssafy.io"));
              final response = await refreshDio.post(
                "/api/auth/token/refresh",
                data: jsonEncode(
                    <String, String>{'refresh-token': token.refreshToken!}),
              );

              if (response.statusCode == 200) {
                Get.find<StatusController>().setToken(Token(
                  accessToken: response.data["accessToken"],
                  refreshToken: response.data["refreshToken"],
                ));

                _processRequestQueue(Get.find<StatusController>()
                    .token
                    .accessToken!); // 저장된 요청 처리
                return;
              } else {
                // moveToLoginScreen();
              }
            } catch (error) {
              // moveToLoginScreen();
            }
          } else {
            handler.next(error);
          }
        },
      ),
    );
  }

  Dio get authDio => _authDio!;

  void _processRequestQueue(String accessToken) async {
    while (_requestQueue.isNotEmpty) {
      var requestOptions = _requestQueue.removeFirst();

      requestOptions.headers['Authorization'] = 'Bearer $accessToken';
      try {
        await _authDio!.fetch(requestOptions); // 요청 재실행
      } catch (e) {
        // ignore: avoid_print
        print("Failed to reprocess request: $e");
      }
    }
  }
}
