import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:ollive_front/screens/user/authentication/login_screen.dart';
import 'package:ollive_front/util/controller/getx_controller.dart';

class DioService {
  Dio? _authDio;
  final _requestQueue = Queue<RequestOptions>();
  static final DioService _instance = DioService._internal();

  factory DioService() {
    return _instance;
  }

  DioService._internal() {
    _authDio = Dio(BaseOptions(baseUrl: "https://j10a508.p.ssafy.io"));
    _authDio!.options.headers['userAgent'] =
        'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/118.0.0.0 Whale/3.23.214.17 Safari/537.36';
    _authDio!.options.headers['Content-Type'] = 'application/json';

    _authDio!.interceptors.clear();

    _authDio!.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = Get.find<StatusController>().token;
          if (token.accessToken == null) {
            return handler.next(options);
          }

          options.headers['Authorization'] = '${token.accessToken}';
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
              Get.to(const LoginScreen());
              return;
            }

            try {
              var refreshDio =
                  Dio(BaseOptions(baseUrl: "http://j10a508.p.ssafy.io"));
              refreshDio.options.headers['Authorization'] =
                  '${token.refreshToken}';
              final response = await refreshDio.post(
                "/api/auth/token/refresh",
              );

              if (response.statusCode == 200) {
                const storage = FlutterSecureStorage();

                final String accessToken, refreshToken;
                final authorization = response.headers['Authorization'];
                final cookies = response.headers['Set-Cookie'];

                if (cookies != null) {
                  final cookie = cookies.first;
                  // 쿠키 문자열에서 리프레시 토큰 값을 파싱
                  RegExp regExp = RegExp(r'Refresh=([^;]+)');
                  Match? match = regExp.firstMatch(cookie);
                  if (match != null) {
                    refreshToken = match.group(1)!;
                    storage.write(key: 'refreshToken', value: refreshToken);
                    token.refreshToken = refreshToken;
                  }
                }
                if (authorization != null) {
                  accessToken = authorization.first;
                  storage.write(key: 'accessToken', value: accessToken);
                  token.accessToken = accessToken;
                }
                _processRequestQueue(token.accessToken!);
                return;
              }
            } catch (error) {
              const storage = FlutterSecureStorage();
              storage.delete(key: "accessToken");
              storage.delete(key: "refreshToken");
              Get.to(const LoginScreen());
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
