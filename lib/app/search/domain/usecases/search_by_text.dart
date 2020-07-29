import 'package:clean_dart_github_search_mobx/app/search/domain/entities/result.dart';
import 'package:clean_dart_github_search_mobx/app/search/domain/errors/erros.dart';
import 'package:clean_dart_github_search_mobx/app/search/domain/repositories/search_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_modular/flutter_modular.dart';
part 'search_by_text.g.dart';

mixin SearchByText {
  Future<Either<Failure, List<Result>>> call(String textSearch);
}

@Injectable(singleton: false)
class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<Failure, List<Result>>> call(String textSearch) async {
    var option = optionOf(textSearch);

    return option.fold(() => Left(InvalidSearchText()), (text) async {
      if (text.isNotEmpty) {
        var result = await repository.getUsers(text);
        return result.fold(
            (l) => left(l), (r) => r.isEmpty ? left(EmptyList()) : right(r));
      } else {
        return left(EmptyList());
      }
    });
  }
}
