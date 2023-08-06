// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:test_app/features/home/data/repository/home_repository_impl.dart'
    as _i5;
import 'package:test_app/features/home/data/source/home_source.dart' as _i3;
import 'package:test_app/features/home/domain/repository/home_repository.dart'
    as _i4;
import 'package:test_app/features/home/presentation/bloc/home_bloc.dart' as _i6;

extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.HomeSource>(() => _i3.HomeSource());
    gh.factory<_i4.HomeRepository>(
        () => _i5.HomeRepositoryImpl(gh<_i3.HomeSource>()));
    gh.factory<_i6.HomeBloc>(() => _i6.HomeBloc(gh<_i4.HomeRepository>()));
    return this;
  }
}
