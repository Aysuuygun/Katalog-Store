# Mini E-Ticaret Katalog Uygulaması

Flutter ile geliştirilmiş, modern kullanıcı arayüzüne (UI) sahip, kategori filtreleme, ürün detayları ve sepet yönetimi sunan mobil e-ticaret uygulaması.

---

## Özellikler

* **Ana Sayfa / Katalog:**
  * Kampanya ve öne çıkanlar kaydırıcı vitrini (Banner Carousel).
  * Kategoriye göre anlık ürün filtreleme çipi (Tümü, Telefon, Bilgisayar vb.).
  * Çoklu sütunlu Grid mimarisiyle listelenen ürün kartları.
  * Fiyata göre (Artan/Azalan) anlık sıralama seçenekleri.
  * Ürün kartı ve detay sayfasından tek tıkla favorilere ekleme/çıkarma (Wishlist)
* **Ürün Detay Sayfası:**
  * Yüksek çözünürlüklü ürün görseli, kullanıcı puanı ve değerlendirme sayısı.
  * Genişletilmiş ürün teknik özellikleri tablosu.
  * Tek tıkla sepete ve favorilere ekleme butonları.
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

##Ekran Görselleri
1.Ana Ekran
<img width="1080" height="2400" alt="1" src="https://github.com/user-attachments/assets/d36529b3-d83c-4be6-a023-b1bf758c8b15" />
2.Ürün Detay 
<img width="1080" height="2400" alt="2" src="https://github.com/user-attachments/assets/480753d7-11c3-4ef2-9d2d-e3dfed1d0123" />
3.Tür Seçimine Göre Sıralama
<img width="1080" height="2400" alt="3" src="https://github.com/user-attachments/assets/825e669a-5a92-4f81-9929-5c0e175c0562" />
4.Filtreleme 
<img width="1080" height="2400" alt="4" src="https://github.com/user-attachments/assets/4caa3386-187f-498c-a65e-7eb7c436cf0b" />
<img width="1080" height="2400" alt="5" src="https://github.com/user-attachments/assets/60acba6f-ff1e-4f86-8708-e94c052d43cf" />
5.Favoriler Listesi
<img width="1080" height="2400" alt="6" src="https://github.com/user-attachments/assets/f1316b3f-9d69-4722-b886-a7b0df463c4b" />
6.Arama Motoru
<img width="1080" height="2400" alt="7" src="https://github.com/user-attachments/assets/d5e802e7-936c-4729-b89d-5d656346433e" />
7.Sepet
<img width="1080" height="2400" alt="8" src="https://github.com/user-attachments/assets/d70d937c-dd73-4b2b-8f26-9dac32a2a716" />
8.Onay Ekranı
<img width="1080" height="2400" alt="9" src="https://github.com/user-attachments/assets/1163a297-a786-4699-bc6a-1b210f9465ab" />

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


