class Expense {
  String    description;
	double    amount;
	DateTime  dateTime;
	String    category;
  int       importance; 
  // essential stuff like eating are higher importances

	Expense(
    {
      this.description = "", 
      this.amount = 0.0,
      this.dateTime,
      this.category = ""
    }
  ) {
    this.dateTime = this.dateTime == null ? DateTime.now() : this.dateTime;
  }

  @override
  String toString() {
    return this.description + "\n" + this.amount.toString() + "\n" + 
      this.dateTime.toString() + "\n" + this.category;
  }

  Map<String, dynamic> toMap() {
    return {
      // TODO implement
    };
  }
}