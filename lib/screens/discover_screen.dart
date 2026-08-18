import 'package:flutter/material.dart';
import '../models/product.dart';
import 'product_detail_screen.dart';
import 'cart_screen.dart';

class DiscoverScreen extends StatefulWidget {
  final List<CartItem> cart;
  final Set<int> favorites;
  final Function(Product) onAddToCart;
  final Function(Product) onRemoveOneFromCart;
  final Function(Product) onDeleteItemFromCart;
  final Function(int) onToggleFavorite;
  final VoidCallback onClearCart;

  const DiscoverScreen({
    super.key,
    required this.cart,
    required this.favorites,
    required this.onAddToCart,
    required this.onRemoveOneFromCart,
    required this.onDeleteItemFromCart,
    required this.onToggleFavorite,
    required this.onClearCart,
  });

  @override
  State<DiscoverScreen> createState() => _DiscoverScreenState();
}

class _DiscoverScreenState extends State<DiscoverScreen> {
  String _searchQuery = '';
  String _selectedCategory = 'Tümü';
  String _sortBy = 'Varsayılan';
  bool _onlyFavorites = false;
  final PageController _bannerController = PageController();
  int _currentBannerPage = 0;

  final List<String> _categories = ['Tümü', 'Kulaklık', 'Telefon', 'Bilgisayar', 'Hoparlör', 'Saat', 'Tablet'];

