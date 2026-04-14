// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoteListState {

 String? get searchQuery; NoteListFilter get filter; List<NoteModel> get noteList;
/// Create a copy of NoteListState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteListStateCopyWith<NoteListState> get copyWith => _$NoteListStateCopyWithImpl<NoteListState>(this as NoteListState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteListState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.filter, filter) || other.filter == filter)&&const DeepCollectionEquality().equals(other.noteList, noteList));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,filter,const DeepCollectionEquality().hash(noteList));

@override
String toString() {
  return 'NoteListState(searchQuery: $searchQuery, filter: $filter, noteList: $noteList)';
}


}

/// @nodoc
abstract mixin class $NoteListStateCopyWith<$Res>  {
  factory $NoteListStateCopyWith(NoteListState value, $Res Function(NoteListState) _then) = _$NoteListStateCopyWithImpl;
@useResult
$Res call({
 String? searchQuery, NoteListFilter filter, List<NoteModel> noteList
});




}
/// @nodoc
class _$NoteListStateCopyWithImpl<$Res>
    implements $NoteListStateCopyWith<$Res> {
  _$NoteListStateCopyWithImpl(this._self, this._then);

  final NoteListState _self;
  final $Res Function(NoteListState) _then;

/// Create a copy of NoteListState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? searchQuery = freezed,Object? filter = null,Object? noteList = null,}) {
  return _then(_self.copyWith(
searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as NoteListFilter,noteList: null == noteList ? _self.noteList : noteList // ignore: cast_nullable_to_non_nullable
as List<NoteModel>,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteListState].
extension NoteListStatePatterns on NoteListState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteListState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteListState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteListState value)  $default,){
final _that = this;
switch (_that) {
case _NoteListState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteListState value)?  $default,){
final _that = this;
switch (_that) {
case _NoteListState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? searchQuery,  NoteListFilter filter,  List<NoteModel> noteList)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteListState() when $default != null:
return $default(_that.searchQuery,_that.filter,_that.noteList);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? searchQuery,  NoteListFilter filter,  List<NoteModel> noteList)  $default,) {final _that = this;
switch (_that) {
case _NoteListState():
return $default(_that.searchQuery,_that.filter,_that.noteList);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? searchQuery,  NoteListFilter filter,  List<NoteModel> noteList)?  $default,) {final _that = this;
switch (_that) {
case _NoteListState() when $default != null:
return $default(_that.searchQuery,_that.filter,_that.noteList);case _:
  return null;

}
}

}

/// @nodoc


class _NoteListState implements NoteListState {
  const _NoteListState({this.searchQuery, this.filter = NoteListFilter.all, final  List<NoteModel> noteList = const []}): _noteList = noteList;
  

@override final  String? searchQuery;
@override@JsonKey() final  NoteListFilter filter;
 final  List<NoteModel> _noteList;
@override@JsonKey() List<NoteModel> get noteList {
  if (_noteList is EqualUnmodifiableListView) return _noteList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_noteList);
}


/// Create a copy of NoteListState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteListStateCopyWith<_NoteListState> get copyWith => __$NoteListStateCopyWithImpl<_NoteListState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteListState&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery)&&(identical(other.filter, filter) || other.filter == filter)&&const DeepCollectionEquality().equals(other._noteList, _noteList));
}


@override
int get hashCode => Object.hash(runtimeType,searchQuery,filter,const DeepCollectionEquality().hash(_noteList));

@override
String toString() {
  return 'NoteListState(searchQuery: $searchQuery, filter: $filter, noteList: $noteList)';
}


}

/// @nodoc
abstract mixin class _$NoteListStateCopyWith<$Res> implements $NoteListStateCopyWith<$Res> {
  factory _$NoteListStateCopyWith(_NoteListState value, $Res Function(_NoteListState) _then) = __$NoteListStateCopyWithImpl;
@override @useResult
$Res call({
 String? searchQuery, NoteListFilter filter, List<NoteModel> noteList
});




}
/// @nodoc
class __$NoteListStateCopyWithImpl<$Res>
    implements _$NoteListStateCopyWith<$Res> {
  __$NoteListStateCopyWithImpl(this._self, this._then);

  final _NoteListState _self;
  final $Res Function(_NoteListState) _then;

/// Create a copy of NoteListState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? searchQuery = freezed,Object? filter = null,Object? noteList = null,}) {
  return _then(_NoteListState(
searchQuery: freezed == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String?,filter: null == filter ? _self.filter : filter // ignore: cast_nullable_to_non_nullable
as NoteListFilter,noteList: null == noteList ? _self._noteList : noteList // ignore: cast_nullable_to_non_nullable
as List<NoteModel>,
  ));
}


}

// dart format on
