import 'dart:io';

void main() {
  String username ='HungryHippo';
  String password = "Password";

  while (true) {
    print("Enter Username: ");
    String? nameInput = stdin.readLineSync();
    print("Enter Password: ");
    String? passInput = stdin.readLineSync();
    if (username == nameInput && passInput == password) {
      print("welcome Back, Administrator");
      break;
    } else {
      print("Invalid Username or Password");
    }
  }
}
