// To parse this JSON data, do
//
//     final laywerModel = laywerModelFromMap(jsonString);

import 'dart:convert';

class LaywerModel {
  LaywerModel({
    this.records,
    this.message,
  });

  Records? records;
  String? message;

  factory LaywerModel.fromJson(String str) =>
      LaywerModel.fromMap(json.decode(str));

  factory LaywerModel.fromMap(Map<String, dynamic> json) => LaywerModel(
        records: Records.fromMap(json["records"]),
        message: json["message"],
      );
}

class Records {
  Records({
    this.id,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
    this.firstName,
    this.lastName,
    this.mobile,
    this.isPhoneVerified,
    this.isEmailVerified,
    this.verificationPhoneCode,
    this.verificationEmailCode,
    this.roles,
    this.categories,
    this.scheduleTimings,
    this.profile,
    this.languages,
    this.districts,
    this.queries,
  });

  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  DateTime? updatedAt;
  String? firstName;
  String? lastName;
  String? mobile;
  int? isPhoneVerified;
  int? isEmailVerified;
  String? verificationPhoneCode;
  String? verificationEmailCode;
  List<Role>? roles;
  List<CategoryElement>? categories;
  ScheduleTimings? scheduleTimings;
  Profile? profile;
  List<LanguageElement>? languages;
  List<District>? districts;
  Queries? queries;

  factory Records.fromJson(String str) => Records.fromMap(json.decode(str));

  factory Records.fromMap(Map<String, dynamic> json) => Records(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        emailVerifiedAt: json["email_verified_at"],
        createdAt: json["created_at"],
        updatedAt: DateTime.parse(json["updated_at"]),
        firstName: json["first_name"],
        lastName: json["last_name"],
        mobile: json["mobile"],
        isPhoneVerified: json["is_phone_verified"],
        isEmailVerified: json["is_email_verified"],
        verificationPhoneCode: json["verification_phone_code"],
        verificationEmailCode: json["verification_email_code"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromMap(x))),
        categories: List<CategoryElement>.from(
            json["categories"].map((x) => CategoryElement.fromMap(x))),
        scheduleTimings: ScheduleTimings.fromMap(json["schedule_timings"]),
        profile: Profile.fromMap(json["profile"]),
        languages: List<LanguageElement>.from(
            json["languages"].map((x) => LanguageElement.fromMap(x))),
        districts: List<District>.from(
            json["districts"].map((x) => District.fromMap(x))),
        queries: Queries.fromMap(json["queries"]),
      );
}

