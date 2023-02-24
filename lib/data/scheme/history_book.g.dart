// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_book.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetHistoryBookCollection on Isar {
  IsarCollection<HistoryBook> get historyBooks => this.collection();
}

const HistoryBookSchema = CollectionSchema(
  name: r'HistoryBook',
  id: 6513141243125523298,
  properties: {
    r'aid': PropertySchema(
      id: 0,
      name: r'aid',
      type: IsarType.string,
    ),
    r'bookName': PropertySchema(
      id: 1,
      name: r'bookName',
      type: IsarType.string,
    ),
    r'cover': PropertySchema(
      id: 2,
      name: r'cover',
      type: IsarType.string,
    ),
    r'lastChapter': PropertySchema(
      id: 3,
      name: r'lastChapter',
      type: IsarType.string,
    ),
    r'updateTime': PropertySchema(
      id: 4,
      name: r'updateTime',
      type: IsarType.string,
    )
  },
  estimateSize: _historyBookEstimateSize,
  serialize: _historyBookSerialize,
  deserialize: _historyBookDeserialize,
  deserializeProp: _historyBookDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _historyBookGetId,
  getLinks: _historyBookGetLinks,
  attach: _historyBookAttach,
  version: '3.0.5',
);

int _historyBookEstimateSize(
  HistoryBook object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.aid.length * 3;
  bytesCount += 3 + object.bookName.length * 3;
  bytesCount += 3 + object.cover.length * 3;
  bytesCount += 3 + object.lastChapter.length * 3;
  bytesCount += 3 + object.updateTime.length * 3;
  return bytesCount;
}

void _historyBookSerialize(
  HistoryBook object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aid);
  writer.writeString(offsets[1], object.bookName);
  writer.writeString(offsets[2], object.cover);
  writer.writeString(offsets[3], object.lastChapter);
  writer.writeString(offsets[4], object.updateTime);
}

HistoryBook _historyBookDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = HistoryBook(
    reader.readString(offsets[1]),
    reader.readString(offsets[0]),
    reader.readString(offsets[2]),
    reader.readString(offsets[4]),
    reader.readString(offsets[3]),
  );
  object.id = id;
  return object;
}

P _historyBookDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _historyBookGetId(HistoryBook object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _historyBookGetLinks(HistoryBook object) {
  return [];
}

void _historyBookAttach(
    IsarCollection<dynamic> col, Id id, HistoryBook object) {
  object.id = id;
}

extension HistoryBookQueryWhereSort
    on QueryBuilder<HistoryBook, HistoryBook, QWhere> {
  QueryBuilder<HistoryBook, HistoryBook, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension HistoryBookQueryWhere
    on QueryBuilder<HistoryBook, HistoryBook, QWhereClause> {
  QueryBuilder<HistoryBook, HistoryBook, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension HistoryBookQueryFilter
    on QueryBuilder<HistoryBook, HistoryBook, QFilterCondition> {
  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> aidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> aidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'aid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> aidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'aid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> aidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'aid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> aidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'aid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> aidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'aid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> aidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'aid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> aidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'aid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> aidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aid',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      aidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aid',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> bookNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      bookNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      bookNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> bookNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bookName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      bookNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      bookNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      bookNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> bookNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bookName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      bookNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookName',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      bookNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bookName',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> coverEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      coverGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> coverLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> coverBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cover',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> coverStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> coverEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> coverContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cover',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> coverMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cover',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> coverIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cover',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      coverIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cover',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastChapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastChapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastChapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastChapter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastChapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastChapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastChapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastChapter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastChapter',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      lastChapterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastChapter',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updateTime',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updateTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateTime',
        value: '',
      ));
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterFilterCondition>
      updateTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updateTime',
        value: '',
      ));
    });
  }
}

extension HistoryBookQueryObject
    on QueryBuilder<HistoryBook, HistoryBook, QFilterCondition> {}

extension HistoryBookQueryLinks
    on QueryBuilder<HistoryBook, HistoryBook, QFilterCondition> {}

extension HistoryBookQuerySortBy
    on QueryBuilder<HistoryBook, HistoryBook, QSortBy> {
  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByAid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByAidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.desc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByBookName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByBookNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.desc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.desc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByLastChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChapter', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByLastChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChapter', Sort.desc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateTime', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> sortByUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateTime', Sort.desc);
    });
  }
}

extension HistoryBookQuerySortThenBy
    on QueryBuilder<HistoryBook, HistoryBook, QSortThenBy> {
  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByAid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByAidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.desc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByBookName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByBookNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.desc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.desc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByLastChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChapter', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByLastChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChapter', Sort.desc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateTime', Sort.asc);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QAfterSortBy> thenByUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateTime', Sort.desc);
    });
  }
}

extension HistoryBookQueryWhereDistinct
    on QueryBuilder<HistoryBook, HistoryBook, QDistinct> {
  QueryBuilder<HistoryBook, HistoryBook, QDistinct> distinctByAid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QDistinct> distinctByBookName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QDistinct> distinctByCover(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cover', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QDistinct> distinctByLastChapter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastChapter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<HistoryBook, HistoryBook, QDistinct> distinctByUpdateTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateTime', caseSensitive: caseSensitive);
    });
  }
}

extension HistoryBookQueryProperty
    on QueryBuilder<HistoryBook, HistoryBook, QQueryProperty> {
  QueryBuilder<HistoryBook, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<HistoryBook, String, QQueryOperations> aidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aid');
    });
  }

  QueryBuilder<HistoryBook, String, QQueryOperations> bookNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookName');
    });
  }

  QueryBuilder<HistoryBook, String, QQueryOperations> coverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cover');
    });
  }

  QueryBuilder<HistoryBook, String, QQueryOperations> lastChapterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastChapter');
    });
  }

  QueryBuilder<HistoryBook, String, QQueryOperations> updateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateTime');
    });
  }
}
