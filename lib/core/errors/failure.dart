class Failure {
  final String? technicalMessage;
  final String userMessageKey; // <- Key for localization (example: "something_wrong_try_again")

  Failure({required this.technicalMessage,  this.userMessageKey = "Something went wrong, Please try again"});
}

