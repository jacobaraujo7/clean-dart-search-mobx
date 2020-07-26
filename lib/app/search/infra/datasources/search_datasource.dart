import 'package:clean_dart_github_search_mobx/app/search/infra/models/result_model.dart';

abstract class SearchDatasource {
  Future<List<ResultModel>> searchText(String textSearch);
}
