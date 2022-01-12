import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:music_player_flutter/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:music_player_flutter/core/network/api_url.dart';
import 'package:music_player_flutter/core/network/dio_module.dart';
import 'package:music_player_flutter/core/network/network_module.dart';
import 'package:music_player_flutter/data/model/songs_model.dart';
import 'package:music_player_flutter/domain/entities/songs.dart';
import 'package:music_player_flutter/domain/repositories/home_repositories.dart';

class HomeRepositoryImpl extends NetworkModule implements HomeRepository {
  HomeRepositoryImpl._();
  Dio get _dio => DioModule.getInstance();

  static HomeRepositoryImpl getInstance() => HomeRepositoryImpl._();

  @override
  Future<Either<Failure, Result>> getInitialSongs() async {
    final response = await getMethod("search?term=rex+orange+county");
    return Right(ResultModel.fromJson(jsonDecode(response)));
  }
}
