// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_detail_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoteDetailState {

 NoteModel get note; bool get isLoading; bool get isDeleted;
/// Create a copy of NoteDetailState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteDetailStateCopyWith<NoteDetailState> get copyWith => _$NoteDetailStateCopyWithImpl<NoteDetailState>(this as NoteDetailState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteDetailState&&(identical(other.note, note) || other.note == note)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,note,isLoading,isDeleted);

@override
String toString() {
  return 'NoteDetailState(note: $note, isLoading: $isLoading, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class $NoteDetailStateCopyWith<$Res>  {
  factory $NoteDetailStateCopyWith(NoteDetailState value, $Res Function(NoteDetailState) _then) = _$NoteDetailStateCopyWithImpl;
@useResult
$Res call({
 NoteModel note, bool isLoading, bool isDeleted
});


$NoteModelCopyWith<$Res> get note;

}
/// @nodoc
class _$NoteDetailStateCopyWithImpl<$Res>
    implements $NoteDetailStateCopyWith<$Res> {
  _$NoteDetailStateCopyWithImpl(this._self, this._then);

  final NoteDetailState _self;
  final $Res Function(NoteDetailState) _then;

/// Create a copy of NoteDetailState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? note = null,Object? isLoading = null,Object? isDeleted = null,}) {
  return _then(_self.copyWith(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as NoteModel,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of NoteDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteModelCopyWith<$Res> get note {
  
  return $NoteModelCopyWith<$Res>(_self.note, (value) {
    return _then(_self.copyWith(note: value));
  });
}
}


/// Adds pattern-matching-related methods to [NoteDetailState].
extension NoteDetailStatePatterns on NoteDetailState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteDetailState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteDetailState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteDetailState value)  $default,){
final _that = this;
switch (_that) {
case _NoteDetailState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteDetailState value)?  $default,){
final _that = this;
switch (_that) {
case _NoteDetailState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( NoteModel note,  bool isLoading,  bool isDeleted)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteDetailState() when $default != null:
return $default(_that.note,_that.isLoading,_that.isDeleted);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( NoteModel note,  bool isLoading,  bool isDeleted)  $default,) {final _that = this;
switch (_that) {
case _NoteDetailState():
return $default(_that.note,_that.isLoading,_that.isDeleted);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( NoteModel note,  bool isLoading,  bool isDeleted)?  $default,) {final _that = this;
switch (_that) {
case _NoteDetailState() when $default != null:
return $default(_that.note,_that.isLoading,_that.isDeleted);case _:
  return null;

}
}

}

/// @nodoc


class _NoteDetailState extends NoteDetailState {
  const _NoteDetailState({required this.note, this.isLoading = false, this.isDeleted = false}): super._();
  

@override final  NoteModel note;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isDeleted;

/// Create a copy of NoteDetailState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteDetailStateCopyWith<_NoteDetailState> get copyWith => __$NoteDetailStateCopyWithImpl<_NoteDetailState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteDetailState&&(identical(other.note, note) || other.note == note)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isDeleted, isDeleted) || other.isDeleted == isDeleted));
}


@override
int get hashCode => Object.hash(runtimeType,note,isLoading,isDeleted);

@override
String toString() {
  return 'NoteDetailState(note: $note, isLoading: $isLoading, isDeleted: $isDeleted)';
}


}

/// @nodoc
abstract mixin class _$NoteDetailStateCopyWith<$Res> implements $NoteDetailStateCopyWith<$Res> {
  factory _$NoteDetailStateCopyWith(_NoteDetailState value, $Res Function(_NoteDetailState) _then) = __$NoteDetailStateCopyWithImpl;
@override @useResult
$Res call({
 NoteModel note, bool isLoading, bool isDeleted
});


@override $NoteModelCopyWith<$Res> get note;

}
/// @nodoc
class __$NoteDetailStateCopyWithImpl<$Res>
    implements _$NoteDetailStateCopyWith<$Res> {
  __$NoteDetailStateCopyWithImpl(this._self, this._then);

  final _NoteDetailState _self;
  final $Res Function(_NoteDetailState) _then;

/// Create a copy of NoteDetailState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? note = null,Object? isLoading = null,Object? isDeleted = null,}) {
  return _then(_NoteDetailState(
note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as NoteModel,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isDeleted: null == isDeleted ? _self.isDeleted : isDeleted // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of NoteDetailState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NoteModelCopyWith<$Res> get note {
  
  return $NoteModelCopyWith<$Res>(_self.note, (value) {
    return _then(_self.copyWith(note: value));
  });
}
}

// dart format on
