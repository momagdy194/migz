// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'parcels_list_bloc.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ParcelsListEvent {
  BuildContext get context => throw _privateConstructorUsedError;
  bool? get isRefresh => throw _privateConstructorUsedError;
  RefreshController? get controller => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveParcel,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchHistoryParcel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveParcel,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchHistoryParcel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveParcel,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchHistoryParcel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveParcel value) fetchActiveParcel,
    required TResult Function(FetchHistoryParcel value) fetchHistoryParcel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveParcel value)? fetchActiveParcel,
    TResult? Function(FetchHistoryParcel value)? fetchHistoryParcel,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveParcel value)? fetchActiveParcel,
    TResult Function(FetchHistoryParcel value)? fetchHistoryParcel,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ParcelsListEventCopyWith<ParcelsListEvent> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParcelsListEventCopyWith<$Res> {
  factory $ParcelsListEventCopyWith(
          ParcelsListEvent value, $Res Function(ParcelsListEvent) then) =
      _$ParcelsListEventCopyWithImpl<$Res, ParcelsListEvent>;
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class _$ParcelsListEventCopyWithImpl<$Res, $Val extends ParcelsListEvent>
    implements $ParcelsListEventCopyWith<$Res> {
  _$ParcelsListEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_value.copyWith(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      isRefresh: freezed == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as RefreshController?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$FetchActiveParcelCopyWith<$Res>
    implements $ParcelsListEventCopyWith<$Res> {
  factory _$$FetchActiveParcelCopyWith(
          _$FetchActiveParcel value, $Res Function(_$FetchActiveParcel) then) =
      __$$FetchActiveParcelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class __$$FetchActiveParcelCopyWithImpl<$Res>
    extends _$ParcelsListEventCopyWithImpl<$Res, _$FetchActiveParcel>
    implements _$$FetchActiveParcelCopyWith<$Res> {
  __$$FetchActiveParcelCopyWithImpl(
      _$FetchActiveParcel _value, $Res Function(_$FetchActiveParcel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchActiveParcel(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      isRefresh: freezed == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as RefreshController?,
    ));
  }
}

/// @nodoc

class _$FetchActiveParcel implements FetchActiveParcel {
  const _$FetchActiveParcel(
      {required this.context, this.isRefresh, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'ParcelsListEvent.fetchActiveParcel(context: $context, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchActiveParcel &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, isRefresh, controller);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchActiveParcelCopyWith<_$FetchActiveParcel> get copyWith =>
      __$$FetchActiveParcelCopyWithImpl<_$FetchActiveParcel>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveParcel,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchHistoryParcel,
  }) {
    return fetchActiveParcel(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveParcel,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchHistoryParcel,
  }) {
    return fetchActiveParcel?.call(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveParcel,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchHistoryParcel,
    required TResult orElse(),
  }) {
    if (fetchActiveParcel != null) {
      return fetchActiveParcel(context, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveParcel value) fetchActiveParcel,
    required TResult Function(FetchHistoryParcel value) fetchHistoryParcel,
  }) {
    return fetchActiveParcel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveParcel value)? fetchActiveParcel,
    TResult? Function(FetchHistoryParcel value)? fetchHistoryParcel,
  }) {
    return fetchActiveParcel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveParcel value)? fetchActiveParcel,
    TResult Function(FetchHistoryParcel value)? fetchHistoryParcel,
    required TResult orElse(),
  }) {
    if (fetchActiveParcel != null) {
      return fetchActiveParcel(this);
    }
    return orElse();
  }
}

