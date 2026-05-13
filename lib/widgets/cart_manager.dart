class CartItem {
  final String productId;
  final String name;
  final double price;
  final String? imageBase64;
  int quantity;

  CartItem({
    required this.productId,
    required this.name,
    required this.price,
    this.imageBase64,
    this.quantity = 1,
  });
}

class CartManager {
  static final CartManager _instance = CartManager._internal();
  factory CartManager() => _instance;
  CartManager._internal();

  final List<CartItem> _items = [];

  List<CartItem> get items => List.unmodifiable(_items);

  int get itemCount => _items.fold(0, (sum, item) => sum + item.quantity);

  double get totalPrice =>
      _items.fold(0, (sum, item) => sum + item.price * item.quantity);

  void addItem({
    required String productId,
    required String name,
    required double price,
    String? imageBase64,
  }) {
    final existingIndex =
        _items.indexWhere((item) => item.productId == productId);
    if (existingIndex >= 0) {
      _items[existingIndex].quantity++;
    } else {
      _items.add(CartItem(
        productId: productId,
        name: name,
        price: price,
        imageBase64: imageBase64,
      ));
    }
  }

  void removeItem(String productId) {
    _items.removeWhere((item) => item.productId == productId);
  }

  void incrementQuantity(String productId) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) _items[index].quantity++;
  }

  void decrementQuantity(String productId) {
    final index = _items.indexWhere((item) => item.productId == productId);
    if (index >= 0) {
      if (_items[index].quantity > 1) {
        _items[index].quantity--;
      } else {
        _items.removeAt(index);
      }
    }
  }

  void clear() => _items.clear();
}