// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_book.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters

extension GetCaseBookCollection on Isar {
  IsarCollection<CaseBook> get caseBooks => this.collection();
}

const CaseBookSchema = CollectionSchema(
  name: r'CaseBook',
  id: 2550548064125439399,
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
    r'cIndex': PropertySchema(
      id: 2,
      name: r'cIndex',
      type: IsarType.long,
    ),
    r'cid': PropertySchema(
      id: 3,
      name: r'cid',
      type: IsarType.string,
    ),
    r'cover': PropertySchema(
      id: 4,
      name: r'cover',
      type: IsarType.string,
    ),
    r'lastChapter': PropertySchema(
      id: 5,
      name: r'lastChapter',
      type: IsarType.string,
    ),
    r'lastRead': PropertySchema(
      id: 6,
      name: r'lastRead',
      type: IsarType.string,
    ),
    r'page': PropertySchema(
      id: 7,
      name: r'page',
      type: IsarType.long,
    ),
    r'updateTime': PropertySchema(
      id: 8,
      name: r'updateTime',
      type: IsarType.string,
    )
  },
  estimateSize: _caseBookEstimateSize,
  serialize: _caseBookSerialize,
  deserialize: _caseBookDeserialize,
  deserializeProp: _caseBookDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _caseBookGetId,
  getLinks: _caseBookGetLinks,
  attach: _caseBookAttach,
  version: '3.0.5',
);

int _caseBookEstimateSize(
  CaseBook object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.aid.length * 3;
  bytesCount += 3 + object.bookName.length * 3;
  bytesCount += 3 + object.cid.length * 3;
  bytesCount += 3 + object.cover.length * 3;
  bytesCount += 3 + object.lastChapter.length * 3;
  {
    final value = object.lastRead;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  bytesCount += 3 + object.updateTime.length * 3;
  return bytesCount;
}

void _caseBookSerialize(
  CaseBook object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.aid);
  writer.writeString(offsets[1], object.bookName);
  writer.writeLong(offsets[2], object.cIndex);
  writer.writeString(offsets[3], object.cid);
  writer.writeString(offsets[4], object.cover);
  writer.writeString(offsets[5], object.lastChapter);
  writer.writeString(offsets[6], object.lastRead);
  writer.writeLong(offsets[7], object.page);
  writer.writeString(offsets[8], object.updateTime);
}

CaseBook _caseBookDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = CaseBook(
    reader.readString(offsets[1]),
    reader.readString(offsets[0]),
    reader.readString(offsets[3]),
    reader.readLong(offsets[2]),
    reader.readLong(offsets[7]),
    reader.readString(offsets[4]),
    reader.readString(offsets[8]),
    reader.readString(offsets[5]),
    lastRead: reader.readStringOrNull(offsets[6]),
  );
  object.id = id;
  return object;
}