abstract class FetchActiveParcel implements ParcelsListEvent {
  const factory FetchActiveParcel(
      {required final BuildContext context,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchActiveParcel;

  @override
  BuildContext get context;
  @override
  bool? get isRefresh;
  @override
  RefreshController? get controller;
  @override
  @JsonKey(ignore: true)
  _$$FetchActiveParcelCopyWith<_$FetchActiveParcel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$FetchHistoryParcelCopyWith<$Res>
    implements $ParcelsListEventCopyWith<$Res> {
  factory _$$FetchHistoryParcelCopyWith(_$FetchHistoryParcel value,
          $Res Function(_$FetchHistoryParcel) then) =
      __$$FetchHistoryParcelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {BuildContext context, bool? isRefresh, RefreshController? controller});
}

/// @nodoc
class __$$FetchHistoryParcelCopyWithImpl<$Res>
    extends _$ParcelsListEventCopyWithImpl<$Res, _$FetchHistoryParcel>
    implements _$$FetchHistoryParcelCopyWith<$Res> {
  __$$FetchHistoryParcelCopyWithImpl(
      _$FetchHistoryParcel _value, $Res Function(_$FetchHistoryParcel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? context = null,
    Object? isRefresh = freezed,
    Object? controller = freezed,
  }) {
    return _then(_$FetchHistoryParcel(
      context: null == context
          ? _value.context
          : context // ignore: cast_nullable_to_non_nullable
              as BuildContext,
      isRefresh: freezed == isRefresh
          ? _value.isRefresh
          : isRefresh // ignore: cast_nullable_to_non_nullable
              as bool?,
      controller: freezed == controller
          ? _value.controller
          : controller // ignore: cast_nullable_to_non_nullable
              as RefreshController?,
    ));
  }
}

/// @nodoc

class _$FetchHistoryParcel implements FetchHistoryParcel {
  const _$FetchHistoryParcel(
      {required this.context, this.isRefresh, this.controller});

  @override
  final BuildContext context;
  @override
  final bool? isRefresh;
  @override
  final RefreshController? controller;

  @override
  String toString() {
    return 'ParcelsListEvent.fetchHistoryParcel(context: $context, isRefresh: $isRefresh, controller: $controller)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$FetchHistoryParcel &&
            (identical(other.context, context) || other.context == context) &&
            (identical(other.isRefresh, isRefresh) ||
                other.isRefresh == isRefresh) &&
            (identical(other.controller, controller) ||
                other.controller == controller));
  }

  @override
  int get hashCode => Object.hash(runtimeType, context, isRefresh, controller);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$FetchHistoryParcelCopyWith<_$FetchHistoryParcel> get copyWith =>
      __$$FetchHistoryParcelCopyWithImpl<_$FetchHistoryParcel>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchActiveParcel,
    required TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)
        fetchHistoryParcel,
  }) {
    return fetchHistoryParcel(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveParcel,
    TResult? Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchHistoryParcel,
  }) {
    return fetchHistoryParcel?.call(context, isRefresh, controller);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchActiveParcel,
    TResult Function(BuildContext context, bool? isRefresh,
            RefreshController? controller)?
        fetchHistoryParcel,
    required TResult orElse(),
  }) {
    if (fetchHistoryParcel != null) {
      return fetchHistoryParcel(context, isRefresh, controller);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(FetchActiveParcel value) fetchActiveParcel,
    required TResult Function(FetchHistoryParcel value) fetchHistoryParcel,
  }) {
    return fetchHistoryParcel(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(FetchActiveParcel value)? fetchActiveParcel,
    TResult? Function(FetchHistoryParcel value)? fetchHistoryParcel,
  }) {
    return fetchHistoryParcel?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(FetchActiveParcel value)? fetchActiveParcel,
    TResult Function(FetchHistoryParcel value)? fetchHistoryParcel,
    required TResult orElse(),
  }) {
    if (fetchHistoryParcel != null) {
      return fetchHistoryParcel(this);
    }
    return orElse();
  }
}

abstract class FetchHistoryParcel implements ParcelsListEvent {
  const factory FetchHistoryParcel(
      {required final BuildContext context,
      final bool? isRefresh,
      final RefreshController? controller}) = _$FetchHistoryParcel;

