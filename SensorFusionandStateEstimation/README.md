# Sensör Füzyonu ile Konum Tahmini

## Proje Açıklaması
Bu proje, Kalman Filtresi kullanarak GPS ve IMU verilerini birleştirerek konum tahmini yapmayı amaçlamaktadır. Sensör füzyonu ile hataların minimize edilmesi hedeflenmiştir.

## Kullanılan Yöntemler
- **Kalman Filtresi**: GPS ve IMU verilerini filtrelemek ve daha doğru konum tahmini yapmak için kullanılmıştır.
- **Sensör Füzyonu**: GPS ve IMU verilerinin ağırlıklı ortalaması alınarak daha güvenilir bir tahmin elde edilmiştir.
- **Gürültü Modelleme**: Sensör ölçümlerine gürültü eklenerek gerçekçi bir simülasyon sağlanmıştır.

## Dosya İçeriği
- **main.m**: MATLAB kodu, Kalman filtresi ile GPS ve IMU sensörlerinden gelen verileri işleyerek konum tahmini yapmaktadır.

## Kullanılan Değişkenler
- `N`: Zaman adımı sayısı
- `Q`: İşlem gürültüsü kovaryansı
- `R`: Ölçüm gürültüsü kovaryansı
- `gps_bias`: GPS ölçüm hatası
- `imu_bias`: IMU ölçüm hatası
- `gps_scale_factor`: GPS ölçek faktörü
- `imu_scale_factor`: IMU ölçek faktörü
- `x_true`: Gerçek konum
- `z_gps`: GPS ölçümleri
- `z_imu`: IMU ölçümleri
- `x_est_gps`: GPS verileriyle yapılan konum tahmini
- `x_est_imu`: IMU verileriyle yapılan konum tahmini
- `x_est_fusion`: GPS ve IMU verilerinin füzyonu sonucu elde edilen konum tahmini
- `P_gps`, `P_imu`, `P_fusion`: Hata kovaryansları

## Çalıştırma Talimatları
1. MATLAB veya Octave ortamında `main.m` dosyasını çalıştırın.
2. Kod, Kalman Filtresi ile GPS ve IMU verilerini işler ve konum tahminlerini hesaplar.
3. Sonuçlar grafik olarak görüntülenir.

## Çıktılar
Kod çalıştırıldığında aşağıdaki  grafik üretilir:

![sensorfusion](https://github.com/user-attachments/assets/c0317106-0e35-431a-bb3a-e1c5ae019690)



Bu proje, temel bir sensör füzyonu yaklaşımı sunarak Kalman Filtresi'nin pratik uygulamasını göstermektedir.
