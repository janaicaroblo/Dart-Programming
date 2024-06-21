import 'dart:io';

class Ingredient {
  String name;
  int quantity;
  int lowStockThreshold;
  int criticalStockThreshold;

  Ingredient(this.name, this.quantity, this.lowStockThreshold, this.criticalStockThreshold);

  @override
  String toString() {
    return 'Name: $name, Quantity: $quantity, Low Stock Threshold: $lowStockThreshold, Critical Stock Threshold: $criticalStockThreshold';
  }

  bool isLowStock() {
    return quantity <= lowStockThreshold && quantity > criticalStockThreshold;
  }

  bool isCriticalStock() {
    return quantity <= criticalStockThreshold;
  }
}

class Inventory {
  List<Ingredient> ingredients = [];

  void addIngredient(String name, int quantity, int lowStockThreshold, int criticalStockThreshold) {
    ingredients.add(Ingredient(name, quantity, lowStockThreshold, criticalStockThreshold));
    print('$quantity of $name added to the inventory.');
  }

  void useIngredient(String name, int quantity) {
    for (var ingredient in ingredients) {
      if (ingredient.name == name) {
        if (ingredient.quantity >= quantity) {
          ingredient.quantity -= quantity;
          print('$quantity of $name used.');
        } else {
          print('Insufficient stock of $name.');
        }
        return;
      }
    }
    print('$name not found in inventory.');
  }

  void viewLowStock() {
    print('Low Stock Ingredients:');
    for (var ingredient in ingredients) {
      if (ingredient.isLowStock()) {
        print(ingredient);
      }
    }
  }

  void viewCriticalStock() {
    print('Critical Stock Ingredients:');
    for (var ingredient in ingredients) {
      if (ingredient.isCriticalStock()) {
        print(ingredient);
      }
    }
  }

  void viewIngredients() {
    if (ingredients.isEmpty) {
      print('The inventory is empty.');
    } else {
      print('Inventory:');
      for (var ingredient in ingredients) {
        print(ingredient);
      }
    }
  }
}

void main() {
  Inventory inventory = Inventory();
  while (true) {
    print('Inventory Management System');
    print('1. Add Ingredient');
    print('2. Use Ingredient');
    print('3. View Ingredients');
    print('4. View Low Stock Ingredients');
    print('5. View Critical Stock Ingredients');
    print('6. Exit');
    stdout.write('Choose an option: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter ingredient name: ');
        String? name = stdin.readLineSync();
        stdout.write('Enter quantity: ');
        int? quantity = int.tryParse(stdin.readLineSync()!);
        stdout.write('Enter low stock threshold: ');
        int? lowStockThreshold = int.tryParse(stdin.readLineSync()!);
        stdout.write('Enter critical stock threshold: ');
        int? criticalStockThreshold = int.tryParse(stdin.readLineSync()!);
        if (name != null && quantity != null && lowStockThreshold != null && criticalStockThreshold != null) {
          inventory.addIngredient(name, quantity, lowStockThreshold, criticalStockThreshold);
        } else {
          print('Invalid input.');
        }
        break;
      case '2':
        stdout.write('Enter ingredient name: ');
        String? name = stdin.readLineSync();
        stdout.write('Enter quantity to use: ');
        int? quantity = int.tryParse(stdin.readLineSync()!);
        if (name != null && quantity != null) {
          inventory.useIngredient(name, quantity);
        } else {
          print('Invalid input.');
        }
        break;
      case '3':
        inventory.viewIngredients();
        break;
      case '4':
        inventory.viewLowStock();
        break;
      case '5':
        inventory.viewCriticalStock();
        break;
      case '6':
        exit(0);
      default:
        print('Invalid option.');
    }
    print('');
  }
}
