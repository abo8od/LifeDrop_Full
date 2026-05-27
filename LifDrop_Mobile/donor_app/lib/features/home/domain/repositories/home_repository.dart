import 'package:donor_app/core/networking/api_result.dart';
import 'package:donor_app/features/home/domain/entities/home_data_entity.dart';

abstract class HomeRepository {
  Future<ApiResult<HomeDataEntity>> getHomeData();
}
