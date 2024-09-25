// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_product_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchProductModel _$SearchProductModelFromJson(Map<String, dynamic> json) {
  return _SearchProductModel.fromJson(json);
}

/// @nodoc
mixin _$SearchProductModel {
  List<ProductModel> get results => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchProductModelCopyWith<SearchProductModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchProductModelCopyWith<$Res> {
  factory $SearchProductModelCopyWith(
          SearchProductModel value, $Res Function(SearchProductModel) then) =
      _$SearchProductModelCopyWithImpl<$Res, SearchProductModel>;
  @useResult
  $Res call({List<ProductModel> results});
}

/// @nodoc
class _$SearchProductModelCopyWithImpl<$Res, $Val extends SearchProductModel>
    implements $SearchProductModelCopyWith<$Res> {
  _$SearchProductModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchProductModelImplCopyWith<$Res>
    implements $SearchProductModelCopyWith<$Res> {
  factory _$$SearchProductModelImplCopyWith(_$SearchProductModelImpl value,
          $Res Function(_$SearchProductModelImpl) then) =
      __$$SearchProductModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ProductModel> results});
}

/// @nodoc
class __$$SearchProductModelImplCopyWithImpl<$Res>
    extends _$SearchProductModelCopyWithImpl<$Res, _$SearchProductModelImpl>
    implements _$$SearchProductModelImplCopyWith<$Res> {
  __$$SearchProductModelImplCopyWithImpl(_$SearchProductModelImpl _value,
      $Res Function(_$SearchProductModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
  }) {
    return _then(_$SearchProductModelImpl(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<ProductModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchProductModelImpl implements _SearchProductModel {
  _$SearchProductModelImpl({required final List<ProductModel> results})
      : _results = results;

  factory _$SearchProductModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchProductModelImplFromJson(json);

  final List<ProductModel> _results;
  @override
  List<ProductModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  String toString() {
    return 'SearchProductModel(results: $results)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchProductModelImpl &&
            const DeepCollectionEquality().equals(other._results, _results));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_results));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchProductModelImplCopyWith<_$SearchProductModelImpl> get copyWith =>
      __$$SearchProductModelImplCopyWithImpl<_$SearchProductModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchProductModelImplToJson(
      this,
    );
  }
}

abstract class _SearchProductModel implements SearchProductModel {
  factory _SearchProductModel({required final List<ProductModel> results}) =
      _$SearchProductModelImpl;

  factory _SearchProductModel.fromJson(Map<String, dynamic> json) =
      _$SearchProductModelImpl.fromJson;

  @override
  List<ProductModel> get results;
  @override
  @JsonKey(ignore: true)
  _$$SearchProductModelImplCopyWith<_$SearchProductModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
