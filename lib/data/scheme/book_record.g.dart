// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book_record.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetBookRecordCollection on Isar {
  IsarCollection<BookRecord> get bookRecords => this.collection();
}

const BookRecordSchema = CollectionSchema(
  name: r'BookRecord',
  id: 1732420921406462071,
  properties: {
    r'aid': PropertySchema(
      id: 0,
      name: r'aid',
      type: IsarType.string,
    ),
    r'cfi': PropertySchema(
      id: 1,
      name: r'cfi',
      type: IsarType.string,
    ),
    r'chapterIndex': PropertySchema(
      id: 2,
      name: r'chapterIndex',
      type: IsarType.long,
    ),
    r'pageIndex': PropertySchema(
      id: 3,
      name: r'pageIndex',
      type: IsarType.long,
    )
  },
  estimateSize: _bookRecordEstimateSize,
  serialize: _bookRecordSerialize,
  deserialize: _bookRecordDeserialize,
  deserializeProp: _bookRecordDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _bookRecordGetId,
  getLinks: _bookRecordGetLinks,
  attach: _bookRecordAttach,
  version: '3.0.5',
);

int _bookRecordEstimateSize(
  BookRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.aid.length * 3;
  {
    final value = object.cfi;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _bookRecordSerialize(
  BookRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aid);
  writer.writeString(offsets[1], object.cfi);
  writer.writeLong(offsets[2], object.chapterIndex);
  writer.writeLong(offsets[3], object.pageIndex);
}

BookRecord _bookRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = BookRecord();
  object.aid = reader.readString(offsets[0]);
  object.cfi = reader.readStringOrNull(offsets[1]);
  object.chapterIndex = reader.readLong(offsets[2]);
  object.id = id;
  object.pageIndex = reader.readLong(offsets[3]);
  return object;
}

P _bookRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readLong(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _bookRecordGetId(BookRecord object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _bookRecordGetLinks(BookRecord object) {
  return [];
}

void _bookRecordAttach(IsarCollection<dynamic> col, Id id, BookRecord object) {
  object.id = id;
}

extension BookRecordQueryWhereSort
    on QueryBuilder<BookRecord, BookRecord, QWhere> {
  QueryBuilder<BookRecord, BookRecord, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BookRecordQueryWhere
    on QueryBuilder<BookRecord, BookRecord, QWhereClause> {
  QueryBuilder<BookRecord, BookRecord, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<BookRecord, BookRecord, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterWhereClause> idBetween(
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

extension BookRecordQueryFilter
    on QueryBuilder<BookRecord, BookRecord, QFilterCondition> {
  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidEqualTo(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidGreaterThan(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidLessThan(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidBetween(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidStartsWith(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidEndsWith(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidContains(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidMatches(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aid',
        value: '',
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> aidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aid',
        value: '',
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cfi',
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cfi',
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cfi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cfi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cfi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cfi',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cfi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cfi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cfi',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cfi',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cfi',
        value: '',
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> cfiIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cfi',
        value: '',
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition>
      chapterIndexEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chapterIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition>
      chapterIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chapterIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition>
      chapterIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chapterIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition>
      chapterIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chapterIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> idBetween(
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

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> pageIndexEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pageIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition>
      pageIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pageIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> pageIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pageIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterFilterCondition> pageIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pageIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension BookRecordQueryObject
    on QueryBuilder<BookRecord, BookRecord, QFilterCondition> {}

extension BookRecordQueryLinks
    on QueryBuilder<BookRecord, BookRecord, QFilterCondition> {}

extension BookRecordQuerySortBy
    on QueryBuilder<BookRecord, BookRecord, QSortBy> {
  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> sortByAid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.asc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> sortByAidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.desc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> sortByCfi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cfi', Sort.asc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> sortByCfiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cfi', Sort.desc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> sortByChapterIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterIndex', Sort.asc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> sortByChapterIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterIndex', Sort.desc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> sortByPageIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageIndex', Sort.asc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> sortByPageIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageIndex', Sort.desc);
    });
  }
}

extension BookRecordQuerySortThenBy
    on QueryBuilder<BookRecord, BookRecord, QSortThenBy> {
  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenByAid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.asc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenByAidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.desc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenByCfi() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cfi', Sort.asc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenByCfiDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cfi', Sort.desc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenByChapterIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterIndex', Sort.asc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenByChapterIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'chapterIndex', Sort.desc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenByPageIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageIndex', Sort.asc);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QAfterSortBy> thenByPageIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pageIndex', Sort.desc);
    });
  }
}

extension BookRecordQueryWhereDistinct
    on QueryBuilder<BookRecord, BookRecord, QDistinct> {
  QueryBuilder<BookRecord, BookRecord, QDistinct> distinctByAid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QDistinct> distinctByCfi(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cfi', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<BookRecord, BookRecord, QDistinct> distinctByChapterIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'chapterIndex');
    });
  }

  QueryBuilder<BookRecord, BookRecord, QDistinct> distinctByPageIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pageIndex');
    });
  }
}

extension BookRecordQueryProperty
    on QueryBuilder<BookRecord, BookRecord, QQueryProperty> {
  QueryBuilder<BookRecord, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<BookRecord, String, QQueryOperations> aidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aid');
    });
  }

  QueryBuilder<BookRecord, String?, QQueryOperations> cfiProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cfi');
    });
  }

  QueryBuilder<BookRecord, int, QQueryOperations> chapterIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'chapterIndex');
    });
  }

  QueryBuilder<BookRecord, int, QQueryOperations> pageIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pageIndex');
    });
  }
}
