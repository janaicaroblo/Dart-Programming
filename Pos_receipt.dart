import 'dart:io';

class Product {
  String name;
  int quantity;
  double price;

  Product(this.name, this.quantity, this.price);

  @override
  String toString() {
    return 'Name: $name, Quantity: $quantity, Price: \$${price.toStringAsFixed(2)}';
  }
}

class Inventory {
  List<Product> products = [];

  void addProduct(String name, int quantity, double price) {
    products.add(Product(name, quantity, price));
    print('$quantity of $name added to the inventory at \$${price.toStringAsFixed(2)} each.');
  }

  void updateQuantity(String name, int quantity) {
    for (var product in products) {
      if (product.name == name) {
        product.quantity += quantity;
        print('Updated $name quantity by $quantity.');
        return;
      }
    }
    print('$name not found in inventory.');
  }

  void sellProduct(String name, int quantity) {
    for (var product in products) {
      if (product.name == name) {
        if (product.quantity >= quantity) {
          product.quantity -= quantity;
          print('$quantity of $name sold.');
        } else {
          print('Insufficient stock of $name.');
        }
        return;
      }
    }
    print('$name not found in inventory.');
  }

  void viewProducts() {
    if (products.isEmpty) {
      print('The inventory is empty.');
    } else {
      print('Inventory:');
      for (var product in products) {
        print(product);
      }
    }
  }

  Product? getProductByName(String name) {
    for (var product in products) {
      if (product.name == name) {
        return product;
      }
    }
    return null;
  }
}

class POS {
  Inventory inventory;

  POS(this.inventory);

  void processSale() {
    List<Product> saleItems = [];
    double total = 0.0;
    
    while (true) {
      stdout.write('Enter product name to sell (or type "done" to finish): ');
      String? productName = stdin.readLineSync();
      if (productName == null || productName.toLowerCase() == 'done') break;

      stdout.write('Enter quantity: ');
      int? quantity = int.tryParse(stdin.readLineSync()!);

      if (productName.isNotEmpty && quantity != null) {
        Product? product = inventory.getProductByName(productName);
        if (product != null && product.quantity >= quantity) {
          inventory.sellProduct(productName, quantity);
          saleItems.add(Product(product.name, quantity, product.price));
          total += product.price * quantity;
        } else {
          print('Product not found or insufficient stock.');
        }
      } else {
        print('Invalid input.');
      }
    }

    generateReceipt(saleItems, total);
  }

  void generateReceipt(List<Product> saleItems, double total) {
    print('\n----- Receipt -----');
    for (var item in saleItems) {
      print('${item.name} x${item.quantity} @ \$${item.price.toStringAsFixed(2)} each');
    }
    print('Total: \$${total.toStringAsFixed(2)}');
    print('-------------------\n');
  }
}

void main() {
  Inventory inventory = Inventory();
  POS pos = POS(inventory);

  while (true) {
    print('POS and Inventory Management System');
    print('1. Add Product');
    print('2. Update Product Quantity');
    print('3. View Inventory');
    print('4. Process Sale');
    print('5. Exit');
    stdout.write('Choose an option: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        stdout.write('Enter product name: ');
        String? name = stdin.readLineSync();
        stdout.write('Enter quantity: ');
        int? quantity = int.tryParse(stdin.readLineSync()!);
        stdout.write('Enter price: ');
        double? price = double.tryParse(stdin.readLineSync()!);
        if (name != null && quantity != null && price != null) {
          inventory.addProduct(name, quantity, price);
        } else {
          print('Invalid input.');
        }
        break;
      case '2':
        stdout.write('Enter product name: ');
        String? name = stdin.readLineSync();
        stdout.write('Enter quantity to update (use negative values to decrease): ');
        int? quantity = int.tryParse(stdin.readLineSync()!);
        if (name != null && quantity != null) {
          inventory.updateQuantity(name, quantity);
        } else {
          print('Invalid input.');
        }
        break;
      case '3':
        inventory.viewProducts();
        break;
      case '4':
        pos.processSale();
        break;
      case '5':
        exit(0);
      default:
        print('Invalid option.');
    }
    print('');
  }
}
