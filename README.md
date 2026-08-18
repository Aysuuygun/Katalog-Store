# Mini E-Ticaret Katalog Uygulaması

Flutter ile geliştirilmiş, modern kullanıcı arayüzüne (UI) sahip, kategori filtreleme, ürün detayları ve sepet yönetimi sunan mobil e-ticaret uygulaması.

---

## Özellikler

* **Ana Sayfa / Katalog:**
  * Kampanya ve öne çıkanlar kaydırıcı vitrini (Banner Carousel).
  * Kategoriye göre anlık ürün filtreleme çipi (Tümü, Telefon, Bilgisayar vb.).
  * Çoklu sütunlu Grid mimarisiyle listelenen ürün kartları.
* **Ürün Detay Sayfası:**
  * Ürün görseli, puan/değerlendirme sayısı ve dinamik fiyat gösterimi.
  * Genişletilmiş ürün teknik özellikleri tablosu.
  * Tek tıkla sepete ekleme butonu.
* **Sepet & Sipariş Yönetimi:**
  * Ürün adedi artırma / azaltma ve dinamik ara toplam hesabı.
  * İndirim kuponu uygulama alanı (`INDIRIM10` ile %10 indirim).
  * Boş sepet durum kontrolü ve animasyonlu sipariş onay / başarı ekranı.

---

## Kullanılan Teknolojiler

* **Framework:** Flutter (Dart)
* **IDE / Geliştirme Ortamı:** Visual Studio Code & Android Studio
* **Hedef Platform:** Android (Emulator / Fiziksel Cihaz) & Web

---

##  Kurulum ve Çalıştırma

Projeyi yerel ortamınızda çalıştırmak için:

```bash
# Repoyu klonlayın
git clone [https://github.com/Aysuuygun/flutter-mini-katalog.git](https://github.com/Aysuuygun/flutter-mini-katalog.git)

# Proje dizinine gidin
cd flutter-mini-katalog

# Bağımlılıkları yükleyin
flutter pub get

# Uygulamayı başlatın
flutter run

