class WMUser {
  int dbID;
  String userID;
  int categoriesID;
  int expenseID;

  WMUser({this.dbID, this.userID, this.categoriesID, this.expenseID});

  Map<String, dynamic> toMap() {
    return {
      'id': dbID,
      'uid': userID,
      'categoriesid': categoriesID,
      'expenseid': expenseID,
    };
  }

  factory WMUser.fromMap(Map<String, dynamic> json) => WMUser(
    dbID: json['id'],
    userID: json['uid'],
    categoriesID: json['categoriesid'],
    expenseID: json['expenseid']
  );

  String toString() {
    return "DB-id: $dbID,\tUser-id: $userID,\tCategories-id: $categoriesID,\tExpense-id: $expenseID";
  }
}