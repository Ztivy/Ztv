import 'package:dio/dio.dart';
import 'package:async/async.dart';
import 'package:ztv/models/series_model.dart';
import 'package:ztv/utils/strings_app.dart';
class ApiCatholic{
  Dio dio = Dio();

  Future<List<SeriesDao>> getSeries(int idSerie) async{
    final response = await dio.get('${StringsApp.url_base}/json/categories/$idSerie.json');
    final res = response.data('series') as List;
    return res.map((series)=>SeriesDao.fromMap(series)).toList();
  }

  Future <List<List<SeriesDao>>> getAllCategories() async{
    final FutureGroup<List<SeriesDao>> futureGroup = FutureGroup();
    futureGroup.add(getSeries(2));
    futureGroup.add(getSeries(3));
    futureGroup.add(getSeries(4));
    futureGroup.add(getSeries(5));
    futureGroup.close();

    final List<List<SeriesDao>> results = await futureGroup.future;
    return results;
  }
}