

# Trafik Dinamikleri Hesaplama: fcn.m

Bu proje, araçların hız ve mesafe farklarını analiz ederek trafik akışını modellemek için bir MATLAB fonksiyonu içerir. **fcn.m**, araçlar arası güvenli takip mesafesi ve hızlanma-yavaşlama oranlarını hesaplar.

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

### Adım Adım Hesaplamalar:

1. **Güvenli Takip Mesafesi:**
   Güvenli takip mesafesi şu şekilde belirlenir:
   - Minimum güvenli mesafe, \( s_0 \), örneğin 2 metre olarak sabit bir değer alır.
   - Öncü aracın hızı \( Ve \) ve takip eden aracın hızı \( Vl \) kullanılarak, bir takip mesafesi \( T \) (örneğin 1.5 saniye) kadar dikkate alınır.
   - Araçların hız farkı ve tepki süresine göre ek bir mesafe hesaplanır.

   Sonuç olarak, toplam güvenli takip mesafesi:
   - \( s_1 = s_0 + \) takip mesafesi + hız farkına bağlı ek mesafe.

2. **Z Oranı:**
   Güvenli mesafenin gerçek mesafeye oranı hesaplanır:
   - \( z = s_1 / s \), burada \( s \) araçlar arasındaki mevcut mesafedir.

3. **Hızlanma ve Yavaşlama Dinamikleri:**

   a. **Serbest Akış Durumu (Öncü hız \( Ve \), kritik hızdan küçük veya eşit):**
      - Araç hızlanmaya devam eder. Hızlanma katsayısı \( a \), araç hızının kritik hıza oranına bağlı olarak belirlenir.
      - Eğer güvenli mesafe korunuyorsa (\( z < 1 \)), hızlanma dinamiği yavaş yavaş azalır.
      - Güvenli mesafe korunmuyorsa (\( z \geq 1 \)), araç fren yapar ve yavaşlar.

   b. **Yoğun Akış Durumu (Öncü hız \( Ve \), kritik hızdan büyük):**
      - Araçlar birbirine daha yakın hareket eder. Hızlanma katsayısı, kritik hızın öncü araca oranına bağlıdır.
      - Eğer güvenli mesafe korunuyorsa (\( z < 1 \)), araç hızı sabit tutulur.
      - Güvenli mesafe korunmuyorsa (\( z \geq 1 \)), fren etkisi hızlanma dinamiğini baskılar.

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

## Özet

Bu proje, trafik mühendisliği ve araç takip dinamiklerini anlamak için yazılmıştır. Özellikle mühendislik derslerinde veya trafik simülasyonlarında kullanılabilir. Daha fazla katkıda bulunmak isterseniz, bana ulaşabilirsiniz.

---

Bu şekilde formülleri açıkça metin içinde ifade ediyoruz, ancak karmaşık semboller olmadan anlatımı daha kullanıcı dostu hale getiriyoruz.
