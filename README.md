

# Trafik Dinamikleri Hesaplama: fcn.m

Bu proje, araçların hız ve mesafe dinamiklerini analiz etmek için bir MATLAB fonksiyonu içerir. **fcn.m** dosyası, verilen hız ve mesafe değerleriyle araçların hızlanma veya yavaşlama oranını hesaplar.

---

## Nasıl Çalışır?

Fonksiyon, araçlar arasındaki mesafeyi ve hız farklarını dikkate alarak trafik akışını simüle eder. İki temel durum üzerinden çalışır:

1. **Serbest Akış (Free Flow):** Araçlar arasında yeterli mesafe olduğunda.
2. **Yoğun Akış (Congested Flow):** Araçlar birbirine çok yakın olduğunda.

---

## Matematiksel Model

### Mesafe ve Güvenli Takip

Araçlar arasındaki güvenli takip mesafesi \( s_1 \), aşağıdaki formülle hesaplanır:

\[
s_1 = s_0 + \max(0, V_e \cdot T + \frac{V_e \cdot (V_e - V_l)}{2 \sqrt{a \cdot b}})
\]

Burada:
- \( s_0 \): Minimum güvenli mesafe (varsayılan 2 metre),
- \( V_e \): Öncü aracın hızı,
- \( V_l \): Takip eden aracın hızı,
- \( T \): Tepki süresi (varsayılan 1.5 saniye),
- \( a \) ve \( b \): Hızlanma ve yavaşlama katsayıları.

Daha sonra, \( z \) oranı hesaplanır:

\[
z = \frac{s_1}{s}
\]

Burada \( s \), gerçek mesafedir.

---

### Hızlanma ve Yavaşlama Dinamikleri

#### Serbest Akış Durumu (\( V_e \leq V_{cr} \)):

Hızlanma katsayısı \( a_{\text{free}} \), şu şekilde hesaplanır:

\[
a_{\text{free}} = a \cdot \left(1 - \left(\frac{V_e}{V_{cr}}\right)^\delta\right)
\]

Eğer \( z \geq 1 \) ise:

\[
\text{Türev Sonucu: } h = a \cdot \left(1 - z^2\right)
\]

Eğer \( z < 1 \) ise:

\[
\text{Türev Sonucu: } h = a_{\text{free}} \cdot \left(1 - z^{\frac{2a}{a_{\text{free}}}}\right)
\]

#### Yoğun Akış Durumu (\( V_e > V_{cr} \)):

Hızlanma katsayısı şu şekilde hesaplanır:

\[
a_{\text{free}} = -b \cdot \left(1 - \left(\frac{V_{cr}}{V_e}\right)^{\frac{a \cdot \delta}{b}}\right)
\]

Eğer \( z \geq 1 \) ise:

\[
\text{Türev Sonucu: } h = a_{\text{free}} + a \cdot \left(1 - z^2\right)
\]

Eğer \( z < 1 \) ise:

\[
\text{Türev Sonucu: } h = a_{\text{free}}
\]

---

## Fonksiyon Kullanımı

Aşağıdaki kodu MATLAB ya da Octave'da çalıştırabilirsiniz:

```matlab
% Örnek giriş değerleri
u = 20; % Öncü aracın hızı
v = 15; % Takip eden aracın hızı
d = 10; % Araçlar arasındaki mesafe

% Fonksiyonu çağır
[h, f] = fcn(u, v, d);

% Sonuçları yazdır
disp(['Hız değişim oranı: ', num2str(h)]);
disp(['Fonksiyon sonucu: ', num2str(f)]);
```

---

## Grafikler

Fonksiyonun çıktısını grafiklerle görselleştirmek mümkündür. Örneğin, farklı hız ve mesafe değerlerine göre türev sonuçlarını çizdirebilirsiniz:

```matlab
u_vals = 10:5:30; % Öncü hızları
v_vals = 5:5:25;  % Takip eden hızlar
d_vals = 5:2:20;  % Mesafeler

% Türev sonuçlarını hesaplayıp grafiğe dökebilirsiniz.
% Örneğin, u ile h arasındaki ilişki:
plot(u_vals, arrayfun(@(u) fcn(u, 15, 10), u_vals));
xlabel('Öncü Hızı (m/s)');
ylabel('Türev Sonucu h');
title('Öncü Hızı ile Türev Sonucu Arasındaki İlişki');
```

---

## Bu Projeyi Neden Yaptım?

Trafik dinamiklerini anlamak ve araçların birbirine göre nasıl hareket ettiğini görmek için bu fonksiyonu yazdım. Özellikle mühendislik derslerinde veya projelerinde faydalı olabilir.

---

## Katkıda Bulunun

Hata bulduğunuzda ya da geliştirme önerileriniz varsa, lütfen bana ulaşın veya bir **issue** açın. Katkıda bulunmak isterseniz, **pull request** gönderebilirsiniz.

--- 