class CategoryElement {
  CategoryElement({
    this.id,
    this.userId,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  int? id;
  int? userId;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  CategoryCategory? category;

  factory CategoryElement.fromJson(String str) =>
      CategoryElement.fromMap(json.decode(str));

  factory CategoryElement.fromMap(Map<String, dynamic> json) => CategoryElement(
        id: json["id"],
        userId: json["user_id"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        category: CategoryCategory.fromMap(json["category"]),
      );
}

class CategoryCategory {
  CategoryCategory({
    this.id,
    this.name,
    this.isActive,
    this.createdAt,
    this.updatedAt,
    this.parentCategoryId,
  });

  int? id;
  String? name;
  int? isActive;
  String? createdAt;
  String? updatedAt;
  String? parentCategoryId;

  factory CategoryCategory.fromJson(String str) =>
      CategoryCategory.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory CategoryCategory.fromMap(Map<String, dynamic> json) =>
      CategoryCategory(
        id: json["id"],
        name: json["name"],
        isActive: json["is_active"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        parentCategoryId: json["parent_category_id"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "is_active": isActive,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "parent_category_id": parentCategoryId,
      };
}

class District {
  District({
    this.id,
    this.userId,
    this.districtId,
    this.district,
  });

  int? id;
  int? userId;
  int? districtId;
  City? district;

  factory District.fromJson(String str) => District.fromMap(json.decode(str));

  factory District.fromMap(Map<String, dynamic> json) => District(
        id: json["id"],
        userId: json["user_id"],
        districtId: json["district_id"],
        district: City.fromMap(json["district"]),
      );
}

class City {
  City({
    this.id,
    this.divisionId,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.provinceId,
    this.code,
    this.countryId,
  });

  int? id;
  int? divisionId;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? provinceId;
  String? code;
  int? countryId;

  factory City.fromJson(String str) => City.fromMap(json.decode(str));

  factory City.fromMap(Map<String, dynamic> json) => City(
        id: json["id"],
        divisionId: json["division_id"] == null ? null : json["division_id"],
        name: json["name"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        provinceId: json["province_id"] == null ? null : json["province_id"],
        code: json["code"] == null ? null : json["code"],
        countryId: json["country_id"] == null ? null : json["country_id"],
      );
}

class LanguageElement {
  LanguageElement({
    this.id,
    this.userId,
    this.languageId,
    this.language,
  });

  int? id;
  int? userId;
  int? languageId;
  LanguageLanguage? language;

  factory LanguageElement.fromJson(String str) =>
      LanguageElement.fromMap(json.decode(str));

  factory LanguageElement.fromMap(Map<String, dynamic> json) => LanguageElement(
        id: json["id"],
        userId: json["user_id"],
        languageId: json["language_id"],
        language: LanguageLanguage.fromMap(json["language"]),
      );
}

class LanguageLanguage {
  LanguageLanguage({
    this.id,
    this.name,
  });

  int? id;
  String? name;

  factory LanguageLanguage.fromJson(String str) =>
      LanguageLanguage.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory LanguageLanguage.fromMap(Map<String, dynamic> json) =>
      LanguageLanguage(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
      };
}

class Profile {
  Profile({
    this.id,
    this.userId,
    this.countryId,
    this.provinceId,
    this.cityId,
    this.barRegistrationCity,
    this.barRegistrationNo,
    this.barRegistrationDoc,
    this.nic,
    this.nicDoc,
    this.about,
    this.block,
    this.officeNo,
    this.address,
    this.postalCode,
    this.degree,
    this.degreeDoc,
    this.profileImg,
    this.title,
    this.createdAt,
    this.updatedAt,
    this.country,
    this.province,
    this.city,
  });

  int? id;
  int? userId;
  int? countryId;
  int? provinceId;
  int? cityId;
  String? barRegistrationCity;
  String? barRegistrationNo;
  String? barRegistrationDoc;
  String? nic;
  String? nicDoc;
  String? about;
  String? block;
  String? officeNo;
  String? address;
  String? postalCode;
  String? degree;
  String? degreeDoc;
  String? profileImg;
  String? title;
  DateTime? createdAt;
  DateTime? updatedAt;
  City? country;
  City? province;
  City? city;

  factory Profile.fromJson(String str) => Profile.fromMap(json.decode(str));

  factory Profile.fromMap(Map<String, dynamic> json) => Profile(
        id: json["id"],
        userId: json["user_id"],
        countryId: json["country_id"],
        provinceId: json["province_id"],
        cityId: json["city_id"],
        barRegistrationCity: json["bar_registration_city"],
        barRegistrationNo: json["bar_registration_no"],
        barRegistrationDoc: json["bar_registration_doc"],
        nic: json["nic"],
        nicDoc: json["nic_doc"],
        about: json["about"],
        block: json["block"],
        officeNo: json["office_no"],
        address: json["address"],
        postalCode: json["postal_code"],
        degree: json["degree"],
        degreeDoc: json["degree_doc"],
        profileImg: json["profile_img"],
        title: json["title"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        country: City.fromMap(json["country"]),
        province: City.fromMap(json["province"]),
        city: City.fromMap(json["city"]),
      );
}

class Queries {
  Queries({
    this.upcoming,
    this.completed,
    this.currMonth,
    this.all,
  });

  int? upcoming;
  int? completed;
  int? currMonth;
  int? all;

  factory Queries.fromJson(String str) => Queries.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Queries.fromMap(Map<String, dynamic> json) => Queries(
        upcoming: json["upcoming"],
        completed: json["completed"],
        currMonth: json["curr_month"],
        all: json["all"],
      );

  Map<String, dynamic> toMap() => {
        "upcoming": upcoming,
        "completed": completed,
        "curr_month": currMonth,
        "all": all,
      };
}

class Role {
  Role({
    this.id,
    this.name,
    this.alias,
    this.pivot,
  });

  int? id;
  String? name;
  String? alias;
  Pivot? pivot;

  factory Role.fromJson(String str) => Role.fromMap(json.decode(str));

  factory Role.fromMap(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        alias: json["alias"],
        pivot: Pivot.fromMap(json["pivot"]),
      );
}

class Pivot {
  Pivot({
    this.userId,
    this.roleId,
  });

  int? userId;
  int? roleId;

  factory Pivot.fromJson(String str) => Pivot.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pivot.fromMap(Map<String, dynamic> json) => Pivot(
        userId: json["user_id"],
        roleId: json["role_id"],
      );

  Map<String, dynamic> toMap() => {
        "user_id": userId,
        "role_id": roleId,
      };
}

class ScheduleTimings {
  ScheduleTimings({
    this.timings,
  });

  List<List<Day>>? timings;

  factory ScheduleTimings.fromJson(String str) =>
      ScheduleTimings.fromMap(json.decode(str));

  factory ScheduleTimings.fromMap(Map<String, dynamic> json) {
    List<List<Day>>? timings = [];
    for (int index = 0; index < json.keys.length; index++) {
      timings.add(List<Day>.from(
          List<Day>.from(json.values.elementAt(0).map((x) => Day.fromMap(x)))));
    }
    return ScheduleTimings(timings: timings);
  }
}

class Day {
  Day({
    this.dayId,
    this.fromTime,
    this.toTime,
  });

  int? dayId;
  String? fromTime;
  String? toTime;

  factory Day.fromJson(String str) => Day.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Day.fromMap(Map<String, dynamic> json) => Day(
        dayId: json["day_id"],
        fromTime: json["from_time"],
        toTime: json["to_time"],
      );

  Map<String, dynamic> toMap() => {
        "day_id": dayId,
        "from_time": fromTime,
        "to_time": toTime,
      };
}
