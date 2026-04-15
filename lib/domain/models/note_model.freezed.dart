// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'note_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$NoteModel {

 int? get id; String get title; String? get content; DateTime get createdAt; DateTime? get updatedAt; bool get isHidden;// 숨김 속성 추가
 bool get isFavorite; List<TagModel>? get tags;
/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NoteModelCopyWith<NoteModel> get copyWith => _$NoteModelCopyWithImpl<NoteModel>(this as NoteModel, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NoteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&const DeepCollectionEquality().equals(other.tags, tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,content,createdAt,updatedAt,isHidden,isFavorite,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'NoteModel(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, isHidden: $isHidden, isFavorite: $isFavorite, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $NoteModelCopyWith<$Res>  {
  factory $NoteModelCopyWith(NoteModel value, $Res Function(NoteModel) _then) = _$NoteModelCopyWithImpl;
@useResult
$Res call({
 int? id, String title, String? content, DateTime createdAt, DateTime? updatedAt, bool isHidden, bool isFavorite, List<TagModel>? tags
});




}
/// @nodoc
class _$NoteModelCopyWithImpl<$Res>
    implements $NoteModelCopyWith<$Res> {
  _$NoteModelCopyWithImpl(this._self, this._then);

  final NoteModel _self;
  final $Res Function(NoteModel) _then;

/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = null,Object? content = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? isHidden = null,Object? isFavorite = null,Object? tags = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,tags: freezed == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagModel>?,
  ));
}

}


/// Adds pattern-matching-related methods to [NoteModel].
extension NoteModelPatterns on NoteModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NoteModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NoteModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NoteModel value)  $default,){
final _that = this;
switch (_that) {
case _NoteModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NoteModel value)?  $default,){
final _that = this;
switch (_that) {
case _NoteModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int? id,  String title,  String? content,  DateTime createdAt,  DateTime? updatedAt,  bool isHidden,  bool isFavorite,  List<TagModel>? tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NoteModel() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.isHidden,_that.isFavorite,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int? id,  String title,  String? content,  DateTime createdAt,  DateTime? updatedAt,  bool isHidden,  bool isFavorite,  List<TagModel>? tags)  $default,) {final _that = this;
switch (_that) {
case _NoteModel():
return $default(_that.id,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.isHidden,_that.isFavorite,_that.tags);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int? id,  String title,  String? content,  DateTime createdAt,  DateTime? updatedAt,  bool isHidden,  bool isFavorite,  List<TagModel>? tags)?  $default,) {final _that = this;
switch (_that) {
case _NoteModel() when $default != null:
return $default(_that.id,_that.title,_that.content,_that.createdAt,_that.updatedAt,_that.isHidden,_that.isFavorite,_that.tags);case _:
  return null;

}
}

}

/// @nodoc


class _NoteModel implements NoteModel {
  const _NoteModel({this.id, required this.title, this.content, required this.createdAt, this.updatedAt, this.isHidden = false, this.isFavorite = false, final  List<TagModel>? tags}): _tags = tags;
  

@override final  int? id;
@override final  String title;
@override final  String? content;
@override final  DateTime createdAt;
@override final  DateTime? updatedAt;
@override@JsonKey() final  bool isHidden;
// 숨김 속성 추가
@override@JsonKey() final  bool isFavorite;
 final  List<TagModel>? _tags;
@override List<TagModel>? get tags {
  final value = _tags;
  if (value == null) return null;
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NoteModelCopyWith<_NoteModel> get copyWith => __$NoteModelCopyWithImpl<_NoteModel>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NoteModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.isHidden, isHidden) || other.isHidden == isHidden)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&const DeepCollectionEquality().equals(other._tags, _tags));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,content,createdAt,updatedAt,isHidden,isFavorite,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'NoteModel(id: $id, title: $title, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, isHidden: $isHidden, isFavorite: $isFavorite, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$NoteModelCopyWith<$Res> implements $NoteModelCopyWith<$Res> {
  factory _$NoteModelCopyWith(_NoteModel value, $Res Function(_NoteModel) _then) = __$NoteModelCopyWithImpl;
@override @useResult
$Res call({
 int? id, String title, String? content, DateTime createdAt, DateTime? updatedAt, bool isHidden, bool isFavorite, List<TagModel>? tags
});




}
/// @nodoc
class __$NoteModelCopyWithImpl<$Res>
    implements _$NoteModelCopyWith<$Res> {
  __$NoteModelCopyWithImpl(this._self, this._then);

  final _NoteModel _self;
  final $Res Function(_NoteModel) _then;

/// Create a copy of NoteModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = null,Object? content = freezed,Object? createdAt = null,Object? updatedAt = freezed,Object? isHidden = null,Object? isFavorite = null,Object? tags = freezed,}) {
  return _then(_NoteModel(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int?,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,isHidden: null == isHidden ? _self.isHidden : isHidden // ignore: cast_nullable_to_non_nullable
as bool,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,tags: freezed == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<TagModel>?,
  ));
}


}

// dart format on
