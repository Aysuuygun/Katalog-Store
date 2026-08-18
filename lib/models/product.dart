class Product {
  final int id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int reviewsCount;
  final String description;
  final String imageUrl;
  final Map<String, String> specs;

  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviewsCount,
    required this.description,
    required this.imageUrl,
    required this.specs,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      price: (json['price'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
      reviewsCount: json['reviewsCount'] ?? 0,
      description: json['description'],
      imageUrl: json['imageUrl'],
      specs: Map<String, String>.from(json['specs']),
    );
  }
}

class CartItem {
  final Product product;
  int quantity;

  CartItem({required this.product, this.quantity = 1});
}

class BannerItem {
  final String title;
  final String subtitle;
  final String tag;
  final String imageUrl;
  final int colorHex;

  BannerItem({
    required this.title,
    required this.subtitle,
    required this.tag,
    required this.imageUrl,
    required this.colorHex,
  });
}

final List<BannerItem> mockBanners = [
  BannerItem(
    title: 'iPhone 15 Pro',
    subtitle: 'Titanyum kasa ve A17 Pro gücü.',
    tag: '%10 İNDİRİM: INDIRIM10',
    imageUrl: 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=600&auto=format&fit=crop&q=80',
    colorHex: 0xFF1C1C1E,
  ),
  BannerItem(
    title: 'AirPods Max',
    subtitle: 'Kişiselleştirilmiş Uzamsal Ses deneyimi.',
    tag: 'FLUTTER ÖZEL: FLUTTER20',
    imageUrl: 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=600&auto=format&fit=crop&q=80',
    colorHex: 0xFF2C3E50,
  ),
  BannerItem(
    title: 'MacBook Pro 14"',
    subtitle: 'M3 Pro çip ile sınırları aşın.',
    tag: 'PROFESYONEL',
    imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&auto=format&fit=crop&q=80',
    colorHex: 0xFF182C61,
  ),
];

final List<Product> mockProducts = [
  Product(
    id: 1,
    name: 'AirPods Pro (2. Nesil)',
    category: 'Kulaklık',
    price: 8999.00,
    rating: 4.8,
    reviewsCount: 342,
    description: 'H2 çip ile 2 kata kadar daha etkili Aktif Gürültü Engelleme, Adaptif Ses ve Şeffaf Mod.',
    imageUrl: 'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=600&auto=format&fit=crop&q=80',
    specs: {'Pil Ömrü': '6 Saat (30 Saat Kutu)', 'Çip': 'Apple H2', 'Şarj': 'MagSafe USB-C'},
  ),
  Product(
    id: 2,
    name: 'AirPods Max',
    category: 'Kulaklık',
    price: 24999.00,
    rating: 4.7,
    reviewsCount: 189,
    description: 'Özel tasarım dinamik sürücü ile Hi-Fi stüdyo kalitesinde ses ve kusursuz akustik yalıtım.',
    imageUrl: 'https://images.unsplash.com/photo-1546435770-a3e426bf472b?w=600&auto=format&fit=crop&q=80',
    specs: {'Pil Ömrü': '20 Saat', 'Sürücü': '40 mm Dinamik', 'Ağırlık': '384.8 g'},
  ),
  Product(
    id: 3,
    name: 'HomePod Mini',
    category: 'Hoparlör',
    price: 4499.00,
    rating: 4.6,
    reviewsCount: 95,
    description: 'Kompakt boyutuna rağmen 360 derece güçlü akustik performans ve Siri entegrasyonu.',
    imageUrl: 'https://images.unsplash.com/photo-1543512214-318c7553f230?w=600&auto=format&fit=crop&q=80',
    specs: {'Ses': '360° Akustik', 'İşlemci': 'Apple S5', 'Bağlantı': 'Wi-Fi / AirPlay 2'},
  ),
  Product(
    id: 4,
    name: 'HomePod (2. Nesil)',
    category: 'Hoparlör',
    price: 13999.00,
    rating: 4.9,
    reviewsCount: 64,
    description: 'Derin baslar ve kristal tizler sunan woofer ve 5’li tweeter dizilimi, oda algılama desteği.',
    imageUrl: 'https://images.unsplash.com/photo-1545454675-3531b543be5d?w=600&auto=format&fit=crop&q=80',
    specs: {'Bas Sürücü': '4 inç Yüksek Gezinimli', 'Tweeter': '5x Dizi', 'Sensör': 'Oda Algılama'},
  ),
  Product(
    id: 5,
    name: 'iPhone 15 Pro',
    category: 'Telefon',
    price: 67999.00,
    rating: 4.9,
    reviewsCount: 820,
    description: 'Havacılık sınıfı titanyum gövde, üstün A17 Pro çip ve 48 MP profesyonel üçlü kamera sistemi.',
    imageUrl: 'https://images.unsplash.com/photo-1592750475338-74b7b21085ab?w=600&auto=format&fit=crop&q=80',
    specs: {'Ekran': '6.1 inç Super Retina XDR', 'İşlemci': 'A17 Pro (3nm)', 'Kamera': '48 MP + 12 MP + 12 MP'},
  ),
  Product(
    id: 6,
    name: 'MacBook Pro 14"',
    category: 'Bilgisayar',
    price: 79999.00,
    rating: 5.0,
    reviewsCount: 140,
    description: 'Apple M3 Pro çip ile zorlu kodlama, render ve grafik projelerinde sessiz tam performans.',
    imageUrl: 'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=600&auto=format&fit=crop&q=80',
    specs: {'Ekran': '14.2 inç Liquid Retina XDR', 'Bellek': '18 GB Birleşik Bellek', 'Depolama': '512 GB SSD'},
  ),
  Product(
    id: 7,
    name: 'Apple Watch Ultra 2',
    category: 'Saat',
    price: 41999.00,
    rating: 4.8,
    reviewsCount: 210,
    description: 'Zorlu koşullara dayanıklı titanyum kasa, hassas çift frekanslı GPS ve 3000 nit parlaklık.',
    imageUrl: 'https://images.unsplash.com/photo-1508685096489-7aacd43bd3b1?w=600&auto=format&fit=crop&q=80',
    specs: {'Kasa': '49 mm Titanyum', 'Parlaklık': '3000 Nit', 'Su Dayanımı': '100 Metre'},
  ),
  Product(
    id: 8,
    name: 'iPad Air 11" (M2)',
    category: 'Tablet',
    price: 27999.00,
    rating: 4.7,
    reviewsCount: 115,
    description: 'M2 çipin yüksek hızı, Liquid Retina ekran ve Apple Pencil Pro tam uyumu.',
    imageUrl: 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=600&auto=format&fit=crop&q=80',
    specs: {'Ekran': '11 inç Liquid Retina', 'İşlemci': 'Apple M2', 'Ağırlık': '462 g'},
  ),
];