P _caseBookDeserializeProp<P>(
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
      return (reader.readLong(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    case 5:
      return (reader.readString(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset)) as P;
    case 7:
      return (reader.readLong(offset)) as P;
    case 8:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _caseBookGetId(CaseBook object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _caseBookGetLinks(CaseBook object) {
  return [];
}

void _caseBookAttach(IsarCollection<dynamic> col, Id id, CaseBook object) {
  object.id = id;
}

extension CaseBookQueryWhereSort on QueryBuilder<CaseBook, CaseBook, QWhere> {
  QueryBuilder<CaseBook, CaseBook, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension CaseBookQueryWhere on QueryBuilder<CaseBook, CaseBook, QWhereClause> {
  QueryBuilder<CaseBook, CaseBook, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<CaseBook, CaseBook, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterWhereClause> idBetween(
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

extension CaseBookQueryFilter
    on QueryBuilder<CaseBook, CaseBook, QFilterCondition> {
  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidEqualTo(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidGreaterThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidLessThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidBetween(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidStartsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidEndsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidContains(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidMatches(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'aid',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> aidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'aid',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameEqualTo(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameGreaterThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameLessThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameBetween(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameStartsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameEndsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bookName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameMatches(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bookName',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> bookNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bookName',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cIndexEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cIndexGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cIndexLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cIndex',
        value: value,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cIndexBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cIndex',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cid',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> cidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cid',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverEqualTo(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverGreaterThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverLessThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverBetween(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverStartsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverEndsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverContains(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverMatches(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cover',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> coverIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cover',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> idBetween(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastChapterEqualTo(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition>
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastChapterLessThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastChapterBetween(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastChapterStartsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastChapterEndsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastChapterContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastChapter',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastChapterMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastChapter',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastChapterIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastChapter',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition>
      lastChapterIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastChapter',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastRead',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastRead',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastRead',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'lastRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'lastRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'lastRead',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'lastRead',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastRead',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> lastReadIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'lastRead',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> pageEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'page',
        value: value,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> pageGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'page',
        value: value,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> pageLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'page',
        value: value,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> pageBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'page',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> updateTimeEqualTo(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> updateTimeGreaterThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> updateTimeLessThan(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> updateTimeBetween(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> updateTimeStartsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> updateTimeEndsWith(
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

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> updateTimeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updateTime',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> updateTimeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updateTime',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition> updateTimeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updateTime',
        value: '',
      ));
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterFilterCondition>
      updateTimeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updateTime',
        value: '',
      ));
    });
  }
}

extension CaseBookQueryObject
    on QueryBuilder<CaseBook, CaseBook, QFilterCondition> {}

extension CaseBookQueryLinks
    on QueryBuilder<CaseBook, CaseBook, QFilterCondition> {}

extension CaseBookQuerySortBy on QueryBuilder<CaseBook, CaseBook, QSortBy> {
  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByAid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByAidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByBookName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByBookNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByCIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cIndex', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByCIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cIndex', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByCid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cid', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByCidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cid', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByLastChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChapter', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByLastChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChapter', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateTime', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> sortByUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateTime', Sort.desc);
    });
  }
}

extension CaseBookQuerySortThenBy
    on QueryBuilder<CaseBook, CaseBook, QSortThenBy> {
  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByAid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByAidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'aid', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByBookName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByBookNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bookName', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByCIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cIndex', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByCIndexDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cIndex', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByCid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cid', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByCidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cid', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByCover() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByCoverDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cover', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByLastChapter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChapter', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByLastChapterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastChapter', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByLastRead() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByLastReadDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastRead', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByPageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'page', Sort.desc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByUpdateTime() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateTime', Sort.asc);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QAfterSortBy> thenByUpdateTimeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updateTime', Sort.desc);
    });
  }
}

extension CaseBookQueryWhereDistinct
    on QueryBuilder<CaseBook, CaseBook, QDistinct> {
  QueryBuilder<CaseBook, CaseBook, QDistinct> distinctByAid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'aid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QDistinct> distinctByBookName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bookName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QDistinct> distinctByCIndex() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cIndex');
    });
  }

  QueryBuilder<CaseBook, CaseBook, QDistinct> distinctByCid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QDistinct> distinctByCover(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cover', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QDistinct> distinctByLastChapter(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastChapter', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QDistinct> distinctByLastRead(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastRead', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<CaseBook, CaseBook, QDistinct> distinctByPage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'page');
    });
  }

  QueryBuilder<CaseBook, CaseBook, QDistinct> distinctByUpdateTime(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updateTime', caseSensitive: caseSensitive);
    });
  }
}

extension CaseBookQueryProperty
    on QueryBuilder<CaseBook, CaseBook, QQueryProperty> {
  QueryBuilder<CaseBook, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<CaseBook, String, QQueryOperations> aidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'aid');
    });
  }

  QueryBuilder<CaseBook, String, QQueryOperations> bookNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bookName');
    });
  }

  QueryBuilder<CaseBook, int, QQueryOperations> cIndexProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cIndex');
    });
  }

  QueryBuilder<CaseBook, String, QQueryOperations> cidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cid');
    });
  }

  QueryBuilder<CaseBook, String, QQueryOperations> coverProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cover');
    });
  }

  QueryBuilder<CaseBook, String, QQueryOperations> lastChapterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastChapter');
    });
  }

  QueryBuilder<CaseBook, String?, QQueryOperations> lastReadProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastRead');
    });
  }

  QueryBuilder<CaseBook, int, QQueryOperations> pageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'page');
    });
  }

  QueryBuilder<CaseBook, String, QQueryOperations> updateTimeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updateTime');
    });
  }
}
