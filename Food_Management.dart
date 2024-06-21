import 'dart:io';

class Food {
  static var foodType;
  var foodName;
  double foodPrice = 0.0;

  // Function to show details of the food
  void showDetails() {
    print("Name: $foodName");
    print("Price: ₱${foodPrice.toStringAsFixed(2)}"); // Updated currency symbol
    print("Type: $foodType");
  }
}

void main() {
  Food food1 = Food();
  Food food2 = Food();
  Food.foodType = "Seafood"; // Setting static property

  food1.foodName = 'Shrimp Scampi';
  food1.foodPrice = 19.99;
  food1.showDetails();

  for (int ctr = 1; ctr <= 30; ctr++) {
    stdout.write("-");
  }
  stdout.write("\n");

  food2.foodName = 'Classic Veggie Burger';
  food2.foodPrice = 79.99;
  food2.showDetails();
}