  @override
  BuildContext get context;
  @override
  bool? get isRefresh;
  @override
  RefreshController? get controller;
  @override
  @JsonKey(ignore: true)
  _$$FetchHistoryParcelCopyWith<_$FetchHistoryParcel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ParcelsListState {
  bool get isActiveLoading => throw _privateConstructorUsedError;
  bool get isHistoryLoading => throw _privateConstructorUsedError;
  int get totalActiveCount => throw _privateConstructorUsedError;
  List<ParcelOrder> get activeOrders => throw _privateConstructorUsedError;
  List<ParcelOrder> get historyOrders => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ParcelsListStateCopyWith<ParcelsListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ParcelsListStateCopyWith<$Res> {
  factory $ParcelsListStateCopyWith(
          ParcelsListState value, $Res Function(ParcelsListState) then) =
      _$ParcelsListStateCopyWithImpl<$Res, ParcelsListState>;
  @useResult
  $Res call(
      {bool isActiveLoading,
      bool isHistoryLoading,
      int totalActiveCount,
      List<ParcelOrder> activeOrders,
      List<ParcelOrder> historyOrders});
}

/// @nodoc
class _$ParcelsListStateCopyWithImpl<$Res, $Val extends ParcelsListState>
    implements $ParcelsListStateCopyWith<$Res> {
  _$ParcelsListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActiveLoading = null,
    Object? isHistoryLoading = null,
    Object? totalActiveCount = null,
    Object? activeOrders = null,
    Object? historyOrders = null,
  }) {
    return _then(_value.copyWith(
      isActiveLoading: null == isActiveLoading
          ? _value.isActiveLoading
          : isActiveLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isHistoryLoading: null == isHistoryLoading
          ? _value.isHistoryLoading
          : isHistoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      totalActiveCount: null == totalActiveCount
          ? _value.totalActiveCount
          : totalActiveCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeOrders: null == activeOrders
          ? _value.activeOrders
          : activeOrders // ignore: cast_nullable_to_non_nullable
              as List<ParcelOrder>,
      historyOrders: null == historyOrders
          ? _value.historyOrders
          : historyOrders // ignore: cast_nullable_to_non_nullable
              as List<ParcelOrder>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ParcelsListStateCopyWith<$Res>
    implements $ParcelsListStateCopyWith<$Res> {
  factory _$$_ParcelsListStateCopyWith(
          _$_ParcelsListState value, $Res Function(_$_ParcelsListState) then) =
      __$$_ParcelsListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {bool isActiveLoading,
      bool isHistoryLoading,
      int totalActiveCount,
      List<ParcelOrder> activeOrders,
      List<ParcelOrder> historyOrders});
}

/// @nodoc
class __$$_ParcelsListStateCopyWithImpl<$Res>
    extends _$ParcelsListStateCopyWithImpl<$Res, _$_ParcelsListState>
    implements _$$_ParcelsListStateCopyWith<$Res> {
  __$$_ParcelsListStateCopyWithImpl(
      _$_ParcelsListState _value, $Res Function(_$_ParcelsListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? isActiveLoading = null,
    Object? isHistoryLoading = null,
    Object? totalActiveCount = null,
    Object? activeOrders = null,
    Object? historyOrders = null,
  }) {
    return _then(_$_ParcelsListState(
      isActiveLoading: null == isActiveLoading
          ? _value.isActiveLoading
          : isActiveLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      isHistoryLoading: null == isHistoryLoading
          ? _value.isHistoryLoading
          : isHistoryLoading // ignore: cast_nullable_to_non_nullable
              as bool,
      totalActiveCount: null == totalActiveCount
          ? _value.totalActiveCount
          : totalActiveCount // ignore: cast_nullable_to_non_nullable
              as int,
      activeOrders: null == activeOrders
          ? _value._activeOrders
          : activeOrders // ignore: cast_nullable_to_non_nullable
              as List<ParcelOrder>,
      historyOrders: null == historyOrders
          ? _value._historyOrders
          : historyOrders // ignore: cast_nullable_to_non_nullable
              as List<ParcelOrder>,
    ));
  }
}

/// @nodoc

class _$_ParcelsListState implements _ParcelsListState {
  const _$_ParcelsListState(
      {this.isActiveLoading = false,
      this.isHistoryLoading = false,
      this.totalActiveCount = 0,
      final List<ParcelOrder> activeOrders = const [],
      final List<ParcelOrder> historyOrders = const []})
      : _activeOrders = activeOrders,
        _historyOrders = historyOrders;

  @override
  @JsonKey()
  final bool isActiveLoading;
  @override
  @JsonKey()
  final bool isHistoryLoading;
  @override
  @JsonKey()
  final int totalActiveCount;
  final List<ParcelOrder> _activeOrders;
  @override
  @JsonKey()
  List<ParcelOrder> get activeOrders {
    if (_activeOrders is EqualUnmodifiableListView) return _activeOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_activeOrders);
  }

  final List<ParcelOrder> _historyOrders;
  @override
  @JsonKey()
  List<ParcelOrder> get historyOrders {
    if (_historyOrders is EqualUnmodifiableListView) return _historyOrders;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_historyOrders);
  }

  @override
  String toString() {
    return 'ParcelsListState(isActiveLoading: $isActiveLoading, isHistoryLoading: $isHistoryLoading, totalActiveCount: $totalActiveCount, activeOrders: $activeOrders, historyOrders: $historyOrders)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ParcelsListState &&
            (identical(other.isActiveLoading, isActiveLoading) ||
                other.isActiveLoading == isActiveLoading) &&
            (identical(other.isHistoryLoading, isHistoryLoading) ||
                other.isHistoryLoading == isHistoryLoading) &&
            (identical(other.totalActiveCount, totalActiveCount) ||
                other.totalActiveCount == totalActiveCount) &&
            const DeepCollectionEquality()
                .equals(other._activeOrders, _activeOrders) &&
            const DeepCollectionEquality()
                .equals(other._historyOrders, _historyOrders));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      isActiveLoading,
      isHistoryLoading,
      totalActiveCount,
      const DeepCollectionEquality().hash(_activeOrders),
      const DeepCollectionEquality().hash(_historyOrders));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ParcelsListStateCopyWith<_$_ParcelsListState> get copyWith =>
      __$$_ParcelsListStateCopyWithImpl<_$_ParcelsListState>(this, _$identity);
}

abstract class _ParcelsListState implements ParcelsListState {
  const factory _ParcelsListState(
      {final bool isActiveLoading,
      final bool isHistoryLoading,
      final int totalActiveCount,
      final List<ParcelOrder> activeOrders,
      final List<ParcelOrder> historyOrders}) = _$_ParcelsListState;

  @override
  bool get isActiveLoading;
  @override
  bool get isHistoryLoading;
  @override
  int get totalActiveCount;
  @override
  List<ParcelOrder> get activeOrders;
  @override
  List<ParcelOrder> get historyOrders;
  @override
  @JsonKey(ignore: true)
  _$$_ParcelsListStateCopyWith<_$_ParcelsListState> get copyWith =>
      throw _privateConstructorUsedError;
}