  String _formatCurrency(double price) {
    return '${price.toStringAsFixed(0).replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]}.')} ₺';
  }

  int get _totalCartCount => widget.cart.fold(0, (sum, item) => sum + item.quantity);

  void _nextBanner() {
    if (_currentBannerPage < mockBanners.length - 1) {
      _bannerController.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _bannerController.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _prevBanner() {
    if (_currentBannerPage > 0) {
      _bannerController.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else {
      _bannerController.animateToPage(mockBanners.length - 1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  void _showSortModal() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Sıralama Seçenekleri', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              ...['Varsayılan', 'Fiyat: Düşükten Yükseğe', 'Fiyat: Yüksekten Düşüğe', 'En Yüksek Puan'].map(
                (sortOption) => ListTile(
                  title: Text(sortOption),
                  trailing: _sortBy == sortOption ? const Icon(Icons.check, color: Colors.black) : null,
                  onTap: () {
                    setState(() => _sortBy = sortOption);
                    Navigator.pop(context);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _bannerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> filteredProducts = mockProducts.where((p) {
      final matchesSearch = p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p.category.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCat = _selectedCategory == 'Tümü' || p.category == _selectedCategory;
      final matchesFav = !_onlyFavorites || widget.favorites.contains(p.id);
      return matchesSearch && matchesCat && matchesFav;
    }).toList();

    if (_sortBy == 'Fiyat: Düşükten Yükseğe') {
      filteredProducts.sort((a, b) => a.price.compareTo(b.price));
    } else if (_sortBy == 'Fiyat: Yüksekten Düşüğe') {
      filteredProducts.sort((a, b) => b.price.compareTo(a.price));
    } else if (_sortBy == 'En Yüksek Puan') {
      filteredProducts.sort((a, b) => b.rating.compareTo(a.rating));
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: false,
        title: const Row(
          children: [
            Icon(Icons.bolt, color: Colors.black87, size: 26),
            SizedBox(width: 8),
            Text(
              'Katalog Store',
              style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w800, fontSize: 19),
            ),
          ],
        ),
        actions: [
          // Favoriler Filtre Butonu
          IconButton(
            icon: Icon(
              _onlyFavorites ? Icons.favorite : Icons.favorite_border,
              color: _onlyFavorites ? Colors.red : Colors.black87,
            ),
            onPressed: () {
              setState(() => _onlyFavorites = !_onlyFavorites);
            },
          ),
          // Sepet Butonu
          Stack(
            alignment: Alignment.center,
            children: [
              IconButton(
                icon: const Icon(Icons.shopping_bag_outlined, color: Colors.black87, size: 26),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(
                        cart: widget.cart,
                        onAddToCart: widget.onAddToCart,
                        onRemoveOneFromCart: widget.onRemoveOneFromCart,
                        onDeleteItemFromCart: widget.onDeleteItemFromCart,
                        onClearCart: widget.onClearCart,
                      ),
                    ),
                  );
                },
              ),
              if (_totalCartCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 18, minHeight: 18),
                    child: Text(
                      '$_totalCartCount',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          final crossAxisCount = constraints.maxWidth > 1100 ? 4 : (constraints.maxWidth > 650 ? 3 : 2);
          final maxContentWidth = isWide ? 1140.0 : double.infinity;

          return Center(
            child: Container(
              constraints: BoxConstraints(maxWidth: maxContentWidth),
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                children: [
                  // Arama ve Sıralama Çubuğu
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: TextField(
                            onChanged: (val) => setState(() => _searchQuery = val),
                            decoration: const InputDecoration(
                              hintText: 'Ürün, model veya kategori ara...',
                              hintStyle: TextStyle(color: Colors.grey, fontSize: 13),
                              prefixIcon: Icon(Icons.search, color: Colors.grey, size: 20),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(vertical: 12),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: _showSortModal,
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: const Icon(Icons.tune, color: Colors.black87, size: 22),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Carousel
                  if (!_onlyFavorites) ...[
                    SizedBox(
                      height: isWide ? 220 : 160,
                      child: Stack(
                        children: [
                          PageView.builder(
                            controller: _bannerController,
                            itemCount: mockBanners.length,
                            onPageChanged: (idx) => setState(() => _currentBannerPage = idx),
                            itemBuilder: (context, index) {
                              final b = mockBanners[index];
                              return Container(
                                margin: const EdgeInsets.symmetric(horizontal: 2),
                                decoration: BoxDecoration(
                                  color: Color(b.colorHex),
                                  borderRadius: BorderRadius.circular(16),
                                  image: DecorationImage(
                                    image: NetworkImage(b.imageUrl),
                                    fit: BoxFit.cover,
                                    colorFilter: ColorFilter.mode(Colors.black.withValues(alpha: 0.4), BlendMode.darken),
                                  ),
                                ),
                                padding: const EdgeInsets.all(18),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(alpha: 0.25),
                                        borderRadius: BorderRadius.circular(6),
                                      ),
                                      child: Text(
                                        b.tag,
                                        style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      b.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: isWide ? 24 : 18,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      b.subtitle,
                                      style: TextStyle(color: Colors.white.withValues(alpha: 0.9), fontSize: isWide ? 13 : 11),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                          Positioned(
                            left: 6,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: InkWell(
                                onTap: _prevBanner,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.4), shape: BoxShape.circle),
                                  child: const Icon(Icons.chevron_left, color: Colors.white, size: 20),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            right: 6,
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: InkWell(
                                onTap: _nextBanner,
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(color: Colors.black.withValues(alpha: 0.4), shape: BoxShape.circle),
                                  child: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],

                  // Kategori Filtreleme
                  SizedBox(
                    height: 36,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _categories.length,
                      separatorBuilder: (_, _) => const SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        final cat = _categories[index];
                        final isSelected = cat == _selectedCategory;
                        return ChoiceChip(
                          label: Text(cat),
                          selected: isSelected,
                          onSelected: (_) => setState(() => _selectedCategory = cat),
                          selectedColor: Colors.black,
                          backgroundColor: Colors.white,
                          labelStyle: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide(color: isSelected ? Colors.black : Colors.grey.shade300),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Liste Başlığı
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _onlyFavorites ? 'Favorilerim (${filteredProducts.length})' : 'Ürünler (${filteredProducts.length})',
                        style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.black87),
                      ),
                      if (_sortBy != 'Varsayılan')
                        Text(
                          _sortBy,
                          style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // GridView Ürün Kartları
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredProducts.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      childAspectRatio: isWide ? 0.80 : 0.74,
                    ),
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      final isFav = widget.favorites.contains(product.id);

                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            )
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Görsel ve Favori İkonu
                            Expanded(
                              child: Stack(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => ProductDetailScreen(
                                            product: product,
                                            isFavorite: isFav,
                                            onAddToCart: widget.onAddToCart,
                                            onToggleFavorite: widget.onToggleFavorite,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade50,
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: const BorderRadius.vertical(top: Radius.circular(13)),
                                        child: Image.network(
                                          product.imageUrl,
                                          fit: BoxFit.cover,
                                          errorBuilder: (context, error, stackTrace) =>
                                              const Center(child: Icon(Icons.devices, size: 40, color: Colors.grey)),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    top: 6,
                                    right: 6,
                                    child: InkWell(
                                      onTap: () => widget.onToggleFavorite(product.id),
                                      child: Container(
                                        padding: const EdgeInsets.all(5),
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          isFav ? Icons.favorite : Icons.favorite_border,
                                          size: 16,
                                          color: isFav ? Colors.red : Colors.grey.shade600,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Bilgi ve Fiyat
                            Padding(
                              padding: const EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Icon(Icons.star, color: Colors.amber, size: 13),
                                      const SizedBox(width: 3),
                                      Text(
                                        '${product.rating}',
                                        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(width: 4),
                                      Text(
                                        '(${product.reviewsCount})',
                                        style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 3),
                                  Text(
                                    product.name,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: Colors.black87),
                                  ),
                                  const SizedBox(height: 6),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _formatCurrency(product.price),
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w900, color: Colors.black),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          widget.onAddToCart(product);
                                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text('${product.name} sepete eklendi!'),
                                              duration: const Duration(seconds: 1),
                                              backgroundColor: Colors.black,
                                              behavior: SnackBarBehavior.floating,
                                            ),
                                          );
                                        },
                                        borderRadius: BorderRadius.circular(8),
                                        child: Container(
                                          padding: const EdgeInsets.all(6),
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: const Icon(Icons.add, color: Colors.white, size: 15),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}