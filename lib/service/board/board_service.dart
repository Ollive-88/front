import 'dart:io';

import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ollive_front/models/board/board_detail_model.dart';
import 'package:ollive_front/models/board/board_model.dart';
import 'package:ollive_front/models/comment/comment_model.dart';
import 'package:ollive_front/util/dio/dio_service.dart';

class BoardService {
  static final Dio _dio = DioService().authDio;

  // 게시글 조회
  static Future<List<BoardModel>> getBoardList(
      List<String>? tags, String? keyword, int lastIndex, int size) async {
    final Response response;
    // 보드 화면 최초 접근
    if (keyword == null) {
      response = await _dio.get(
        "/api/v1/boards",
        queryParameters: {
          "tags": tags,
          "lastIndex": lastIndex,
          "size": size,
        },
      );
    } else {
      // 보드 검색 결과
      response = await _dio.get(
        "/api/v1/boards",
        queryParameters: {
          "tags": tags,
          "keyword": keyword,
          "lastIndex": lastIndex,
          "size": size,
        },
      );
    }

    List<BoardModel> boards = response.data['boards'].map<BoardModel>((json) {
      return BoardModel.fromJson(json);
    }).toList();

    return boards;
  }

  // 게시글 생성
  static Future<void> postBoard(String title, List<String> tagNames,
      String content, List<MultipartFile> images) async {
    FormData post = FormData.fromMap({
      "title": title,
      "tagNames": tagNames,
      "content": content,
      "images": images,
    });

    await _dio.post(
      "/api/v1/boards",
      data: post,
    );
  }

  // 게시글 수정
  static Future<void> fatchBoard(
      int boardId,
      List<String> updateTagNames,
      List<int> deleteTagNames,
      List<MultipartFile> updateImages,
      List<int> deleteImages,
      String title,
      String content) async {
    FormData put = FormData.fromMap({
      "updateTagNames": updateTagNames,
      "deleteTags": deleteTagNames,
      "updateImages": updateImages,
      "deleteImages": deleteImages,
      "title": title,
      "content": content,
    });

    await _dio.put(
      "/api/v1/boards/$boardId",
      data: put,
    );
  }

  // 게시글 상세 조회
  static Future<BoardDetailModel> getBoardDetail(int boardId) async {
    final response = await _dio.get(
      "/api/v1/boards/$boardId",
    );

    final instance = BoardDetailModel.fromJson(response.data);

    return instance;
  }

  // 게시글 삭제
  static Future<void> deleteBoard(int boardId) async {
    await _dio.delete(
      "/api/v1/boards/$boardId",
    );
  }

  // 좋아요 생성/삭제
  static void postLike(int boardId) async {
    await _dio.post(
      "/api/v1/boards/$boardId/likes",
    );
  }

  // 댓글 생성
  static Future<CommentModel> postComment(int boardId, String content) async {
    final response = await _dio.post("/api/v1/boards/$boardId/comments", data: {
      "content": content,
    });

    CommentModel commentModel = CommentModel.fromJson(response.data);

    return commentModel;
  }

  // 댓글 삭제
  static Future<void> deleteComment(int boardId, int commentId) async {
    await _dio.delete("/api/v1/boards/$boardId/comments", data: {
      "commentId": commentId,
    });
  }

  // XFile MultipartFile로 변환
  static Future<List<MultipartFile>> convertXFileToMultipartFile(
      List<XFile> xFileList) async {
    List<MultipartFile> multipartFileList = [];

    for (XFile file in xFileList) {
      File tempFile = File(file.path);
      MultipartFile multipartFile = await MultipartFile.fromFile(tempFile.path,
          filename: tempFile.path.split("/").last);
      multipartFileList.add(multipartFile);
    }

    return multipartFileList;
  }

  // 시간 계산
  static String timeAgo(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    Duration difference = DateTime.now().difference(dateTime);

    if (difference.inDays >= 365) {
      int years = (difference.inDays / 365).floor();
      return "$years년 전";
    } else if (difference.inDays >= 30) {
      int months = (difference.inDays / 30).floor();
      return "$months달 전";
    } else if (difference.inDays >= 1) {
      return "${difference.inDays}일 전";
    } else if (difference.inHours >= 1) {
      return "${difference.inHours}시간 전";
    } else if (difference.inMinutes >= 1) {
      return "${difference.inMinutes}분 전";
    } else {
      return "${difference.inSeconds}초 전";
    }
  }

  // 내 게시글 조회
  static Future<List<BoardModel>> getMyBoardList(
      List<String>? tags, int lastIndex, int size, bool isMyView) async {
    final Response response;

    response = await _dio.get(
      "/api/v1/boards",
      queryParameters: {
        "tags": tags,
        "lastIndex": lastIndex,
        "size": size,
        "isMyView": isMyView,
      },
    );

    List<BoardModel> boards = response.data['boards'].map<BoardModel>((json) {
      return BoardModel.fromJson(json);
    }).toList();

    return boards;
  }
}
