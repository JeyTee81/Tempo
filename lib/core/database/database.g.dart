// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UsersTable extends Users with TableInfo<$UsersTable, User> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'));
  static const VerificationMeta _photoUrlMeta =
      const VerificationMeta('photoUrl');
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
      'photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
      'role', aliasedName, false,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 50),
      type: DriftSqlType.string,
      requiredDuringInsert: false,
      defaultValue: const Constant('user'));
  static const VerificationMeta _isActiveMeta =
      const VerificationMeta('isActive');
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
      'is_active', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_active" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _lastLoginAtMeta =
      const VerificationMeta('lastLoginAt');
  @override
  late final GeneratedColumn<DateTime> lastLoginAt = GeneratedColumn<DateTime>(
      'last_login_at', aliasedName, true,
      type: DriftSqlType.dateTime, requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        id,
        firstName,
        lastName,
        email,
        photoUrl,
        role,
        isActive,
        createdAt,
        lastLoginAt
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'users';
  @override
  VerificationContext validateIntegrity(Insertable<User> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta));
    }
    if (data.containsKey('role')) {
      context.handle(
          _roleMeta, role.isAcceptableOrUnknown(data['role']!, _roleMeta));
    }
    if (data.containsKey('is_active')) {
      context.handle(_isActiveMeta,
          isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('last_login_at')) {
      context.handle(
          _lastLoginAtMeta,
          lastLoginAt.isAcceptableOrUnknown(
              data['last_login_at']!, _lastLoginAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  User map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return User(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email'])!,
      photoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_url']),
      role: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}role'])!,
      isActive: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_active'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      lastLoginAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}last_login_at']),
    );
  }

  @override
  $UsersTable createAlias(String alias) {
    return $UsersTable(attachedDatabase, alias);
  }
}

