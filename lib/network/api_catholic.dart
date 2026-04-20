import 'package:dio/dio.dart';
import 'package:ztv/models/series_model.dart';
import 'package:ztv/utils/strings_app.dart';
class ApiCatholic{
  Dio dio = Dio();

  Future<List<SeriesDao>> getSeries(int idSerie) async{
    final response = await dio.get('${StringsApp.url_base}/json/categories/$idSerie.json');
    final res = response.data('series') as List;
    return res.map((series)=>SeriesDao.fromMap(series)).toList();
  }
}