class WMCategory {
  int dbID;
  String category;

  int get id { return dbID; }
  String get name { return category; }

  WMCategory({this.dbID, this.category});
}