import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/home/data/datasource/home_remote_datasource_impl.dart';
import 'package:donor_app/features/home/domain/entities/home_data_entity.dart';
import 'package:donor_app/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDatasourceImpl _remoteDatasource;

  HomeRepositoryImpl(this._remoteDatasource);
  @override
  Future<ApiResult<HomeDataEntity>> getHomeData() async {
    return await _remoteDatasource.getHomeData();
  }
}
