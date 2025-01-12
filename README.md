
# Trafik Dinamikleri Hesaplama: fcn.m

Bu proje, araçlar arasındaki hız ve mesafe farklarını analiz ederek trafik akışını modellemek için bir MATLAB fonksiyonu içerir. **fcn.m**, araçlar arası güvenli takip mesafesi ve hızlanma-yavaşlama oranlarını hesaplar.

---

## Nasıl Çalışır?

### Girişler:
- **u (Öncü aracın hızı):** Öncü aracın hızını ifade eder.
- **v (Takip eden aracın hızı):** Takip eden aracın hızını ifade eder.
- **d (Araçlar arasındaki mesafe):** Araçlar arasındaki gerçek mesafeyi ifade eder.

### Çıktılar:
- **h:** Araçların hız değişim oranı.
- **f:** Aynı hız değişim oranını tekrar eder (ileride geliştirme için).

---

## Hesaplamalar

Fonksiyon iki duruma göre çalışır:

1. **Serbest Akış Durumu:** Araçlar arasında yeterli mesafe varsa, araç hızlanma eğilimindedir.
2. **Yoğun Akış Durumu:** Araçlar birbirine yakınsa, takip eden araç yavaşlama eğilimindedir.

### Formüller:

1. **Güvenli Takip Mesafesi:**
   Güvenli takip mesafesi şu şekilde hesaplanır:
   $$
   \[
   s_1 = s_0 + \max(0, Ve \cdot T + \frac{Ve \cdot (Ve - Vl)}{2 \cdot \sqrt{a \cdot b}})
   \]
   $$
   Burada:
   - \( s_0 \): Minimum güvenli mesafe (örneğin, 2 metre),
   - \( Ve \): Öncü aracın hızı,
   - \( Vl \): Takip eden aracın hızı,
   - \( T \): Tepki süresi (örneğin, 1.5 saniye),
   - \( a, b \): Hızlanma ve yavaşlama katsayılarıdır.

3. **Z Oranı:**
   Güvenli mesafenin gerçek mesafeye oranı:
   \[
   z = \frac{s_1}{s}
   \]

4. **Hızlanma ve Yavaşlama Dinamikleri:**
   - **Serbest Akış (Ve ≤ Vcr):**
     \[
     a_{\text{free}} = a \cdot \left(1 - \left(\frac{Ve}{Vcr}\right)^\delta\right)
     \]
     Eğer \( z \geq 1 \):
     \[
     h = a \cdot (1 - z^2)
     \]
     Eğer \( z < 1 \):
     \[
     h = a_{\text{free}} \cdot \left(1 - z^{2a/a_{\text{free}}}\right)
     \]

   - **Yoğun Akış (Ve > Vcr):**
     \[
     a_{\text{free}} = -b \cdot \left(1 - \left(\frac{Vcr}{Ve}\right)^{a \cdot \delta / b}\right)
     \]
     Eğer \( z \geq 1 \):
     \[
     h = a_{\text{free}} + a \cdot (1 - z^2)
     \]
     Eğer \( z < 1 \):
     \[
     h = a_{\text{free}}
     \]

---

## MATLAB'da Kullanımı

Aşağıdaki örnekle fonksiyonu test edebilirsiniz:

```matlab
% Giriş değerleri
u = 20; % Öncü aracın hızı (m/s)
v = 15; % Takip eden aracın hızı (m/s)
d = 10; % Araçlar arasındaki mesafe (m)

% Fonksiyonu çalıştır
[h, f] = fcn(u, v, d);

% Sonuçları görüntüle
disp(['Hız değişim oranı (h): ', num2str(h)]);
disp(['Fonksiyon sonucu (f): ', num2str(f)]);
```

---

## Bu Projeyi Neden Yaptım?

Bu proje, trafik mühendisliği ve araç takip dinamiklerini anlamak için yazılmıştır. Özellikle mühendislik derslerinde veya trafik simülasyonlarında kullanılabilir.

---

Bu haliyle daha sade, anlaşılır ve kullanıcı dostu bir açıklama sunar. Ayrıca formüller daha temiz ve okunaklı bir şekilde yazılmıştır.