class User extends DataClass implements Insertable<User> {
  final int id;
  final String firstName;
  final String lastName;
  final String email;
  final String? photoUrl;
  final String role;
  final bool isActive;
  final DateTime createdAt;
  final DateTime? lastLoginAt;
  const User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      this.photoUrl,
      required this.role,
      required this.isActive,
      required this.createdAt,
      this.lastLoginAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    map['email'] = Variable<String>(email);
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    map['role'] = Variable<String>(role);
    map['is_active'] = Variable<bool>(isActive);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || lastLoginAt != null) {
      map['last_login_at'] = Variable<DateTime>(lastLoginAt);
    }
    return map;
  }

  UsersCompanion toCompanion(bool nullToAbsent) {
    return UsersCompanion(
      id: Value(id),
      firstName: Value(firstName),
      lastName: Value(lastName),
      email: Value(email),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      role: Value(role),
      isActive: Value(isActive),
      createdAt: Value(createdAt),
      lastLoginAt: lastLoginAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastLoginAt),
    );
  }

  factory User.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return User(
      id: serializer.fromJson<int>(json['id']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      email: serializer.fromJson<String>(json['email']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      role: serializer.fromJson<String>(json['role']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      lastLoginAt: serializer.fromJson<DateTime?>(json['lastLoginAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'email': serializer.toJson<String>(email),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'role': serializer.toJson<String>(role),
      'isActive': serializer.toJson<bool>(isActive),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'lastLoginAt': serializer.toJson<DateTime?>(lastLoginAt),
    };
  }

  User copyWith(
          {int? id,
          String? firstName,
          String? lastName,
          String? email,
          Value<String?> photoUrl = const Value.absent(),
          String? role,
          bool? isActive,
          DateTime? createdAt,
          Value<DateTime?> lastLoginAt = const Value.absent()}) =>
      User(
        id: id ?? this.id,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        email: email ?? this.email,
        photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
        role: role ?? this.role,
        isActive: isActive ?? this.isActive,
        createdAt: createdAt ?? this.createdAt,
        lastLoginAt: lastLoginAt.present ? lastLoginAt.value : this.lastLoginAt,
      );
  User copyWithCompanion(UsersCompanion data) {
    return User(
      id: data.id.present ? data.id.value : this.id,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      email: data.email.present ? data.email.value : this.email,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      role: data.role.present ? data.role.value : this.role,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      lastLoginAt:
          data.lastLoginAt.present ? data.lastLoginAt.value : this.lastLoginAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('User(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastLoginAt: $lastLoginAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, firstName, lastName, email, photoUrl,
      role, isActive, createdAt, lastLoginAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is User &&
          other.id == this.id &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.email == this.email &&
          other.photoUrl == this.photoUrl &&
          other.role == this.role &&
          other.isActive == this.isActive &&
          other.createdAt == this.createdAt &&
          other.lastLoginAt == this.lastLoginAt);
}

class UsersCompanion extends UpdateCompanion<User> {
  final Value<int> id;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String> email;
  final Value<String?> photoUrl;
  final Value<String> role;
  final Value<bool> isActive;
  final Value<DateTime> createdAt;
  final Value<DateTime?> lastLoginAt;
  const UsersCompanion({
    this.id = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.email = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastLoginAt = const Value.absent(),
  });
  UsersCompanion.insert({
    this.id = const Value.absent(),
    required String firstName,
    required String lastName,
    required String email,
    this.photoUrl = const Value.absent(),
    this.role = const Value.absent(),
    this.isActive = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.lastLoginAt = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName),
        email = Value(email);
  static Insertable<User> custom({
    Expression<int>? id,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? email,
    Expression<String>? photoUrl,
    Expression<String>? role,
    Expression<bool>? isActive,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? lastLoginAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (email != null) 'email': email,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (role != null) 'role': role,
      if (isActive != null) 'is_active': isActive,
      if (createdAt != null) 'created_at': createdAt,
      if (lastLoginAt != null) 'last_login_at': lastLoginAt,
    });
  }

  UsersCompanion copyWith(
      {Value<int>? id,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String>? email,
      Value<String?>? photoUrl,
      Value<String>? role,
      Value<bool>? isActive,
      Value<DateTime>? createdAt,
      Value<DateTime?>? lastLoginAt}) {
    return UsersCompanion(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      photoUrl: photoUrl ?? this.photoUrl,
      role: role ?? this.role,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (lastLoginAt.present) {
      map['last_login_at'] = Variable<DateTime>(lastLoginAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsersCompanion(')
          ..write('id: $id, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('email: $email, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('role: $role, ')
          ..write('isActive: $isActive, ')
          ..write('createdAt: $createdAt, ')
          ..write('lastLoginAt: $lastLoginAt')
          ..write(')'))
        .toString();
  }
}

class $ContactsTable extends Contacts with TableInfo<$ContactsTable, Contact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _firstNameMeta =
      const VerificationMeta('firstName');
  @override
  late final GeneratedColumn<String> firstName = GeneratedColumn<String>(
      'first_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _lastNameMeta =
      const VerificationMeta('lastName');
  @override
  late final GeneratedColumn<String> lastName = GeneratedColumn<String>(
      'last_name', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _jobTitleMeta =
      const VerificationMeta('jobTitle');
  @override
  late final GeneratedColumn<String> jobTitle = GeneratedColumn<String>(
      'job_title', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _companyMeta =
      const VerificationMeta('company');
  @override
  late final GeneratedColumn<String> company = GeneratedColumn<String>(
      'company', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
      'email', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _phoneMeta = const VerificationMeta('phone');
  @override
  late final GeneratedColumn<String> phone = GeneratedColumn<String>(
      'phone', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _photoUrlMeta =
      const VerificationMeta('photoUrl');
  @override
  late final GeneratedColumn<String> photoUrl = GeneratedColumn<String>(
      'photo_url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
      'notes', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isFavoriteMeta =
      const VerificationMeta('isFavorite');
  @override
  late final GeneratedColumn<bool> isFavorite = GeneratedColumn<bool>(
      'is_favorite', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_favorite" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        firstName,
        lastName,
        jobTitle,
        company,
        email,
        phone,
        photoUrl,
        notes,
        createdAt,
        isFavorite
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'contacts';
  @override
  VerificationContext validateIntegrity(Insertable<Contact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('first_name')) {
      context.handle(_firstNameMeta,
          firstName.isAcceptableOrUnknown(data['first_name']!, _firstNameMeta));
    } else if (isInserting) {
      context.missing(_firstNameMeta);
    }
    if (data.containsKey('last_name')) {
      context.handle(_lastNameMeta,
          lastName.isAcceptableOrUnknown(data['last_name']!, _lastNameMeta));
    } else if (isInserting) {
      context.missing(_lastNameMeta);
    }
    if (data.containsKey('job_title')) {
      context.handle(_jobTitleMeta,
          jobTitle.isAcceptableOrUnknown(data['job_title']!, _jobTitleMeta));
    }
    if (data.containsKey('company')) {
      context.handle(_companyMeta,
          company.isAcceptableOrUnknown(data['company']!, _companyMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('phone')) {
      context.handle(
          _phoneMeta, phone.isAcceptableOrUnknown(data['phone']!, _phoneMeta));
    }
    if (data.containsKey('photo_url')) {
      context.handle(_photoUrlMeta,
          photoUrl.isAcceptableOrUnknown(data['photo_url']!, _photoUrlMeta));
    }
    if (data.containsKey('notes')) {
      context.handle(
          _notesMeta, notes.isAcceptableOrUnknown(data['notes']!, _notesMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_favorite')) {
      context.handle(
          _isFavoriteMeta,
          isFavorite.isAcceptableOrUnknown(
              data['is_favorite']!, _isFavoriteMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Contact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Contact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      firstName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}first_name'])!,
      lastName: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}last_name'])!,
      jobTitle: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}job_title']),
      company: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}company']),
      email: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}email']),
      phone: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}phone']),
      photoUrl: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}photo_url']),
      notes: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}notes']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isFavorite: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_favorite'])!,
    );
  }

  @override
  $ContactsTable createAlias(String alias) {
    return $ContactsTable(attachedDatabase, alias);
  }
}

class Contact extends DataClass implements Insertable<Contact> {
  final int id;
  final int? userId;
  final String firstName;
  final String lastName;
  final String? jobTitle;
  final String? company;
  final String? email;
  final String? phone;
  final String? photoUrl;
  final String? notes;
  final DateTime createdAt;
  final bool isFavorite;
  const Contact(
      {required this.id,
      this.userId,
      required this.firstName,
      required this.lastName,
      this.jobTitle,
      this.company,
      this.email,
      this.phone,
      this.photoUrl,
      this.notes,
      required this.createdAt,
      required this.isFavorite});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['first_name'] = Variable<String>(firstName);
    map['last_name'] = Variable<String>(lastName);
    if (!nullToAbsent || jobTitle != null) {
      map['job_title'] = Variable<String>(jobTitle);
    }
    if (!nullToAbsent || company != null) {
      map['company'] = Variable<String>(company);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || phone != null) {
      map['phone'] = Variable<String>(phone);
    }
    if (!nullToAbsent || photoUrl != null) {
      map['photo_url'] = Variable<String>(photoUrl);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_favorite'] = Variable<bool>(isFavorite);
    return map;
  }

  ContactsCompanion toCompanion(bool nullToAbsent) {
    return ContactsCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      firstName: Value(firstName),
      lastName: Value(lastName),
      jobTitle: jobTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(jobTitle),
      company: company == null && nullToAbsent
          ? const Value.absent()
          : Value(company),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      phone:
          phone == null && nullToAbsent ? const Value.absent() : Value(phone),
      photoUrl: photoUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(photoUrl),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
      createdAt: Value(createdAt),
      isFavorite: Value(isFavorite),
    );
  }

  factory Contact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Contact(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int?>(json['userId']),
      firstName: serializer.fromJson<String>(json['firstName']),
      lastName: serializer.fromJson<String>(json['lastName']),
      jobTitle: serializer.fromJson<String?>(json['jobTitle']),
      company: serializer.fromJson<String?>(json['company']),
      email: serializer.fromJson<String?>(json['email']),
      phone: serializer.fromJson<String?>(json['phone']),
      photoUrl: serializer.fromJson<String?>(json['photoUrl']),
      notes: serializer.fromJson<String?>(json['notes']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isFavorite: serializer.fromJson<bool>(json['isFavorite']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int?>(userId),
      'firstName': serializer.toJson<String>(firstName),
      'lastName': serializer.toJson<String>(lastName),
      'jobTitle': serializer.toJson<String?>(jobTitle),
      'company': serializer.toJson<String?>(company),
      'email': serializer.toJson<String?>(email),
      'phone': serializer.toJson<String?>(phone),
      'photoUrl': serializer.toJson<String?>(photoUrl),
      'notes': serializer.toJson<String?>(notes),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isFavorite': serializer.toJson<bool>(isFavorite),
    };
  }

  Contact copyWith(
          {int? id,
          Value<int?> userId = const Value.absent(),
          String? firstName,
          String? lastName,
          Value<String?> jobTitle = const Value.absent(),
          Value<String?> company = const Value.absent(),
          Value<String?> email = const Value.absent(),
          Value<String?> phone = const Value.absent(),
          Value<String?> photoUrl = const Value.absent(),
          Value<String?> notes = const Value.absent(),
          DateTime? createdAt,
          bool? isFavorite}) =>
      Contact(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        firstName: firstName ?? this.firstName,
        lastName: lastName ?? this.lastName,
        jobTitle: jobTitle.present ? jobTitle.value : this.jobTitle,
        company: company.present ? company.value : this.company,
        email: email.present ? email.value : this.email,
        phone: phone.present ? phone.value : this.phone,
        photoUrl: photoUrl.present ? photoUrl.value : this.photoUrl,
        notes: notes.present ? notes.value : this.notes,
        createdAt: createdAt ?? this.createdAt,
        isFavorite: isFavorite ?? this.isFavorite,
      );
  Contact copyWithCompanion(ContactsCompanion data) {
    return Contact(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      firstName: data.firstName.present ? data.firstName.value : this.firstName,
      lastName: data.lastName.present ? data.lastName.value : this.lastName,
      jobTitle: data.jobTitle.present ? data.jobTitle.value : this.jobTitle,
      company: data.company.present ? data.company.value : this.company,
      email: data.email.present ? data.email.value : this.email,
      phone: data.phone.present ? data.phone.value : this.phone,
      photoUrl: data.photoUrl.present ? data.photoUrl.value : this.photoUrl,
      notes: data.notes.present ? data.notes.value : this.notes,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isFavorite:
          data.isFavorite.present ? data.isFavorite.value : this.isFavorite,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Contact(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('company: $company, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, firstName, lastName, jobTitle,
      company, email, phone, photoUrl, notes, createdAt, isFavorite);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Contact &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.firstName == this.firstName &&
          other.lastName == this.lastName &&
          other.jobTitle == this.jobTitle &&
          other.company == this.company &&
          other.email == this.email &&
          other.phone == this.phone &&
          other.photoUrl == this.photoUrl &&
          other.notes == this.notes &&
          other.createdAt == this.createdAt &&
          other.isFavorite == this.isFavorite);
}

class ContactsCompanion extends UpdateCompanion<Contact> {
  final Value<int> id;
  final Value<int?> userId;
  final Value<String> firstName;
  final Value<String> lastName;
  final Value<String?> jobTitle;
  final Value<String?> company;
  final Value<String?> email;
  final Value<String?> phone;
  final Value<String?> photoUrl;
  final Value<String?> notes;
  final Value<DateTime> createdAt;
  final Value<bool> isFavorite;
  const ContactsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.firstName = const Value.absent(),
    this.lastName = const Value.absent(),
    this.jobTitle = const Value.absent(),
    this.company = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isFavorite = const Value.absent(),
  });
  ContactsCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    required String firstName,
    required String lastName,
    this.jobTitle = const Value.absent(),
    this.company = const Value.absent(),
    this.email = const Value.absent(),
    this.phone = const Value.absent(),
    this.photoUrl = const Value.absent(),
    this.notes = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isFavorite = const Value.absent(),
  })  : firstName = Value(firstName),
        lastName = Value(lastName);
  static Insertable<Contact> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? firstName,
    Expression<String>? lastName,
    Expression<String>? jobTitle,
    Expression<String>? company,
    Expression<String>? email,
    Expression<String>? phone,
    Expression<String>? photoUrl,
    Expression<String>? notes,
    Expression<DateTime>? createdAt,
    Expression<bool>? isFavorite,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (firstName != null) 'first_name': firstName,
      if (lastName != null) 'last_name': lastName,
      if (jobTitle != null) 'job_title': jobTitle,
      if (company != null) 'company': company,
      if (email != null) 'email': email,
      if (phone != null) 'phone': phone,
      if (photoUrl != null) 'photo_url': photoUrl,
      if (notes != null) 'notes': notes,
      if (createdAt != null) 'created_at': createdAt,
      if (isFavorite != null) 'is_favorite': isFavorite,
    });
  }

  ContactsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? userId,
      Value<String>? firstName,
      Value<String>? lastName,
      Value<String?>? jobTitle,
      Value<String?>? company,
      Value<String?>? email,
      Value<String?>? phone,
      Value<String?>? photoUrl,
      Value<String?>? notes,
      Value<DateTime>? createdAt,
      Value<bool>? isFavorite}) {
    return ContactsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      jobTitle: jobTitle ?? this.jobTitle,
      company: company ?? this.company,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (firstName.present) {
      map['first_name'] = Variable<String>(firstName.value);
    }
    if (lastName.present) {
      map['last_name'] = Variable<String>(lastName.value);
    }
    if (jobTitle.present) {
      map['job_title'] = Variable<String>(jobTitle.value);
    }
    if (company.present) {
      map['company'] = Variable<String>(company.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (phone.present) {
      map['phone'] = Variable<String>(phone.value);
    }
    if (photoUrl.present) {
      map['photo_url'] = Variable<String>(photoUrl.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isFavorite.present) {
      map['is_favorite'] = Variable<bool>(isFavorite.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ContactsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('firstName: $firstName, ')
          ..write('lastName: $lastName, ')
          ..write('jobTitle: $jobTitle, ')
          ..write('company: $company, ')
          ..write('email: $email, ')
          ..write('phone: $phone, ')
          ..write('photoUrl: $photoUrl, ')
          ..write('notes: $notes, ')
          ..write('createdAt: $createdAt, ')
          ..write('isFavorite: $isFavorite')
          ..write(')'))
        .toString();
  }
}

class $ArticlesTable extends Articles with TableInfo<$ArticlesTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _sourceMeta = const VerificationMeta('source');
  @override
  late final GeneratedColumn<String> source = GeneratedColumn<String>(
      'source', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 100),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _urlMeta = const VerificationMeta('url');
  @override
  late final GeneratedColumn<String> url = GeneratedColumn<String>(
      'url', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _summaryMeta =
      const VerificationMeta('summary');
  @override
  late final GeneratedColumn<String> summary = GeneratedColumn<String>(
      'summary', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
      'date', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _tagsMeta = const VerificationMeta('tags');
  @override
  late final GeneratedColumn<String> tags = GeneratedColumn<String>(
      'tags', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _isLocalMeta =
      const VerificationMeta('isLocal');
  @override
  late final GeneratedColumn<bool> isLocal = GeneratedColumn<bool>(
      'is_local', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_local" IN (0, 1))'),
      defaultValue: const Constant(true));
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  @override
  List<GeneratedColumn> get $columns =>
      [id, userId, title, source, url, summary, date, tags, isLocal, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  VerificationContext validateIntegrity(Insertable<Article> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('source')) {
      context.handle(_sourceMeta,
          source.isAcceptableOrUnknown(data['source']!, _sourceMeta));
    } else if (isInserting) {
      context.missing(_sourceMeta);
    }
    if (data.containsKey('url')) {
      context.handle(
          _urlMeta, url.isAcceptableOrUnknown(data['url']!, _urlMeta));
    }
    if (data.containsKey('summary')) {
      context.handle(_summaryMeta,
          summary.isAcceptableOrUnknown(data['summary']!, _summaryMeta));
    }
    if (data.containsKey('date')) {
      context.handle(
          _dateMeta, date.isAcceptableOrUnknown(data['date']!, _dateMeta));
    }
    if (data.containsKey('tags')) {
      context.handle(
          _tagsMeta, tags.isAcceptableOrUnknown(data['tags']!, _tagsMeta));
    }
    if (data.containsKey('is_local')) {
      context.handle(_isLocalMeta,
          isLocal.isAcceptableOrUnknown(data['is_local']!, _isLocalMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Article(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      source: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}source'])!,
      url: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}url']),
      summary: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}summary']),
      date: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}date'])!,
      tags: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}tags']),
      isLocal: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_local'])!,
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }
}

class Article extends DataClass implements Insertable<Article> {
  final int id;
  final int? userId;
  final String title;
  final String source;
  final String? url;
  final String? summary;
  final DateTime date;
  final String? tags;
  final bool isLocal;
  final DateTime createdAt;
  const Article(
      {required this.id,
      this.userId,
      required this.title,
      required this.source,
      this.url,
      this.summary,
      required this.date,
      this.tags,
      required this.isLocal,
      required this.createdAt});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['title'] = Variable<String>(title);
    map['source'] = Variable<String>(source);
    if (!nullToAbsent || url != null) {
      map['url'] = Variable<String>(url);
    }
    if (!nullToAbsent || summary != null) {
      map['summary'] = Variable<String>(summary);
    }
    map['date'] = Variable<DateTime>(date);
    if (!nullToAbsent || tags != null) {
      map['tags'] = Variable<String>(tags);
    }
    map['is_local'] = Variable<bool>(isLocal);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      title: Value(title),
      source: Value(source),
      url: url == null && nullToAbsent ? const Value.absent() : Value(url),
      summary: summary == null && nullToAbsent
          ? const Value.absent()
          : Value(summary),
      date: Value(date),
      tags: tags == null && nullToAbsent ? const Value.absent() : Value(tags),
      isLocal: Value(isLocal),
      createdAt: Value(createdAt),
    );
  }

  factory Article.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int?>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      source: serializer.fromJson<String>(json['source']),
      url: serializer.fromJson<String?>(json['url']),
      summary: serializer.fromJson<String?>(json['summary']),
      date: serializer.fromJson<DateTime>(json['date']),
      tags: serializer.fromJson<String?>(json['tags']),
      isLocal: serializer.fromJson<bool>(json['isLocal']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int?>(userId),
      'title': serializer.toJson<String>(title),
      'source': serializer.toJson<String>(source),
      'url': serializer.toJson<String?>(url),
      'summary': serializer.toJson<String?>(summary),
      'date': serializer.toJson<DateTime>(date),
      'tags': serializer.toJson<String?>(tags),
      'isLocal': serializer.toJson<bool>(isLocal),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Article copyWith(
          {int? id,
          Value<int?> userId = const Value.absent(),
          String? title,
          String? source,
          Value<String?> url = const Value.absent(),
          Value<String?> summary = const Value.absent(),
          DateTime? date,
          Value<String?> tags = const Value.absent(),
          bool? isLocal,
          DateTime? createdAt}) =>
      Article(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        title: title ?? this.title,
        source: source ?? this.source,
        url: url.present ? url.value : this.url,
        summary: summary.present ? summary.value : this.summary,
        date: date ?? this.date,
        tags: tags.present ? tags.value : this.tags,
        isLocal: isLocal ?? this.isLocal,
        createdAt: createdAt ?? this.createdAt,
      );
  Article copyWithCompanion(ArticlesCompanion data) {
    return Article(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      source: data.source.present ? data.source.value : this.source,
      url: data.url.present ? data.url.value : this.url,
      summary: data.summary.present ? data.summary.value : this.summary,
      date: data.date.present ? data.date.value : this.date,
      tags: data.tags.present ? data.tags.value : this.tags,
      isLocal: data.isLocal.present ? data.isLocal.value : this.isLocal,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('source: $source, ')
          ..write('url: $url, ')
          ..write('summary: $summary, ')
          ..write('date: $date, ')
          ..write('tags: $tags, ')
          ..write('isLocal: $isLocal, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      id, userId, title, source, url, summary, date, tags, isLocal, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.source == this.source &&
          other.url == this.url &&
          other.summary == this.summary &&
          other.date == this.date &&
          other.tags == this.tags &&
          other.isLocal == this.isLocal &&
          other.createdAt == this.createdAt);
}

class ArticlesCompanion extends UpdateCompanion<Article> {
  final Value<int> id;
  final Value<int?> userId;
  final Value<String> title;
  final Value<String> source;
  final Value<String?> url;
  final Value<String?> summary;
  final Value<DateTime> date;
  final Value<String?> tags;
  final Value<bool> isLocal;
  final Value<DateTime> createdAt;
  const ArticlesCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.source = const Value.absent(),
    this.url = const Value.absent(),
    this.summary = const Value.absent(),
    this.date = const Value.absent(),
    this.tags = const Value.absent(),
    this.isLocal = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  ArticlesCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    required String title,
    required String source,
    this.url = const Value.absent(),
    this.summary = const Value.absent(),
    this.date = const Value.absent(),
    this.tags = const Value.absent(),
    this.isLocal = const Value.absent(),
    this.createdAt = const Value.absent(),
  })  : title = Value(title),
        source = Value(source);
  static Insertable<Article> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? title,
    Expression<String>? source,
    Expression<String>? url,
    Expression<String>? summary,
    Expression<DateTime>? date,
    Expression<String>? tags,
    Expression<bool>? isLocal,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (source != null) 'source': source,
      if (url != null) 'url': url,
      if (summary != null) 'summary': summary,
      if (date != null) 'date': date,
      if (tags != null) 'tags': tags,
      if (isLocal != null) 'is_local': isLocal,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  ArticlesCompanion copyWith(
      {Value<int>? id,
      Value<int?>? userId,
      Value<String>? title,
      Value<String>? source,
      Value<String?>? url,
      Value<String?>? summary,
      Value<DateTime>? date,
      Value<String?>? tags,
      Value<bool>? isLocal,
      Value<DateTime>? createdAt}) {
    return ArticlesCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      source: source ?? this.source,
      url: url ?? this.url,
      summary: summary ?? this.summary,
      date: date ?? this.date,
      tags: tags ?? this.tags,
      isLocal: isLocal ?? this.isLocal,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(source.value);
    }
    if (url.present) {
      map['url'] = Variable<String>(url.value);
    }
    if (summary.present) {
      map['summary'] = Variable<String>(summary.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (tags.present) {
      map['tags'] = Variable<String>(tags.value);
    }
    if (isLocal.present) {
      map['is_local'] = Variable<bool>(isLocal.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('source: $source, ')
          ..write('url: $url, ')
          ..write('summary: $summary, ')
          ..write('date: $date, ')
          ..write('tags: $tags, ')
          ..write('isLocal: $isLocal, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

class $EventsTable extends Events with TableInfo<$EventsTable, Event> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<int> userId = GeneratedColumn<int>(
      'user_id', aliasedName, true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('REFERENCES users (id)'));
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 200),
      type: DriftSqlType.string,
      requiredDuringInsert: true);
  static const VerificationMeta _descriptionMeta =
      const VerificationMeta('description');
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
      'description', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _startDateMeta =
      const VerificationMeta('startDate');
  @override
  late final GeneratedColumn<DateTime> startDate = GeneratedColumn<DateTime>(
      'start_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _endDateMeta =
      const VerificationMeta('endDate');
  @override
  late final GeneratedColumn<DateTime> endDate = GeneratedColumn<DateTime>(
      'end_date', aliasedName, false,
      type: DriftSqlType.dateTime, requiredDuringInsert: true);
  static const VerificationMeta _locationMeta =
      const VerificationMeta('location');
  @override
  late final GeneratedColumn<String> location = GeneratedColumn<String>(
      'location', aliasedName, true,
      type: DriftSqlType.string, requiredDuringInsert: false);
  static const VerificationMeta _createdAtMeta =
      const VerificationMeta('createdAt');
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
      'created_at', aliasedName, false,
      type: DriftSqlType.dateTime,
      requiredDuringInsert: false,
      defaultValue: currentDateAndTime);
  static const VerificationMeta _isAllDayMeta =
      const VerificationMeta('isAllDay');
  @override
  late final GeneratedColumn<bool> isAllDay = GeneratedColumn<bool>(
      'is_all_day', aliasedName, false,
      type: DriftSqlType.bool,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('CHECK ("is_all_day" IN (0, 1))'),
      defaultValue: const Constant(false));
  @override
  List<GeneratedColumn> get $columns => [
        id,
        userId,
        title,
        description,
        startDate,
        endDate,
        location,
        createdAt,
        isAllDay
      ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'events';
  @override
  VerificationContext validateIntegrity(Insertable<Event> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('user_id')) {
      context.handle(_userIdMeta,
          userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
          _descriptionMeta,
          description.isAcceptableOrUnknown(
              data['description']!, _descriptionMeta));
    }
    if (data.containsKey('start_date')) {
      context.handle(_startDateMeta,
          startDate.isAcceptableOrUnknown(data['start_date']!, _startDateMeta));
    } else if (isInserting) {
      context.missing(_startDateMeta);
    }
    if (data.containsKey('end_date')) {
      context.handle(_endDateMeta,
          endDate.isAcceptableOrUnknown(data['end_date']!, _endDateMeta));
    } else if (isInserting) {
      context.missing(_endDateMeta);
    }
    if (data.containsKey('location')) {
      context.handle(_locationMeta,
          location.isAcceptableOrUnknown(data['location']!, _locationMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta));
    }
    if (data.containsKey('is_all_day')) {
      context.handle(_isAllDayMeta,
          isAllDay.isAcceptableOrUnknown(data['is_all_day']!, _isAllDayMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Event map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Event(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      userId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}user_id']),
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      description: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}description']),
      startDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}start_date'])!,
      endDate: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}end_date'])!,
      location: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}location']),
      createdAt: attachedDatabase.typeMapping
          .read(DriftSqlType.dateTime, data['${effectivePrefix}created_at'])!,
      isAllDay: attachedDatabase.typeMapping
          .read(DriftSqlType.bool, data['${effectivePrefix}is_all_day'])!,
    );
  }

  @override
  $EventsTable createAlias(String alias) {
    return $EventsTable(attachedDatabase, alias);
  }
}

class Event extends DataClass implements Insertable<Event> {
  final int id;
  final int? userId;
  final String title;
  final String? description;
  final DateTime startDate;
  final DateTime endDate;
  final String? location;
  final DateTime createdAt;
  final bool isAllDay;
  const Event(
      {required this.id,
      this.userId,
      required this.title,
      this.description,
      required this.startDate,
      required this.endDate,
      this.location,
      required this.createdAt,
      required this.isAllDay});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<int>(userId);
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    map['start_date'] = Variable<DateTime>(startDate);
    map['end_date'] = Variable<DateTime>(endDate);
    if (!nullToAbsent || location != null) {
      map['location'] = Variable<String>(location);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['is_all_day'] = Variable<bool>(isAllDay);
    return map;
  }

  EventsCompanion toCompanion(bool nullToAbsent) {
    return EventsCompanion(
      id: Value(id),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      startDate: Value(startDate),
      endDate: Value(endDate),
      location: location == null && nullToAbsent
          ? const Value.absent()
          : Value(location),
      createdAt: Value(createdAt),
      isAllDay: Value(isAllDay),
    );
  }

  factory Event.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Event(
      id: serializer.fromJson<int>(json['id']),
      userId: serializer.fromJson<int?>(json['userId']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      startDate: serializer.fromJson<DateTime>(json['startDate']),
      endDate: serializer.fromJson<DateTime>(json['endDate']),
      location: serializer.fromJson<String?>(json['location']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      isAllDay: serializer.fromJson<bool>(json['isAllDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'userId': serializer.toJson<int?>(userId),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'startDate': serializer.toJson<DateTime>(startDate),
      'endDate': serializer.toJson<DateTime>(endDate),
      'location': serializer.toJson<String?>(location),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'isAllDay': serializer.toJson<bool>(isAllDay),
    };
  }

  Event copyWith(
          {int? id,
          Value<int?> userId = const Value.absent(),
          String? title,
          Value<String?> description = const Value.absent(),
          DateTime? startDate,
          DateTime? endDate,
          Value<String?> location = const Value.absent(),
          DateTime? createdAt,
          bool? isAllDay}) =>
      Event(
        id: id ?? this.id,
        userId: userId.present ? userId.value : this.userId,
        title: title ?? this.title,
        description: description.present ? description.value : this.description,
        startDate: startDate ?? this.startDate,
        endDate: endDate ?? this.endDate,
        location: location.present ? location.value : this.location,
        createdAt: createdAt ?? this.createdAt,
        isAllDay: isAllDay ?? this.isAllDay,
      );
  Event copyWithCompanion(EventsCompanion data) {
    return Event(
      id: data.id.present ? data.id.value : this.id,
      userId: data.userId.present ? data.userId.value : this.userId,
      title: data.title.present ? data.title.value : this.title,
      description:
          data.description.present ? data.description.value : this.description,
      startDate: data.startDate.present ? data.startDate.value : this.startDate,
      endDate: data.endDate.present ? data.endDate.value : this.endDate,
      location: data.location.present ? data.location.value : this.location,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      isAllDay: data.isAllDay.present ? data.isAllDay.value : this.isAllDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Event(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('location: $location, ')
          ..write('createdAt: $createdAt, ')
          ..write('isAllDay: $isAllDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, userId, title, description, startDate,
      endDate, location, createdAt, isAllDay);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Event &&
          other.id == this.id &&
          other.userId == this.userId &&
          other.title == this.title &&
          other.description == this.description &&
          other.startDate == this.startDate &&
          other.endDate == this.endDate &&
          other.location == this.location &&
          other.createdAt == this.createdAt &&
          other.isAllDay == this.isAllDay);
}

class EventsCompanion extends UpdateCompanion<Event> {
  final Value<int> id;
  final Value<int?> userId;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime> startDate;
  final Value<DateTime> endDate;
  final Value<String?> location;
  final Value<DateTime> createdAt;
  final Value<bool> isAllDay;
  const EventsCompanion({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.startDate = const Value.absent(),
    this.endDate = const Value.absent(),
    this.location = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isAllDay = const Value.absent(),
  });
  EventsCompanion.insert({
    this.id = const Value.absent(),
    this.userId = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    required DateTime startDate,
    required DateTime endDate,
    this.location = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.isAllDay = const Value.absent(),
  })  : title = Value(title),
        startDate = Value(startDate),
        endDate = Value(endDate);
  static Insertable<Event> custom({
    Expression<int>? id,
    Expression<int>? userId,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? startDate,
    Expression<DateTime>? endDate,
    Expression<String>? location,
    Expression<DateTime>? createdAt,
    Expression<bool>? isAllDay,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (userId != null) 'user_id': userId,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (startDate != null) 'start_date': startDate,
      if (endDate != null) 'end_date': endDate,
      if (location != null) 'location': location,
      if (createdAt != null) 'created_at': createdAt,
      if (isAllDay != null) 'is_all_day': isAllDay,
    });
  }

  EventsCompanion copyWith(
      {Value<int>? id,
      Value<int?>? userId,
      Value<String>? title,
      Value<String?>? description,
      Value<DateTime>? startDate,
      Value<DateTime>? endDate,
      Value<String?>? location,
      Value<DateTime>? createdAt,
      Value<bool>? isAllDay}) {
    return EventsCompanion(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      location: location ?? this.location,
      createdAt: createdAt ?? this.createdAt,
      isAllDay: isAllDay ?? this.isAllDay,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<int>(userId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (startDate.present) {
      map['start_date'] = Variable<DateTime>(startDate.value);
    }
    if (endDate.present) {
      map['end_date'] = Variable<DateTime>(endDate.value);
    }
    if (location.present) {
      map['location'] = Variable<String>(location.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (isAllDay.present) {
      map['is_all_day'] = Variable<bool>(isAllDay.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventsCompanion(')
          ..write('id: $id, ')
          ..write('userId: $userId, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('startDate: $startDate, ')
          ..write('endDate: $endDate, ')
          ..write('location: $location, ')
          ..write('createdAt: $createdAt, ')
          ..write('isAllDay: $isAllDay')
          ..write(')'))
        .toString();
  }
}

class $EventContactsTable extends EventContacts
    with TableInfo<$EventContactsTable, EventContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _eventIdMeta =
      const VerificationMeta('eventId');
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
      'event_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES events (id) ON DELETE CASCADE'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES contacts (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [id, eventId, contactId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_contacts';
  @override
  VerificationContext validateIntegrity(Insertable<EventContact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta));
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventContact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      eventId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}event_id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contact_id'])!,
    );
  }

  @override
  $EventContactsTable createAlias(String alias) {
    return $EventContactsTable(attachedDatabase, alias);
  }
}

class EventContact extends DataClass implements Insertable<EventContact> {
  final int id;
  final int eventId;
  final int contactId;
  const EventContact(
      {required this.id, required this.eventId, required this.contactId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(eventId);
    map['contact_id'] = Variable<int>(contactId);
    return map;
  }

  EventContactsCompanion toCompanion(bool nullToAbsent) {
    return EventContactsCompanion(
      id: Value(id),
      eventId: Value(eventId),
      contactId: Value(contactId),
    );
  }

  factory EventContact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventContact(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      contactId: serializer.fromJson<int>(json['contactId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'contactId': serializer.toJson<int>(contactId),
    };
  }

  EventContact copyWith({int? id, int? eventId, int? contactId}) =>
      EventContact(
        id: id ?? this.id,
        eventId: eventId ?? this.eventId,
        contactId: contactId ?? this.contactId,
      );
  EventContact copyWithCompanion(EventContactsCompanion data) {
    return EventContact(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventContact(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('contactId: $contactId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventId, contactId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventContact &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.contactId == this.contactId);
}

class EventContactsCompanion extends UpdateCompanion<EventContact> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<int> contactId;
  const EventContactsCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.contactId = const Value.absent(),
  });
  EventContactsCompanion.insert({
    this.id = const Value.absent(),
    required int eventId,
    required int contactId,
  })  : eventId = Value(eventId),
        contactId = Value(contactId);
  static Insertable<EventContact> custom({
    Expression<int>? id,
    Expression<int>? eventId,
    Expression<int>? contactId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (contactId != null) 'contact_id': contactId,
    });
  }

  EventContactsCompanion copyWith(
      {Value<int>? id, Value<int>? eventId, Value<int>? contactId}) {
    return EventContactsCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      contactId: contactId ?? this.contactId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<int>(contactId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventContactsCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('contactId: $contactId')
          ..write(')'))
        .toString();
  }
}

class $EventArticlesTable extends EventArticles
    with TableInfo<$EventArticlesTable, EventArticle> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EventArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _eventIdMeta =
      const VerificationMeta('eventId');
  @override
  late final GeneratedColumn<int> eventId = GeneratedColumn<int>(
      'event_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES events (id) ON DELETE CASCADE'));
  static const VerificationMeta _articleIdMeta =
      const VerificationMeta('articleId');
  @override
  late final GeneratedColumn<int> articleId = GeneratedColumn<int>(
      'article_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES articles (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [id, eventId, articleId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'event_articles';
  @override
  VerificationContext validateIntegrity(Insertable<EventArticle> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('event_id')) {
      context.handle(_eventIdMeta,
          eventId.isAcceptableOrUnknown(data['event_id']!, _eventIdMeta));
    } else if (isInserting) {
      context.missing(_eventIdMeta);
    }
    if (data.containsKey('article_id')) {
      context.handle(_articleIdMeta,
          articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta));
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  EventArticle map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EventArticle(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      eventId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}event_id'])!,
      articleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}article_id'])!,
    );
  }

  @override
  $EventArticlesTable createAlias(String alias) {
    return $EventArticlesTable(attachedDatabase, alias);
  }
}

class EventArticle extends DataClass implements Insertable<EventArticle> {
  final int id;
  final int eventId;
  final int articleId;
  const EventArticle(
      {required this.id, required this.eventId, required this.articleId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['event_id'] = Variable<int>(eventId);
    map['article_id'] = Variable<int>(articleId);
    return map;
  }

  EventArticlesCompanion toCompanion(bool nullToAbsent) {
    return EventArticlesCompanion(
      id: Value(id),
      eventId: Value(eventId),
      articleId: Value(articleId),
    );
  }

  factory EventArticle.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EventArticle(
      id: serializer.fromJson<int>(json['id']),
      eventId: serializer.fromJson<int>(json['eventId']),
      articleId: serializer.fromJson<int>(json['articleId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'eventId': serializer.toJson<int>(eventId),
      'articleId': serializer.toJson<int>(articleId),
    };
  }

  EventArticle copyWith({int? id, int? eventId, int? articleId}) =>
      EventArticle(
        id: id ?? this.id,
        eventId: eventId ?? this.eventId,
        articleId: articleId ?? this.articleId,
      );
  EventArticle copyWithCompanion(EventArticlesCompanion data) {
    return EventArticle(
      id: data.id.present ? data.id.value : this.id,
      eventId: data.eventId.present ? data.eventId.value : this.eventId,
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EventArticle(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('articleId: $articleId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, eventId, articleId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EventArticle &&
          other.id == this.id &&
          other.eventId == this.eventId &&
          other.articleId == this.articleId);
}

class EventArticlesCompanion extends UpdateCompanion<EventArticle> {
  final Value<int> id;
  final Value<int> eventId;
  final Value<int> articleId;
  const EventArticlesCompanion({
    this.id = const Value.absent(),
    this.eventId = const Value.absent(),
    this.articleId = const Value.absent(),
  });
  EventArticlesCompanion.insert({
    this.id = const Value.absent(),
    required int eventId,
    required int articleId,
  })  : eventId = Value(eventId),
        articleId = Value(articleId);
  static Insertable<EventArticle> custom({
    Expression<int>? id,
    Expression<int>? eventId,
    Expression<int>? articleId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (eventId != null) 'event_id': eventId,
      if (articleId != null) 'article_id': articleId,
    });
  }

  EventArticlesCompanion copyWith(
      {Value<int>? id, Value<int>? eventId, Value<int>? articleId}) {
    return EventArticlesCompanion(
      id: id ?? this.id,
      eventId: eventId ?? this.eventId,
      articleId: articleId ?? this.articleId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (eventId.present) {
      map['event_id'] = Variable<int>(eventId.value);
    }
    if (articleId.present) {
      map['article_id'] = Variable<int>(articleId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EventArticlesCompanion(')
          ..write('id: $id, ')
          ..write('eventId: $eventId, ')
          ..write('articleId: $articleId')
          ..write(')'))
        .toString();
  }
}

class $ArticleContactsTable extends ArticleContacts
    with TableInfo<$ArticleContactsTable, ArticleContact> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticleContactsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      defaultConstraints:
          GeneratedColumn.constraintIsAlways('PRIMARY KEY AUTOINCREMENT'));
  static const VerificationMeta _articleIdMeta =
      const VerificationMeta('articleId');
  @override
  late final GeneratedColumn<int> articleId = GeneratedColumn<int>(
      'article_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES articles (id) ON DELETE CASCADE'));
  static const VerificationMeta _contactIdMeta =
      const VerificationMeta('contactId');
  @override
  late final GeneratedColumn<int> contactId = GeneratedColumn<int>(
      'contact_id', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      defaultConstraints: GeneratedColumn.constraintIsAlways(
          'REFERENCES contacts (id) ON DELETE CASCADE'));
  @override
  List<GeneratedColumn> get $columns => [id, articleId, contactId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'article_contacts';
  @override
  VerificationContext validateIntegrity(Insertable<ArticleContact> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('article_id')) {
      context.handle(_articleIdMeta,
          articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta));
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('contact_id')) {
      context.handle(_contactIdMeta,
          contactId.isAcceptableOrUnknown(data['contact_id']!, _contactIdMeta));
    } else if (isInserting) {
      context.missing(_contactIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ArticleContact map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticleContact(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      articleId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}article_id'])!,
      contactId: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}contact_id'])!,
    );
  }

  @override
  $ArticleContactsTable createAlias(String alias) {
    return $ArticleContactsTable(attachedDatabase, alias);
  }
}

class ArticleContact extends DataClass implements Insertable<ArticleContact> {
  final int id;
  final int articleId;
  final int contactId;
  const ArticleContact(
      {required this.id, required this.articleId, required this.contactId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['article_id'] = Variable<int>(articleId);
    map['contact_id'] = Variable<int>(contactId);
    return map;
  }

  ArticleContactsCompanion toCompanion(bool nullToAbsent) {
    return ArticleContactsCompanion(
      id: Value(id),
      articleId: Value(articleId),
      contactId: Value(contactId),
    );
  }

  factory ArticleContact.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticleContact(
      id: serializer.fromJson<int>(json['id']),
      articleId: serializer.fromJson<int>(json['articleId']),
      contactId: serializer.fromJson<int>(json['contactId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'articleId': serializer.toJson<int>(articleId),
      'contactId': serializer.toJson<int>(contactId),
    };
  }

  ArticleContact copyWith({int? id, int? articleId, int? contactId}) =>
      ArticleContact(
        id: id ?? this.id,
        articleId: articleId ?? this.articleId,
        contactId: contactId ?? this.contactId,
      );
  ArticleContact copyWithCompanion(ArticleContactsCompanion data) {
    return ArticleContact(
      id: data.id.present ? data.id.value : this.id,
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      contactId: data.contactId.present ? data.contactId.value : this.contactId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticleContact(')
          ..write('id: $id, ')
          ..write('articleId: $articleId, ')
          ..write('contactId: $contactId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, articleId, contactId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticleContact &&
          other.id == this.id &&
          other.articleId == this.articleId &&
          other.contactId == this.contactId);
}

class ArticleContactsCompanion extends UpdateCompanion<ArticleContact> {
  final Value<int> id;
  final Value<int> articleId;
  final Value<int> contactId;
  const ArticleContactsCompanion({
    this.id = const Value.absent(),
    this.articleId = const Value.absent(),
    this.contactId = const Value.absent(),
  });
  ArticleContactsCompanion.insert({
    this.id = const Value.absent(),
    required int articleId,
    required int contactId,
  })  : articleId = Value(articleId),
        contactId = Value(contactId);
  static Insertable<ArticleContact> custom({
    Expression<int>? id,
    Expression<int>? articleId,
    Expression<int>? contactId,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (articleId != null) 'article_id': articleId,
      if (contactId != null) 'contact_id': contactId,
    });
  }

  ArticleContactsCompanion copyWith(
      {Value<int>? id, Value<int>? articleId, Value<int>? contactId}) {
    return ArticleContactsCompanion(
      id: id ?? this.id,
      articleId: articleId ?? this.articleId,
      contactId: contactId ?? this.contactId,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (articleId.present) {
      map['article_id'] = Variable<int>(articleId.value);
    }
    if (contactId.present) {
      map['contact_id'] = Variable<int>(contactId.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticleContactsCompanion(')
          ..write('id: $id, ')
          ..write('articleId: $articleId, ')
          ..write('contactId: $contactId')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UsersTable users = $UsersTable(this);
  late final $ContactsTable contacts = $ContactsTable(this);
  late final $ArticlesTable articles = $ArticlesTable(this);
  late final $EventsTable events = $EventsTable(this);
  late final $EventContactsTable eventContacts = $EventContactsTable(this);
  late final $EventArticlesTable eventArticles = $EventArticlesTable(this);
  late final $ArticleContactsTable articleContacts =
      $ArticleContactsTable(this);
  late final ContactDao contactDao = ContactDao(this as AppDatabase);
  late final ArticleDao articleDao = ArticleDao(this as AppDatabase);
  late final EventDao eventDao = EventDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        users,
        contacts,
        articles,
        events,
        eventContacts,
        eventArticles,
        articleContacts
      ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules(
        [
          WritePropagation(
            on: TableUpdateQuery.onTableName('events',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('event_contacts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contacts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('event_contacts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('events',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('event_articles', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('articles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('event_articles', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('articles',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('article_contacts', kind: UpdateKind.delete),
            ],
          ),
          WritePropagation(
            on: TableUpdateQuery.onTableName('contacts',
                limitUpdateKind: UpdateKind.delete),
            result: [
              TableUpdate('article_contacts', kind: UpdateKind.delete),
            ],
          ),
        ],
      );
}

typedef $$UsersTableCreateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  required String firstName,
  required String lastName,
  required String email,
  Value<String?> photoUrl,
  Value<String> role,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> lastLoginAt,
});
typedef $$UsersTableUpdateCompanionBuilder = UsersCompanion Function({
  Value<int> id,
  Value<String> firstName,
  Value<String> lastName,
  Value<String> email,
  Value<String?> photoUrl,
  Value<String> role,
  Value<bool> isActive,
  Value<DateTime> createdAt,
  Value<DateTime?> lastLoginAt,
});

final class $$UsersTableReferences
    extends BaseReferences<_$AppDatabase, $UsersTable, User> {
  $$UsersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ContactsTable, List<Contact>> _contactsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.contacts,
          aliasName: $_aliasNameGenerator(db.users.id, db.contacts.userId));

  $$ContactsTableProcessedTableManager get contactsRefs {
    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_contactsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ArticlesTable, List<Article>> _articlesRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.articles,
          aliasName: $_aliasNameGenerator(db.users.id, db.articles.userId));

  $$ArticlesTableProcessedTableManager get articlesRefs {
    final manager = $$ArticlesTableTableManager($_db, $_db.articles)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_articlesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EventsTable, List<Event>> _eventsRefsTable(
          _$AppDatabase db) =>
      MultiTypedResultKey.fromTable(db.events,
          aliasName: $_aliasNameGenerator(db.users.id, db.events.userId));

  $$EventsTableProcessedTableManager get eventsRefs {
    final manager = $$EventsTableTableManager($_db, $_db.events)
        .filter((f) => f.userId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$UsersTableFilterComposer extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get lastLoginAt => $composableBuilder(
      column: $table.lastLoginAt, builder: (column) => ColumnFilters(column));

  Expression<bool> contactsRefs(
      Expression<bool> Function($$ContactsTableFilterComposer f) f) {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> articlesRefs(
      Expression<bool> Function($$ArticlesTableFilterComposer f) f) {
    final $$ArticlesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.articles,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticlesTableFilterComposer(
              $db: $db,
              $table: $db.articles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> eventsRefs(
      Expression<bool> Function($$EventsTableFilterComposer f) f) {
    final $$EventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableFilterComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableOrderingComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get role => $composableBuilder(
      column: $table.role, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isActive => $composableBuilder(
      column: $table.isActive, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get lastLoginAt => $composableBuilder(
      column: $table.lastLoginAt, builder: (column) => ColumnOrderings(column));
}

class $$UsersTableAnnotationComposer
    extends Composer<_$AppDatabase, $UsersTable> {
  $$UsersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get lastLoginAt => $composableBuilder(
      column: $table.lastLoginAt, builder: (column) => column);

  Expression<T> contactsRefs<T extends Object>(
      Expression<T> Function($$ContactsTableAnnotationComposer a) f) {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> articlesRefs<T extends Object>(
      Expression<T> Function($$ArticlesTableAnnotationComposer a) f) {
    final $$ArticlesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.articles,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticlesTableAnnotationComposer(
              $db: $db,
              $table: $db.articles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> eventsRefs<T extends Object>(
      Expression<T> Function($$EventsTableAnnotationComposer a) f) {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.userId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableAnnotationComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$UsersTableTableManager extends RootTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool contactsRefs, bool articlesRefs, bool eventsRefs})> {
  $$UsersTableTableManager(_$AppDatabase db, $UsersTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String> email = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastLoginAt = const Value.absent(),
          }) =>
              UsersCompanion(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            photoUrl: photoUrl,
            role: role,
            isActive: isActive,
            createdAt: createdAt,
            lastLoginAt: lastLoginAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required String firstName,
            required String lastName,
            required String email,
            Value<String?> photoUrl = const Value.absent(),
            Value<String> role = const Value.absent(),
            Value<bool> isActive = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<DateTime?> lastLoginAt = const Value.absent(),
          }) =>
              UsersCompanion.insert(
            id: id,
            firstName: firstName,
            lastName: lastName,
            email: email,
            photoUrl: photoUrl,
            role: role,
            isActive: isActive,
            createdAt: createdAt,
            lastLoginAt: lastLoginAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$UsersTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {contactsRefs = false,
              articlesRefs = false,
              eventsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (contactsRefs) db.contacts,
                if (articlesRefs) db.articles,
                if (eventsRefs) db.events
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (contactsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Contact>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._contactsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).contactsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (articlesRefs)
                    await $_getPrefetchedData<User, $UsersTable, Article>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._articlesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).articlesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items),
                  if (eventsRefs)
                    await $_getPrefetchedData<User, $UsersTable, Event>(
                        currentTable: table,
                        referencedTable:
                            $$UsersTableReferences._eventsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$UsersTableReferences(db, table, p0).eventsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.userId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$UsersTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $UsersTable,
    User,
    $$UsersTableFilterComposer,
    $$UsersTableOrderingComposer,
    $$UsersTableAnnotationComposer,
    $$UsersTableCreateCompanionBuilder,
    $$UsersTableUpdateCompanionBuilder,
    (User, $$UsersTableReferences),
    User,
    PrefetchHooks Function(
        {bool contactsRefs, bool articlesRefs, bool eventsRefs})>;
typedef $$ContactsTableCreateCompanionBuilder = ContactsCompanion Function({
  Value<int> id,
  Value<int?> userId,
  required String firstName,
  required String lastName,
  Value<String?> jobTitle,
  Value<String?> company,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> photoUrl,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<bool> isFavorite,
});
typedef $$ContactsTableUpdateCompanionBuilder = ContactsCompanion Function({
  Value<int> id,
  Value<int?> userId,
  Value<String> firstName,
  Value<String> lastName,
  Value<String?> jobTitle,
  Value<String?> company,
  Value<String?> email,
  Value<String?> phone,
  Value<String?> photoUrl,
  Value<String?> notes,
  Value<DateTime> createdAt,
  Value<bool> isFavorite,
});

final class $$ContactsTableReferences
    extends BaseReferences<_$AppDatabase, $ContactsTable, Contact> {
  $$ContactsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.contacts.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$EventContactsTable, List<EventContact>>
      _eventContactsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.eventContacts,
              aliasName: $_aliasNameGenerator(
                  db.contacts.id, db.eventContacts.contactId));

  $$EventContactsTableProcessedTableManager get eventContactsRefs {
    final manager = $$EventContactsTableTableManager($_db, $_db.eventContacts)
        .filter((f) => f.contactId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventContactsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ArticleContactsTable, List<ArticleContact>>
      _articleContactsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.articleContacts,
              aliasName: $_aliasNameGenerator(
                  db.contacts.id, db.articleContacts.contactId));

  $$ArticleContactsTableProcessedTableManager get articleContactsRefs {
    final manager =
        $$ArticleContactsTableTableManager($_db, $_db.articleContacts)
            .filter((f) => f.contactId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_articleContactsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get jobTitle => $composableBuilder(
      column: $table.jobTitle, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get company => $composableBuilder(
      column: $table.company, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> eventContactsRefs(
      Expression<bool> Function($$EventContactsTableFilterComposer f) f) {
    final $$EventContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.eventContacts,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventContactsTableFilterComposer(
              $db: $db,
              $table: $db.eventContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> articleContactsRefs(
      Expression<bool> Function($$ArticleContactsTableFilterComposer f) f) {
    final $$ArticleContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.articleContacts,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticleContactsTableFilterComposer(
              $db: $db,
              $table: $db.articleContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get firstName => $composableBuilder(
      column: $table.firstName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get lastName => $composableBuilder(
      column: $table.lastName, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get jobTitle => $composableBuilder(
      column: $table.jobTitle, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get company => $composableBuilder(
      column: $table.company, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get email => $composableBuilder(
      column: $table.email, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get phone => $composableBuilder(
      column: $table.phone, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get photoUrl => $composableBuilder(
      column: $table.photoUrl, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get notes => $composableBuilder(
      column: $table.notes, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ContactsTable> {
  $$ContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get firstName =>
      $composableBuilder(column: $table.firstName, builder: (column) => column);

  GeneratedColumn<String> get lastName =>
      $composableBuilder(column: $table.lastName, builder: (column) => column);

  GeneratedColumn<String> get jobTitle =>
      $composableBuilder(column: $table.jobTitle, builder: (column) => column);

  GeneratedColumn<String> get company =>
      $composableBuilder(column: $table.company, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get phone =>
      $composableBuilder(column: $table.phone, builder: (column) => column);

  GeneratedColumn<String> get photoUrl =>
      $composableBuilder(column: $table.photoUrl, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isFavorite => $composableBuilder(
      column: $table.isFavorite, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> eventContactsRefs<T extends Object>(
      Expression<T> Function($$EventContactsTableAnnotationComposer a) f) {
    final $$EventContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.eventContacts,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.eventContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> articleContactsRefs<T extends Object>(
      Expression<T> Function($$ArticleContactsTableAnnotationComposer a) f) {
    final $$ArticleContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.articleContacts,
        getReferencedColumn: (t) => t.contactId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticleContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.articleContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ContactsTable,
    Contact,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (Contact, $$ContactsTableReferences),
    Contact,
    PrefetchHooks Function(
        {bool userId, bool eventContactsRefs, bool articleContactsRefs})> {
  $$ContactsTableTableManager(_$AppDatabase db, $ContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            Value<String> firstName = const Value.absent(),
            Value<String> lastName = const Value.absent(),
            Value<String?> jobTitle = const Value.absent(),
            Value<String?> company = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
          }) =>
              ContactsCompanion(
            id: id,
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            jobTitle: jobTitle,
            company: company,
            email: email,
            phone: phone,
            photoUrl: photoUrl,
            notes: notes,
            createdAt: createdAt,
            isFavorite: isFavorite,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            required String firstName,
            required String lastName,
            Value<String?> jobTitle = const Value.absent(),
            Value<String?> company = const Value.absent(),
            Value<String?> email = const Value.absent(),
            Value<String?> phone = const Value.absent(),
            Value<String?> photoUrl = const Value.absent(),
            Value<String?> notes = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isFavorite = const Value.absent(),
          }) =>
              ContactsCompanion.insert(
            id: id,
            userId: userId,
            firstName: firstName,
            lastName: lastName,
            jobTitle: jobTitle,
            company: company,
            email: email,
            phone: phone,
            photoUrl: photoUrl,
            notes: notes,
            createdAt: createdAt,
            isFavorite: isFavorite,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ContactsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {userId = false,
              eventContactsRefs = false,
              articleContactsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (eventContactsRefs) db.eventContacts,
                if (articleContactsRefs) db.articleContacts
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$ContactsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$ContactsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventContactsRefs)
                    await $_getPrefetchedData<Contact, $ContactsTable,
                            EventContact>(
                        currentTable: table,
                        referencedTable: $$ContactsTableReferences
                            ._eventContactsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactsTableReferences(db, table, p0)
                                .eventContactsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contactId == item.id),
                        typedResults: items),
                  if (articleContactsRefs)
                    await $_getPrefetchedData<Contact, $ContactsTable,
                            ArticleContact>(
                        currentTable: table,
                        referencedTable: $$ContactsTableReferences
                            ._articleContactsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ContactsTableReferences(db, table, p0)
                                .articleContactsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.contactId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ContactsTable,
    Contact,
    $$ContactsTableFilterComposer,
    $$ContactsTableOrderingComposer,
    $$ContactsTableAnnotationComposer,
    $$ContactsTableCreateCompanionBuilder,
    $$ContactsTableUpdateCompanionBuilder,
    (Contact, $$ContactsTableReferences),
    Contact,
    PrefetchHooks Function(
        {bool userId, bool eventContactsRefs, bool articleContactsRefs})>;
typedef $$ArticlesTableCreateCompanionBuilder = ArticlesCompanion Function({
  Value<int> id,
  Value<int?> userId,
  required String title,
  required String source,
  Value<String?> url,
  Value<String?> summary,
  Value<DateTime> date,
  Value<String?> tags,
  Value<bool> isLocal,
  Value<DateTime> createdAt,
});
typedef $$ArticlesTableUpdateCompanionBuilder = ArticlesCompanion Function({
  Value<int> id,
  Value<int?> userId,
  Value<String> title,
  Value<String> source,
  Value<String?> url,
  Value<String?> summary,
  Value<DateTime> date,
  Value<String?> tags,
  Value<bool> isLocal,
  Value<DateTime> createdAt,
});

final class $$ArticlesTableReferences
    extends BaseReferences<_$AppDatabase, $ArticlesTable, Article> {
  $$ArticlesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) => db.users
      .createAlias($_aliasNameGenerator(db.articles.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$EventArticlesTable, List<EventArticle>>
      _eventArticlesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.eventArticles,
              aliasName: $_aliasNameGenerator(
                  db.articles.id, db.eventArticles.articleId));

  $$EventArticlesTableProcessedTableManager get eventArticlesRefs {
    final manager = $$EventArticlesTableTableManager($_db, $_db.eventArticles)
        .filter((f) => f.articleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventArticlesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$ArticleContactsTable, List<ArticleContact>>
      _articleContactsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.articleContacts,
              aliasName: $_aliasNameGenerator(
                  db.articles.id, db.articleContacts.articleId));

  $$ArticleContactsTableProcessedTableManager get articleContactsRefs {
    final manager =
        $$ArticleContactsTableTableManager($_db, $_db.articleContacts)
            .filter((f) => f.articleId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache =
        $_typedResult.readTableOrNull(_articleContactsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$ArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isLocal => $composableBuilder(
      column: $table.isLocal, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> eventArticlesRefs(
      Expression<bool> Function($$EventArticlesTableFilterComposer f) f) {
    final $$EventArticlesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.eventArticles,
        getReferencedColumn: (t) => t.articleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventArticlesTableFilterComposer(
              $db: $db,
              $table: $db.eventArticles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> articleContactsRefs(
      Expression<bool> Function($$ArticleContactsTableFilterComposer f) f) {
    final $$ArticleContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.articleContacts,
        getReferencedColumn: (t) => t.articleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticleContactsTableFilterComposer(
              $db: $db,
              $table: $db.articleContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get source => $composableBuilder(
      column: $table.source, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get url => $composableBuilder(
      column: $table.url, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get summary => $composableBuilder(
      column: $table.summary, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get date => $composableBuilder(
      column: $table.date, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get tags => $composableBuilder(
      column: $table.tags, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isLocal => $composableBuilder(
      column: $table.isLocal, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get url =>
      $composableBuilder(column: $table.url, builder: (column) => column);

  GeneratedColumn<String> get summary =>
      $composableBuilder(column: $table.summary, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<String> get tags =>
      $composableBuilder(column: $table.tags, builder: (column) => column);

  GeneratedColumn<bool> get isLocal =>
      $composableBuilder(column: $table.isLocal, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> eventArticlesRefs<T extends Object>(
      Expression<T> Function($$EventArticlesTableAnnotationComposer a) f) {
    final $$EventArticlesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.eventArticles,
        getReferencedColumn: (t) => t.articleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventArticlesTableAnnotationComposer(
              $db: $db,
              $table: $db.eventArticles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> articleContactsRefs<T extends Object>(
      Expression<T> Function($$ArticleContactsTableAnnotationComposer a) f) {
    final $$ArticleContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.articleContacts,
        getReferencedColumn: (t) => t.articleId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticleContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.articleContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$ArticlesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ArticlesTable,
    Article,
    $$ArticlesTableFilterComposer,
    $$ArticlesTableOrderingComposer,
    $$ArticlesTableAnnotationComposer,
    $$ArticlesTableCreateCompanionBuilder,
    $$ArticlesTableUpdateCompanionBuilder,
    (Article, $$ArticlesTableReferences),
    Article,
    PrefetchHooks Function(
        {bool userId, bool eventArticlesRefs, bool articleContactsRefs})> {
  $$ArticlesTableTableManager(_$AppDatabase db, $ArticlesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String> source = const Value.absent(),
            Value<String?> url = const Value.absent(),
            Value<String?> summary = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<bool> isLocal = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ArticlesCompanion(
            id: id,
            userId: userId,
            title: title,
            source: source,
            url: url,
            summary: summary,
            date: date,
            tags: tags,
            isLocal: isLocal,
            createdAt: createdAt,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            required String title,
            required String source,
            Value<String?> url = const Value.absent(),
            Value<String?> summary = const Value.absent(),
            Value<DateTime> date = const Value.absent(),
            Value<String?> tags = const Value.absent(),
            Value<bool> isLocal = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
          }) =>
              ArticlesCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            source: source,
            url: url,
            summary: summary,
            date: date,
            tags: tags,
            isLocal: isLocal,
            createdAt: createdAt,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$ArticlesTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {userId = false,
              eventArticlesRefs = false,
              articleContactsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (eventArticlesRefs) db.eventArticles,
                if (articleContactsRefs) db.articleContacts
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$ArticlesTableReferences._userIdTable(db),
                    referencedColumn:
                        $$ArticlesTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventArticlesRefs)
                    await $_getPrefetchedData<Article, $ArticlesTable,
                            EventArticle>(
                        currentTable: table,
                        referencedTable: $$ArticlesTableReferences
                            ._eventArticlesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ArticlesTableReferences(db, table, p0)
                                .eventArticlesRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.articleId == item.id),
                        typedResults: items),
                  if (articleContactsRefs)
                    await $_getPrefetchedData<Article, $ArticlesTable,
                            ArticleContact>(
                        currentTable: table,
                        referencedTable: $$ArticlesTableReferences
                            ._articleContactsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$ArticlesTableReferences(db, table, p0)
                                .articleContactsRefs,
                        referencedItemsForCurrentItem:
                            (item, referencedItems) => referencedItems
                                .where((e) => e.articleId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$ArticlesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ArticlesTable,
    Article,
    $$ArticlesTableFilterComposer,
    $$ArticlesTableOrderingComposer,
    $$ArticlesTableAnnotationComposer,
    $$ArticlesTableCreateCompanionBuilder,
    $$ArticlesTableUpdateCompanionBuilder,
    (Article, $$ArticlesTableReferences),
    Article,
    PrefetchHooks Function(
        {bool userId, bool eventArticlesRefs, bool articleContactsRefs})>;
typedef $$EventsTableCreateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  Value<int?> userId,
  required String title,
  Value<String?> description,
  required DateTime startDate,
  required DateTime endDate,
  Value<String?> location,
  Value<DateTime> createdAt,
  Value<bool> isAllDay,
});
typedef $$EventsTableUpdateCompanionBuilder = EventsCompanion Function({
  Value<int> id,
  Value<int?> userId,
  Value<String> title,
  Value<String?> description,
  Value<DateTime> startDate,
  Value<DateTime> endDate,
  Value<String?> location,
  Value<DateTime> createdAt,
  Value<bool> isAllDay,
});

final class $$EventsTableReferences
    extends BaseReferences<_$AppDatabase, $EventsTable, Event> {
  $$EventsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsersTable _userIdTable(_$AppDatabase db) =>
      db.users.createAlias($_aliasNameGenerator(db.events.userId, db.users.id));

  $$UsersTableProcessedTableManager? get userId {
    final $_column = $_itemColumn<int>('user_id');
    if ($_column == null) return null;
    final manager = $$UsersTableTableManager($_db, $_db.users)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_userIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static MultiTypedResultKey<$EventContactsTable, List<EventContact>>
      _eventContactsRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.eventContacts,
              aliasName:
                  $_aliasNameGenerator(db.events.id, db.eventContacts.eventId));

  $$EventContactsTableProcessedTableManager get eventContactsRefs {
    final manager = $$EventContactsTableTableManager($_db, $_db.eventContacts)
        .filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventContactsRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }

  static MultiTypedResultKey<$EventArticlesTable, List<EventArticle>>
      _eventArticlesRefsTable(_$AppDatabase db) =>
          MultiTypedResultKey.fromTable(db.eventArticles,
              aliasName:
                  $_aliasNameGenerator(db.events.id, db.eventArticles.eventId));

  $$EventArticlesTableProcessedTableManager get eventArticlesRefs {
    final manager = $$EventArticlesTableTableManager($_db, $_db.eventArticles)
        .filter((f) => f.eventId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_eventArticlesRefsTable($_db));
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: cache));
  }
}

class $$EventsTableFilterComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnFilters(column));

  ColumnFilters<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnFilters(column));

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnFilters(column));

  ColumnFilters<bool> get isAllDay => $composableBuilder(
      column: $table.isAllDay, builder: (column) => ColumnFilters(column));

  $$UsersTableFilterComposer get userId {
    final $$UsersTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableFilterComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<bool> eventContactsRefs(
      Expression<bool> Function($$EventContactsTableFilterComposer f) f) {
    final $$EventContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.eventContacts,
        getReferencedColumn: (t) => t.eventId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventContactsTableFilterComposer(
              $db: $db,
              $table: $db.eventContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<bool> eventArticlesRefs(
      Expression<bool> Function($$EventArticlesTableFilterComposer f) f) {
    final $$EventArticlesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.eventArticles,
        getReferencedColumn: (t) => t.eventId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventArticlesTableFilterComposer(
              $db: $db,
              $table: $db.eventArticles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EventsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get title => $composableBuilder(
      column: $table.title, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get startDate => $composableBuilder(
      column: $table.startDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get endDate => $composableBuilder(
      column: $table.endDate, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<String> get location => $composableBuilder(
      column: $table.location, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
      column: $table.createdAt, builder: (column) => ColumnOrderings(column));

  ColumnOrderings<bool> get isAllDay => $composableBuilder(
      column: $table.isAllDay, builder: (column) => ColumnOrderings(column));

  $$UsersTableOrderingComposer get userId {
    final $$UsersTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableOrderingComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventsTable> {
  $$EventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
      column: $table.description, builder: (column) => column);

  GeneratedColumn<DateTime> get startDate =>
      $composableBuilder(column: $table.startDate, builder: (column) => column);

  GeneratedColumn<DateTime> get endDate =>
      $composableBuilder(column: $table.endDate, builder: (column) => column);

  GeneratedColumn<String> get location =>
      $composableBuilder(column: $table.location, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<bool> get isAllDay =>
      $composableBuilder(column: $table.isAllDay, builder: (column) => column);

  $$UsersTableAnnotationComposer get userId {
    final $$UsersTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.userId,
        referencedTable: $db.users,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$UsersTableAnnotationComposer(
              $db: $db,
              $table: $db.users,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  Expression<T> eventContactsRefs<T extends Object>(
      Expression<T> Function($$EventContactsTableAnnotationComposer a) f) {
    final $$EventContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.eventContacts,
        getReferencedColumn: (t) => t.eventId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.eventContacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }

  Expression<T> eventArticlesRefs<T extends Object>(
      Expression<T> Function($$EventArticlesTableAnnotationComposer a) f) {
    final $$EventArticlesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.id,
        referencedTable: $db.eventArticles,
        getReferencedColumn: (t) => t.eventId,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventArticlesTableAnnotationComposer(
              $db: $db,
              $table: $db.eventArticles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return f(composer);
  }
}

class $$EventsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, $$EventsTableReferences),
    Event,
    PrefetchHooks Function(
        {bool userId, bool eventContactsRefs, bool eventArticlesRefs})> {
  $$EventsTableTableManager(_$AppDatabase db, $EventsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            Value<String> title = const Value.absent(),
            Value<String?> description = const Value.absent(),
            Value<DateTime> startDate = const Value.absent(),
            Value<DateTime> endDate = const Value.absent(),
            Value<String?> location = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isAllDay = const Value.absent(),
          }) =>
              EventsCompanion(
            id: id,
            userId: userId,
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate,
            location: location,
            createdAt: createdAt,
            isAllDay: isAllDay,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int?> userId = const Value.absent(),
            required String title,
            Value<String?> description = const Value.absent(),
            required DateTime startDate,
            required DateTime endDate,
            Value<String?> location = const Value.absent(),
            Value<DateTime> createdAt = const Value.absent(),
            Value<bool> isAllDay = const Value.absent(),
          }) =>
              EventsCompanion.insert(
            id: id,
            userId: userId,
            title: title,
            description: description,
            startDate: startDate,
            endDate: endDate,
            location: location,
            createdAt: createdAt,
            isAllDay: isAllDay,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) =>
                  (e.readTable(table), $$EventsTableReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: (
              {userId = false,
              eventContactsRefs = false,
              eventArticlesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (eventContactsRefs) db.eventContacts,
                if (eventArticlesRefs) db.eventArticles
              ],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (userId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.userId,
                    referencedTable: $$EventsTableReferences._userIdTable(db),
                    referencedColumn:
                        $$EventsTableReferences._userIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (eventContactsRefs)
                    await $_getPrefetchedData<Event, $EventsTable,
                            EventContact>(
                        currentTable: table,
                        referencedTable:
                            $$EventsTableReferences._eventContactsRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EventsTableReferences(db, table, p0)
                                .eventContactsRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.eventId == item.id),
                        typedResults: items),
                  if (eventArticlesRefs)
                    await $_getPrefetchedData<Event, $EventsTable,
                            EventArticle>(
                        currentTable: table,
                        referencedTable:
                            $$EventsTableReferences._eventArticlesRefsTable(db),
                        managerFromTypedResult: (p0) =>
                            $$EventsTableReferences(db, table, p0)
                                .eventArticlesRefs,
                        referencedItemsForCurrentItem: (item,
                                referencedItems) =>
                            referencedItems.where((e) => e.eventId == item.id),
                        typedResults: items)
                ];
              },
            );
          },
        ));
}

typedef $$EventsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EventsTable,
    Event,
    $$EventsTableFilterComposer,
    $$EventsTableOrderingComposer,
    $$EventsTableAnnotationComposer,
    $$EventsTableCreateCompanionBuilder,
    $$EventsTableUpdateCompanionBuilder,
    (Event, $$EventsTableReferences),
    Event,
    PrefetchHooks Function(
        {bool userId, bool eventContactsRefs, bool eventArticlesRefs})>;
typedef $$EventContactsTableCreateCompanionBuilder = EventContactsCompanion
    Function({
  Value<int> id,
  required int eventId,
  required int contactId,
});
typedef $$EventContactsTableUpdateCompanionBuilder = EventContactsCompanion
    Function({
  Value<int> id,
  Value<int> eventId,
  Value<int> contactId,
});

final class $$EventContactsTableReferences
    extends BaseReferences<_$AppDatabase, $EventContactsTable, EventContact> {
  $$EventContactsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
      $_aliasNameGenerator(db.eventContacts.eventId, db.events.id));

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventsTableTableManager($_db, $_db.events)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ContactsTable _contactIdTable(_$AppDatabase db) =>
      db.contacts.createAlias(
          $_aliasNameGenerator(db.eventContacts.contactId, db.contacts.id));

  $$ContactsTableProcessedTableManager get contactId {
    final $_column = $_itemColumn<int>('contact_id')!;

    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EventContactsTableFilterComposer
    extends Composer<_$AppDatabase, $EventContactsTable> {
  $$EventContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableFilterComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableFilterComposer get contactId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $EventContactsTable> {
  $$EventContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableOrderingComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableOrderingComposer get contactId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableOrderingComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventContactsTable> {
  $$EventContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableAnnotationComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableAnnotationComposer get contactId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EventContactsTable,
    EventContact,
    $$EventContactsTableFilterComposer,
    $$EventContactsTableOrderingComposer,
    $$EventContactsTableAnnotationComposer,
    $$EventContactsTableCreateCompanionBuilder,
    $$EventContactsTableUpdateCompanionBuilder,
    (EventContact, $$EventContactsTableReferences),
    EventContact,
    PrefetchHooks Function({bool eventId, bool contactId})> {
  $$EventContactsTableTableManager(_$AppDatabase db, $EventContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> eventId = const Value.absent(),
            Value<int> contactId = const Value.absent(),
          }) =>
              EventContactsCompanion(
            id: id,
            eventId: eventId,
            contactId: contactId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int eventId,
            required int contactId,
          }) =>
              EventContactsCompanion.insert(
            id: id,
            eventId: eventId,
            contactId: contactId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EventContactsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({eventId = false, contactId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (eventId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.eventId,
                    referencedTable:
                        $$EventContactsTableReferences._eventIdTable(db),
                    referencedColumn:
                        $$EventContactsTableReferences._eventIdTable(db).id,
                  ) as T;
                }
                if (contactId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contactId,
                    referencedTable:
                        $$EventContactsTableReferences._contactIdTable(db),
                    referencedColumn:
                        $$EventContactsTableReferences._contactIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EventContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EventContactsTable,
    EventContact,
    $$EventContactsTableFilterComposer,
    $$EventContactsTableOrderingComposer,
    $$EventContactsTableAnnotationComposer,
    $$EventContactsTableCreateCompanionBuilder,
    $$EventContactsTableUpdateCompanionBuilder,
    (EventContact, $$EventContactsTableReferences),
    EventContact,
    PrefetchHooks Function({bool eventId, bool contactId})>;
typedef $$EventArticlesTableCreateCompanionBuilder = EventArticlesCompanion
    Function({
  Value<int> id,
  required int eventId,
  required int articleId,
});
typedef $$EventArticlesTableUpdateCompanionBuilder = EventArticlesCompanion
    Function({
  Value<int> id,
  Value<int> eventId,
  Value<int> articleId,
});

final class $$EventArticlesTableReferences
    extends BaseReferences<_$AppDatabase, $EventArticlesTable, EventArticle> {
  $$EventArticlesTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $EventsTable _eventIdTable(_$AppDatabase db) => db.events.createAlias(
      $_aliasNameGenerator(db.eventArticles.eventId, db.events.id));

  $$EventsTableProcessedTableManager get eventId {
    final $_column = $_itemColumn<int>('event_id')!;

    final manager = $$EventsTableTableManager($_db, $_db.events)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_eventIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ArticlesTable _articleIdTable(_$AppDatabase db) =>
      db.articles.createAlias(
          $_aliasNameGenerator(db.eventArticles.articleId, db.articles.id));

  $$ArticlesTableProcessedTableManager get articleId {
    final $_column = $_itemColumn<int>('article_id')!;

    final manager = $$ArticlesTableTableManager($_db, $_db.articles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_articleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$EventArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $EventArticlesTable> {
  $$EventArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$EventsTableFilterComposer get eventId {
    final $$EventsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableFilterComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ArticlesTableFilterComposer get articleId {
    final $$ArticlesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.articleId,
        referencedTable: $db.articles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticlesTableFilterComposer(
              $db: $db,
              $table: $db.articles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $EventArticlesTable> {
  $$EventArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$EventsTableOrderingComposer get eventId {
    final $$EventsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableOrderingComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ArticlesTableOrderingComposer get articleId {
    final $$ArticlesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.articleId,
        referencedTable: $db.articles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticlesTableOrderingComposer(
              $db: $db,
              $table: $db.articles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $EventArticlesTable> {
  $$EventArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$EventsTableAnnotationComposer get eventId {
    final $$EventsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.eventId,
        referencedTable: $db.events,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$EventsTableAnnotationComposer(
              $db: $db,
              $table: $db.events,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ArticlesTableAnnotationComposer get articleId {
    final $$ArticlesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.articleId,
        referencedTable: $db.articles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticlesTableAnnotationComposer(
              $db: $db,
              $table: $db.articles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$EventArticlesTableTableManager extends RootTableManager<
    _$AppDatabase,
    $EventArticlesTable,
    EventArticle,
    $$EventArticlesTableFilterComposer,
    $$EventArticlesTableOrderingComposer,
    $$EventArticlesTableAnnotationComposer,
    $$EventArticlesTableCreateCompanionBuilder,
    $$EventArticlesTableUpdateCompanionBuilder,
    (EventArticle, $$EventArticlesTableReferences),
    EventArticle,
    PrefetchHooks Function({bool eventId, bool articleId})> {
  $$EventArticlesTableTableManager(_$AppDatabase db, $EventArticlesTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EventArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EventArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EventArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> eventId = const Value.absent(),
            Value<int> articleId = const Value.absent(),
          }) =>
              EventArticlesCompanion(
            id: id,
            eventId: eventId,
            articleId: articleId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int eventId,
            required int articleId,
          }) =>
              EventArticlesCompanion.insert(
            id: id,
            eventId: eventId,
            articleId: articleId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$EventArticlesTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({eventId = false, articleId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (eventId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.eventId,
                    referencedTable:
                        $$EventArticlesTableReferences._eventIdTable(db),
                    referencedColumn:
                        $$EventArticlesTableReferences._eventIdTable(db).id,
                  ) as T;
                }
                if (articleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.articleId,
                    referencedTable:
                        $$EventArticlesTableReferences._articleIdTable(db),
                    referencedColumn:
                        $$EventArticlesTableReferences._articleIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$EventArticlesTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $EventArticlesTable,
    EventArticle,
    $$EventArticlesTableFilterComposer,
    $$EventArticlesTableOrderingComposer,
    $$EventArticlesTableAnnotationComposer,
    $$EventArticlesTableCreateCompanionBuilder,
    $$EventArticlesTableUpdateCompanionBuilder,
    (EventArticle, $$EventArticlesTableReferences),
    EventArticle,
    PrefetchHooks Function({bool eventId, bool articleId})>;
typedef $$ArticleContactsTableCreateCompanionBuilder = ArticleContactsCompanion
    Function({
  Value<int> id,
  required int articleId,
  required int contactId,
});
typedef $$ArticleContactsTableUpdateCompanionBuilder = ArticleContactsCompanion
    Function({
  Value<int> id,
  Value<int> articleId,
  Value<int> contactId,
});

final class $$ArticleContactsTableReferences extends BaseReferences<
    _$AppDatabase, $ArticleContactsTable, ArticleContact> {
  $$ArticleContactsTableReferences(
      super.$_db, super.$_table, super.$_typedResult);

  static $ArticlesTable _articleIdTable(_$AppDatabase db) =>
      db.articles.createAlias(
          $_aliasNameGenerator(db.articleContacts.articleId, db.articles.id));

  $$ArticlesTableProcessedTableManager get articleId {
    final $_column = $_itemColumn<int>('article_id')!;

    final manager = $$ArticlesTableTableManager($_db, $_db.articles)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_articleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }

  static $ContactsTable _contactIdTable(_$AppDatabase db) =>
      db.contacts.createAlias(
          $_aliasNameGenerator(db.articleContacts.contactId, db.contacts.id));

  $$ContactsTableProcessedTableManager get contactId {
    final $_column = $_itemColumn<int>('contact_id')!;

    final manager = $$ContactsTableTableManager($_db, $_db.contacts)
        .filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_contactIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
        manager.$state.copyWith(prefetchedData: [item]));
  }
}

class $$ArticleContactsTableFilterComposer
    extends Composer<_$AppDatabase, $ArticleContactsTable> {
  $$ArticleContactsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnFilters(column));

  $$ArticlesTableFilterComposer get articleId {
    final $$ArticlesTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.articleId,
        referencedTable: $db.articles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticlesTableFilterComposer(
              $db: $db,
              $table: $db.articles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableFilterComposer get contactId {
    final $$ContactsTableFilterComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableFilterComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ArticleContactsTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticleContactsTable> {
  $$ArticleContactsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
      column: $table.id, builder: (column) => ColumnOrderings(column));

  $$ArticlesTableOrderingComposer get articleId {
    final $$ArticlesTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.articleId,
        referencedTable: $db.articles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticlesTableOrderingComposer(
              $db: $db,
              $table: $db.articles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableOrderingComposer get contactId {
    final $$ContactsTableOrderingComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableOrderingComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ArticleContactsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticleContactsTable> {
  $$ArticleContactsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  $$ArticlesTableAnnotationComposer get articleId {
    final $$ArticlesTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.articleId,
        referencedTable: $db.articles,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ArticlesTableAnnotationComposer(
              $db: $db,
              $table: $db.articles,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }

  $$ContactsTableAnnotationComposer get contactId {
    final $$ContactsTableAnnotationComposer composer = $composerBuilder(
        composer: this,
        getCurrentColumn: (t) => t.contactId,
        referencedTable: $db.contacts,
        getReferencedColumn: (t) => t.id,
        builder: (joinBuilder,
                {$addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer}) =>
            $$ContactsTableAnnotationComposer(
              $db: $db,
              $table: $db.contacts,
              $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
              joinBuilder: joinBuilder,
              $removeJoinBuilderFromRootComposer:
                  $removeJoinBuilderFromRootComposer,
            ));
    return composer;
  }
}

class $$ArticleContactsTableTableManager extends RootTableManager<
    _$AppDatabase,
    $ArticleContactsTable,
    ArticleContact,
    $$ArticleContactsTableFilterComposer,
    $$ArticleContactsTableOrderingComposer,
    $$ArticleContactsTableAnnotationComposer,
    $$ArticleContactsTableCreateCompanionBuilder,
    $$ArticleContactsTableUpdateCompanionBuilder,
    (ArticleContact, $$ArticleContactsTableReferences),
    ArticleContact,
    PrefetchHooks Function({bool articleId, bool contactId})> {
  $$ArticleContactsTableTableManager(
      _$AppDatabase db, $ArticleContactsTable table)
      : super(TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticleContactsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArticleContactsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArticleContactsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<int> id = const Value.absent(),
            Value<int> articleId = const Value.absent(),
            Value<int> contactId = const Value.absent(),
          }) =>
              ArticleContactsCompanion(
            id: id,
            articleId: articleId,
            contactId: contactId,
          ),
          createCompanionCallback: ({
            Value<int> id = const Value.absent(),
            required int articleId,
            required int contactId,
          }) =>
              ArticleContactsCompanion.insert(
            id: id,
            articleId: articleId,
            contactId: contactId,
          ),
          withReferenceMapper: (p0) => p0
              .map((e) => (
                    e.readTable(table),
                    $$ArticleContactsTableReferences(db, table, e)
                  ))
              .toList(),
          prefetchHooksCallback: ({articleId = false, contactId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins: <
                  T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic>>(state) {
                if (articleId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.articleId,
                    referencedTable:
                        $$ArticleContactsTableReferences._articleIdTable(db),
                    referencedColumn:
                        $$ArticleContactsTableReferences._articleIdTable(db).id,
                  ) as T;
                }
                if (contactId) {
                  state = state.withJoin(
                    currentTable: table,
                    currentColumn: table.contactId,
                    referencedTable:
                        $$ArticleContactsTableReferences._contactIdTable(db),
                    referencedColumn:
                        $$ArticleContactsTableReferences._contactIdTable(db).id,
                  ) as T;
                }

                return state;
              },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ));
}

typedef $$ArticleContactsTableProcessedTableManager = ProcessedTableManager<
    _$AppDatabase,
    $ArticleContactsTable,
    ArticleContact,
    $$ArticleContactsTableFilterComposer,
    $$ArticleContactsTableOrderingComposer,
    $$ArticleContactsTableAnnotationComposer,
    $$ArticleContactsTableCreateCompanionBuilder,
    $$ArticleContactsTableUpdateCompanionBuilder,
    (ArticleContact, $$ArticleContactsTableReferences),
    ArticleContact,
    PrefetchHooks Function({bool articleId, bool contactId})>;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UsersTableTableManager get users =>
      $$UsersTableTableManager(_db, _db.users);
  $$ContactsTableTableManager get contacts =>
      $$ContactsTableTableManager(_db, _db.contacts);
  $$ArticlesTableTableManager get articles =>
      $$ArticlesTableTableManager(_db, _db.articles);
  $$EventsTableTableManager get events =>
      $$EventsTableTableManager(_db, _db.events);
  $$EventContactsTableTableManager get eventContacts =>
      $$EventContactsTableTableManager(_db, _db.eventContacts);
  $$EventArticlesTableTableManager get eventArticles =>
      $$EventArticlesTableTableManager(_db, _db.eventArticles);
  $$ArticleContactsTableTableManager get articleContacts =>
      $$ArticleContactsTableTableManager(_db, _db.articleContacts);
}
