import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Item> items = [
    Item(
      name: 'Pullover',
      color: 'Black',
      size: 'L',
      price: 51,
      quantity: 1,
      imageUrl: 'assets/images/pullover.jpg',
    ),
    Item(
      name: 'T-Shirt',
      color: 'Gray',
      size: 'L',
      price: 30,
      quantity: 1,
      imageUrl: 'assets/images/tshirt.jpg',
    ),
    Item(
      name: 'Sport Dress',
      color: 'Black',
      size: 'M',
      price: 43,
      quantity: 1,
      imageUrl: 'assets/images/sport_dress.jpg',
    ),
  ];

  // Calculate total price
  int get totalAmount {
    return items.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  // Increment quantity
  void incrementQuantity(int index) {
    setState(() {
      items[index].quantity++;
    });
  }

  // Decrement quantity
  void decrementQuantity(int index) {
    setState(() {
      if (items[index].quantity > 0) {
        items[index].quantity--;
      }
    });
  }

  void showCheckoutSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Congratulations! You have checked out successfully.'),
        backgroundColor: Colors.green,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Bag',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 12.0),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // Item Image
                          ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxWidth: 100,
                              maxHeight: 100,
                            ),
                            child: Image.asset(
                              items[index].imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Item Info

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  items[index].name,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Color: ${items[index].color}  Size: ${items[index].size}',
                                  style: TextStyle(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ),
                          // Quantity Controls and Price
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove_circle_outline),
                                onPressed: () => decrementQuantity(index),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: Text(
                                  '${items[index].quantity}',
                                  style: const TextStyle(fontSize: 16),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.add_circle_outline),
                                onPressed: () => incrementQuantity(index),
                              ),
                            ],
                          ),
                          const SizedBox(width: 12),
                          // Item Price
                          Text(
                            '\$${items[index].price}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Total Amount
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total amount:',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  '\$${totalAmount}',
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.red),
                ),
              ],
            ),
          ),
          // Checkout Button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => showCheckoutSnackbar(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'CHECK OUT',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class Item {
  String name;
  String color;
  String size;
  int price;
  int quantity;
  String imageUrl;

  Item({
    required this.name,
    required this.color,
    required this.size,
    required this.price,
    required this.quantity,
    required this.imageUrl,
  });
}
