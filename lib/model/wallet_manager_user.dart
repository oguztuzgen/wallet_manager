class ExpenseTrackerUser {
  int dbID;
  String userID;
  int categoriesID;
  int expenseID;

  ExpenseTrackerUser({this.dbID, this.userID, this.categoriesID, this.expenseID});

  Map<String, dynamic> toMap() {
    return {
      'id': dbID,
      'uid': userID,
      'categoriesid': categoriesID,
      'expenseid': expenseID,
    };
  }

  factory ExpenseTrackerUser.fromMap(Map<String, dynamic> json) => ExpenseTrackerUser(
    dbID: json['id'],
    userID: json['uid'],
    categoriesID: json['categoriesid'],
    expenseID: json['expenseid']
  );

  String toString() {
    return "DB-id: $dbID,\tUser-id: $userID,\tCategories-id: $categoriesID,\tExpense-id: $expenseID";
  }
}