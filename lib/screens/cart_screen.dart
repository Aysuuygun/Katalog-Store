import 'package:flutter/material.dart';
import '../models/product.dart';
import 'order_success_screen.dart';

class CartScreen extends StatefulWidget {
  final List<CartItem> cart;
  final Function(Product) onAddToCart;
  final Function(Product) onRemoveOneFromCart;
  final Function(Product) onDeleteItemFromCart;
  final VoidCallback onClearCart;

  const CartScreen({
    super.key,
    required this.cart,
    required this.onAddToCart,
    required this.onRemoveOneFromCart,
    required this.onDeleteItemFromCart,
    required this.onClearCart,
  });

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final TextEditingController _couponController = TextEditingController();
  double _discountRate = 0.0;
  String _couponMessage = '';

  String _formatCurrency(double price) {
    return '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} ₺';
  }

  void _applyCoupon() {
    final code = _couponController.text.trim().toUpperCase();
    if (code == 'INDIRIM10') {
      setState(() {
        _discountRate = 0.10;
        _couponMessage = '%10 indirim uygulandı!';
      });
    } else if (code == 'FLUTTER20') {
      setState(() {
        _discountRate = 0.20;
        _couponMessage = '%20 Flutter indirimi uygulandı!';
      });
    } else {
      setState(() {
        _discountRate = 0.0;
        _couponMessage = 'Geçersiz kupon kodu.';
      });
    }
  }

  @override
  void dispose() {
    _couponController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final subtotal = widget.cart.fold<double>(0, (sum, item) => sum + (item.product.price * item.quantity));
    final discountAmount = subtotal * _discountRate;
    final finalTotal = subtotal - discountAmount;

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 18),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Sepetim (${widget.cart.length})',
          style: const TextStyle(color: Colors.black87, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 700),
          child: widget.cart.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_bag_outlined, size: 70, color: Colors.grey.shade400),
                      const SizedBox(height: 16),
                      const Text(
                        'Sepetinizde ürün bulunmuyor',
                        style: TextStyle(fontSize: 16, color: Colors.black87, fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Katalogdan dilediğiniz ürünü ekleyebilirsiniz.',
                        style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          ...widget.cart.map((cartItem) {
                            return Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey.shade200),
                              ),
                              child: Row(
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: Image.network(
                                      cartItem.product.imageUrl,
                                      width: 65,
                                      height: 65,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  const SizedBox(width: 14),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          cartItem.product.name,
                                          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _formatCurrency(cartItem.product.price),
                                          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w700, fontSize: 13),
                                        ),
                                        const SizedBox(height: 8),
                                        // Adet Değiştirici Butonlar
                                        Row(
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  widget.onRemoveOneFromCart(cartItem.product);
                                                });
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: const Icon(Icons.remove, size: 14),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.symmetric(horizontal: 12),
                                              child: Text(
                                                '${cartItem.quantity}',
                                                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                                              ),
                                            ),
                                            InkWell(
                                              onTap: () {
                                                setState(() {
                                                  widget.onAddToCart(cartItem.product);
                                                });
                                              },
                                              child: Container(
                                                padding: const EdgeInsets.all(4),
                                                decoration: BoxDecoration(
                                                  border: Border.all(color: Colors.grey.shade300),
                                                  borderRadius: BorderRadius.circular(6),
                                                ),
                                                child: const Icon(Icons.add, size: 14),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.delete_outline, color: Colors.redAccent, size: 22),
                                    onPressed: () {
                                      setState(() {
                                        widget.onDeleteItemFromCart(cartItem.product);
                                      });
                                    },
                                  ),
                                ],
                              ),
                            );
                          }),
                          const SizedBox(height: 12),
                          // Kupon Kodu Alanı
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey.shade200),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextField(
                                        controller: _couponController,
                                        textCapitalization: TextCapitalization.characters,
                                        decoration: const InputDecoration(
                                          hintText: 'Kupon kodu (örn: INDIRIM10)',
                                          hintStyle: TextStyle(fontSize: 13),
                                          border: InputBorder.none,
                                          isDense: true,
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.black,
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      onPressed: _applyCoupon,
                                      child: const Text('Uygula', style: TextStyle(fontSize: 12)),
                                    ),
                                  ],
                                ),
                                if (_couponMessage.isNotEmpty) ...[
                                  const SizedBox(height: 6),
                                  Text(
                                    _couponMessage,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: _discountRate > 0 ? Colors.green.shade700 : Colors.red,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Alt Özet ve Sipariş Butonu
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: Colors.grey.shade200)),
                      ),
                      child: Column(
                        children: [
                          if (_discountRate > 0) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Ara Toplam:', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                Text(_formatCurrency(subtotal), style: const TextStyle(fontSize: 14)),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('İndirim:', style: TextStyle(fontSize: 13, color: Colors.green)),
                                Text('- ${_formatCurrency(discountAmount)}', style: const TextStyle(fontSize: 14, color: Colors.green, fontWeight: FontWeight.bold)),
                              ],
                            ),
                            const Divider(height: 16),
                          ],
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Toplam Tutar:', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                              Text(
                                _formatCurrency(finalTotal),
                                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900, color: Colors.black),
                              ),
                            ],
                          ),
                          const SizedBox(height: 14),
                          SizedBox(
                            width: double.infinity,
                            height: 50,
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.black,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                elevation: 0,
                              ),
                              onPressed: () {
                                final currentFinalTotal = finalTotal;
                                widget.onClearCart();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => OrderSuccessScreen(totalAmount: currentFinalTotal),
                                  ),
                                );
                              },
                              child: const Text('Siparişi Tamamla', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}