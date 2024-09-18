// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'search_jewelry_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

SearchJewelryModel _$SearchJewelryModelFromJson(Map<String, dynamic> json) {
  return _SearchJewelryModel.fromJson(json);
}

/// @nodoc
mixin _$SearchJewelryModel {
  List<JewelryModel> get results => throw _privateConstructorUsedError;
  int get page => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  SearchFacets get facets => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchJewelryModelCopyWith<SearchJewelryModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchJewelryModelCopyWith<$Res> {
  factory $SearchJewelryModelCopyWith(
          SearchJewelryModel value, $Res Function(SearchJewelryModel) then) =
      _$SearchJewelryModelCopyWithImpl<$Res, SearchJewelryModel>;
  @useResult
  $Res call(
      {List<JewelryModel> results,
      int page,
      int totalPages,
      int totalCount,
      SearchFacets facets});

  $SearchFacetsCopyWith<$Res> get facets;
}

/// @nodoc
class _$SearchJewelryModelCopyWithImpl<$Res, $Val extends SearchJewelryModel>
    implements $SearchJewelryModelCopyWith<$Res> {
  _$SearchJewelryModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? page = null,
    Object? totalPages = null,
    Object? totalCount = null,
    Object? facets = null,
  }) {
    return _then(_value.copyWith(
      results: null == results
          ? _value.results
          : results // ignore: cast_nullable_to_non_nullable
              as List<JewelryModel>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      facets: null == facets
          ? _value.facets
          : facets // ignore: cast_nullable_to_non_nullable
              as SearchFacets,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SearchFacetsCopyWith<$Res> get facets {
    return $SearchFacetsCopyWith<$Res>(_value.facets, (value) {
      return _then(_value.copyWith(facets: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$SearchJewelryModelImplCopyWith<$Res>
    implements $SearchJewelryModelCopyWith<$Res> {
  factory _$$SearchJewelryModelImplCopyWith(_$SearchJewelryModelImpl value,
          $Res Function(_$SearchJewelryModelImpl) then) =
      __$$SearchJewelryModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {List<JewelryModel> results,
      int page,
      int totalPages,
      int totalCount,
      SearchFacets facets});

  @override
  $SearchFacetsCopyWith<$Res> get facets;
}

/// @nodoc
class __$$SearchJewelryModelImplCopyWithImpl<$Res>
    extends _$SearchJewelryModelCopyWithImpl<$Res, _$SearchJewelryModelImpl>
    implements _$$SearchJewelryModelImplCopyWith<$Res> {
  __$$SearchJewelryModelImplCopyWithImpl(_$SearchJewelryModelImpl _value,
      $Res Function(_$SearchJewelryModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? results = null,
    Object? page = null,
    Object? totalPages = null,
    Object? totalCount = null,
    Object? facets = null,
  }) {
    return _then(_$SearchJewelryModelImpl(
      results: null == results
          ? _value._results
          : results // ignore: cast_nullable_to_non_nullable
              as List<JewelryModel>,
      page: null == page
          ? _value.page
          : page // ignore: cast_nullable_to_non_nullable
              as int,
      totalPages: null == totalPages
          ? _value.totalPages
          : totalPages // ignore: cast_nullable_to_non_nullable
              as int,
      totalCount: null == totalCount
          ? _value.totalCount
          : totalCount // ignore: cast_nullable_to_non_nullable
              as int,
      facets: null == facets
          ? _value.facets
          : facets // ignore: cast_nullable_to_non_nullable
              as SearchFacets,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchJewelryModelImpl implements _SearchJewelryModel {
  _$SearchJewelryModelImpl(
      {required final List<JewelryModel> results,
      required this.page,
      required this.totalPages,
      required this.totalCount,
      required this.facets})
      : _results = results;

  factory _$SearchJewelryModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchJewelryModelImplFromJson(json);

  final List<JewelryModel> _results;
  @override
  List<JewelryModel> get results {
    if (_results is EqualUnmodifiableListView) return _results;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_results);
  }

  @override
  final int page;
  @override
  final int totalPages;
  @override
  final int totalCount;
  @override
  final SearchFacets facets;

  @override
  String toString() {
    return 'SearchJewelryModel(results: $results, page: $page, totalPages: $totalPages, totalCount: $totalCount, facets: $facets)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchJewelryModelImpl &&
            const DeepCollectionEquality().equals(other._results, _results) &&
            (identical(other.page, page) || other.page == page) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.facets, facets) || other.facets == facets));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_results),
      page,
      totalPages,
      totalCount,
      facets);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchJewelryModelImplCopyWith<_$SearchJewelryModelImpl> get copyWith =>
      __$$SearchJewelryModelImplCopyWithImpl<_$SearchJewelryModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchJewelryModelImplToJson(
      this,
    );
  }
}

abstract class _SearchJewelryModel implements SearchJewelryModel {
  factory _SearchJewelryModel(
      {required final List<JewelryModel> results,
      required final int page,
      required final int totalPages,
      required final int totalCount,
      required final SearchFacets facets}) = _$SearchJewelryModelImpl;

  factory _SearchJewelryModel.fromJson(Map<String, dynamic> json) =
      _$SearchJewelryModelImpl.fromJson;

  @override
  List<JewelryModel> get results;
  @override
  int get page;
  @override
  int get totalPages;
  @override
  int get totalCount;
  @override
  SearchFacets get facets;
  @override
  @JsonKey(ignore: true)
  _$$SearchJewelryModelImplCopyWith<_$SearchJewelryModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

SearchFacets _$SearchFacetsFromJson(Map<String, dynamic> json) {
  return _SearchFacets.fromJson(json);
}

/// @nodoc
mixin _$SearchFacets {
  List<CategoryFacet> get categories => throw _privateConstructorUsedError;
  List<PriceRangeFacet> get priceRange => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SearchFacetsCopyWith<SearchFacets> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SearchFacetsCopyWith<$Res> {
  factory $SearchFacetsCopyWith(
          SearchFacets value, $Res Function(SearchFacets) then) =
      _$SearchFacetsCopyWithImpl<$Res, SearchFacets>;
  @useResult
  $Res call({List<CategoryFacet> categories, List<PriceRangeFacet> priceRange});
}

/// @nodoc
class _$SearchFacetsCopyWithImpl<$Res, $Val extends SearchFacets>
    implements $SearchFacetsCopyWith<$Res> {
  _$SearchFacetsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? priceRange = null,
  }) {
    return _then(_value.copyWith(
      categories: null == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryFacet>,
      priceRange: null == priceRange
          ? _value.priceRange
          : priceRange // ignore: cast_nullable_to_non_nullable
              as List<PriceRangeFacet>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SearchFacetsImplCopyWith<$Res>
    implements $SearchFacetsCopyWith<$Res> {
  factory _$$SearchFacetsImplCopyWith(
          _$SearchFacetsImpl value, $Res Function(_$SearchFacetsImpl) then) =
      __$$SearchFacetsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<CategoryFacet> categories, List<PriceRangeFacet> priceRange});
}

/// @nodoc
class __$$SearchFacetsImplCopyWithImpl<$Res>
    extends _$SearchFacetsCopyWithImpl<$Res, _$SearchFacetsImpl>
    implements _$$SearchFacetsImplCopyWith<$Res> {
  __$$SearchFacetsImplCopyWithImpl(
      _$SearchFacetsImpl _value, $Res Function(_$SearchFacetsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = null,
    Object? priceRange = null,
  }) {
    return _then(_$SearchFacetsImpl(
      categories: null == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<CategoryFacet>,
      priceRange: null == priceRange
          ? _value._priceRange
          : priceRange // ignore: cast_nullable_to_non_nullable
              as List<PriceRangeFacet>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SearchFacetsImpl implements _SearchFacets {
  _$SearchFacetsImpl(
      {required final List<CategoryFacet> categories,
      required final List<PriceRangeFacet> priceRange})
      : _categories = categories,
        _priceRange = priceRange;

  factory _$SearchFacetsImpl.fromJson(Map<String, dynamic> json) =>
      _$$SearchFacetsImplFromJson(json);

  final List<CategoryFacet> _categories;
  @override
  List<CategoryFacet> get categories {
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_categories);
  }

  final List<PriceRangeFacet> _priceRange;
  @override
  List<PriceRangeFacet> get priceRange {
    if (_priceRange is EqualUnmodifiableListView) return _priceRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_priceRange);
  }

  @override
  String toString() {
    return 'SearchFacets(categories: $categories, priceRange: $priceRange)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SearchFacetsImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            const DeepCollectionEquality()
                .equals(other._priceRange, _priceRange));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      const DeepCollectionEquality().hash(_priceRange));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SearchFacetsImplCopyWith<_$SearchFacetsImpl> get copyWith =>
      __$$SearchFacetsImplCopyWithImpl<_$SearchFacetsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SearchFacetsImplToJson(
      this,
    );
  }
}

abstract class _SearchFacets implements SearchFacets {
  factory _SearchFacets(
      {required final List<CategoryFacet> categories,
      required final List<PriceRangeFacet> priceRange}) = _$SearchFacetsImpl;

  factory _SearchFacets.fromJson(Map<String, dynamic> json) =
      _$SearchFacetsImpl.fromJson;

  @override
  List<CategoryFacet> get categories;
  @override
  List<PriceRangeFacet> get priceRange;
  @override
  @JsonKey(ignore: true)
  _$$SearchFacetsImplCopyWith<_$SearchFacetsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CategoryFacet _$CategoryFacetFromJson(Map<String, dynamic> json) {
  return _CategoryFacet.fromJson(json);
}

/// @nodoc
mixin _$CategoryFacet {
  int get count => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryFacetCopyWith<CategoryFacet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryFacetCopyWith<$Res> {
  factory $CategoryFacetCopyWith(
          CategoryFacet value, $Res Function(CategoryFacet) then) =
      _$CategoryFacetCopyWithImpl<$Res, CategoryFacet>;
  @useResult
  $Res call({int count, String category});
}

/// @nodoc
class _$CategoryFacetCopyWithImpl<$Res, $Val extends CategoryFacet>
    implements $CategoryFacetCopyWith<$Res> {
  _$CategoryFacetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? category = null,
  }) {
    return _then(_value.copyWith(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryFacetImplCopyWith<$Res>
    implements $CategoryFacetCopyWith<$Res> {
  factory _$$CategoryFacetImplCopyWith(
          _$CategoryFacetImpl value, $Res Function(_$CategoryFacetImpl) then) =
      __$$CategoryFacetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int count, String category});
}

/// @nodoc
class __$$CategoryFacetImplCopyWithImpl<$Res>
    extends _$CategoryFacetCopyWithImpl<$Res, _$CategoryFacetImpl>
    implements _$$CategoryFacetImplCopyWith<$Res> {
  __$$CategoryFacetImplCopyWithImpl(
      _$CategoryFacetImpl _value, $Res Function(_$CategoryFacetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = null,
    Object? category = null,
  }) {
    return _then(_$CategoryFacetImpl(
      count: null == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryFacetImpl implements _CategoryFacet {
  _$CategoryFacetImpl({required this.count, required this.category});

  factory _$CategoryFacetImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryFacetImplFromJson(json);

  @override
  final int count;
  @override
  final String category;

  @override
  String toString() {
    return 'CategoryFacet(count: $count, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryFacetImpl &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, count, category);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryFacetImplCopyWith<_$CategoryFacetImpl> get copyWith =>
      __$$CategoryFacetImplCopyWithImpl<_$CategoryFacetImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryFacetImplToJson(
      this,
    );
  }
}

abstract class _CategoryFacet implements CategoryFacet {
  factory _CategoryFacet(
      {required final int count,
      required final String category}) = _$CategoryFacetImpl;

  factory _CategoryFacet.fromJson(Map<String, dynamic> json) =
      _$CategoryFacetImpl.fromJson;

  @override
  int get count;
  @override
  String get category;
  @override
  @JsonKey(ignore: true)
  _$$CategoryFacetImplCopyWith<_$CategoryFacetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PriceRangeFacet _$PriceRangeFacetFromJson(Map<String, dynamic> json) {
  return _PriceRangeFacet.fromJson(json);
}

/// @nodoc
mixin _$PriceRangeFacet {
  double get min => throw _privateConstructorUsedError;
  double get max => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceRangeFacetCopyWith<PriceRangeFacet> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceRangeFacetCopyWith<$Res> {
  factory $PriceRangeFacetCopyWith(
          PriceRangeFacet value, $Res Function(PriceRangeFacet) then) =
      _$PriceRangeFacetCopyWithImpl<$Res, PriceRangeFacet>;
  @useResult
  $Res call({double min, double max});
}

/// @nodoc
class _$PriceRangeFacetCopyWithImpl<$Res, $Val extends PriceRangeFacet>
    implements $PriceRangeFacetCopyWith<$Res> {
  _$PriceRangeFacetCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_value.copyWith(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PriceRangeFacetImplCopyWith<$Res>
    implements $PriceRangeFacetCopyWith<$Res> {
  factory _$$PriceRangeFacetImplCopyWith(_$PriceRangeFacetImpl value,
          $Res Function(_$PriceRangeFacetImpl) then) =
      __$$PriceRangeFacetImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({double min, double max});
}

/// @nodoc
class __$$PriceRangeFacetImplCopyWithImpl<$Res>
    extends _$PriceRangeFacetCopyWithImpl<$Res, _$PriceRangeFacetImpl>
    implements _$$PriceRangeFacetImplCopyWith<$Res> {
  __$$PriceRangeFacetImplCopyWithImpl(
      _$PriceRangeFacetImpl _value, $Res Function(_$PriceRangeFacetImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? min = null,
    Object? max = null,
  }) {
    return _then(_$PriceRangeFacetImpl(
      min: null == min
          ? _value.min
          : min // ignore: cast_nullable_to_non_nullable
              as double,
      max: null == max
          ? _value.max
          : max // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PriceRangeFacetImpl implements _PriceRangeFacet {
  _$PriceRangeFacetImpl({required this.min, required this.max});

  factory _$PriceRangeFacetImpl.fromJson(Map<String, dynamic> json) =>
      _$$PriceRangeFacetImplFromJson(json);

  @override
  final double min;
  @override
  final double max;

  @override
  String toString() {
    return 'PriceRangeFacet(min: $min, max: $max)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PriceRangeFacetImpl &&
            (identical(other.min, min) || other.min == min) &&
            (identical(other.max, max) || other.max == max));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, min, max);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$PriceRangeFacetImplCopyWith<_$PriceRangeFacetImpl> get copyWith =>
      __$$PriceRangeFacetImplCopyWithImpl<_$PriceRangeFacetImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PriceRangeFacetImplToJson(
      this,
    );
  }
}

abstract class _PriceRangeFacet implements PriceRangeFacet {
  factory _PriceRangeFacet(
      {required final double min,
      required final double max}) = _$PriceRangeFacetImpl;

  factory _PriceRangeFacet.fromJson(Map<String, dynamic> json) =
      _$PriceRangeFacetImpl.fromJson;

  @override
  double get min;
  @override
  double get max;
  @override
  @JsonKey(ignore: true)
  _$$PriceRangeFacetImplCopyWith<_$PriceRangeFacetImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
