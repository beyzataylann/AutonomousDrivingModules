N = 100;  % Zaman adımı sayısı
Q = 0.1;  % İşlem gürültüsü kovaryansı
R = 1.0;  % Ölçüm gürültüsü kovaryansı

% Sensör bozucu parametreleri
gps_bias = 0.5;  % GPS bias 
imu_bias = 0.2;  % IMU bias
gps_scale_factor = 1.1;  % GPS ölçek faktörü
imu_scale_factor = 0.9;  % IMU ölçek faktörü

x_true = zeros(1, N); % Gerçek konum 
z_gps = zeros(1, N);  % GPS ölçümleri
x_est_gps = zeros(1, N);  % GPS tahmini
P_gps = zeros(1, N);      % Hata kovaryansı (GPS)

z_imu = zeros(1, N);  % IMU ölçümleri 
x_est_imu = zeros(1, N);  % IMU tahmini
P_imu = zeros(1, N);      % Hata kovaryansı (IMU)

x_true(1) = 0;  % Başlangıç konumu
z_gps(1) = x_true(1) + sqrt(R) * randn;  % GPS ölçümü
z_imu(1) = x_true(1) + sqrt(R) * randn;  % IMU ölçümü
x_est_gps(1) = 0;
x_est_imu(1) = 0;
P_gps(1) = 1;
P_imu(1) = 1;

x_est_fusion = zeros(1, N);  % Füzyon tahmini
P_fusion = 0.5;  % Füzyon için hata kovaryansı

for k = 2:N
    % Gerçek konum güncellemesi 
    w = sqrt(Q) * randn; % Süreç gürültüsü 
    x_true(k) = x_true(k-1) + w;  % 
    
    
    v_gps = sqrt(R) * randn; % GPS ölçüm gürültüsü
    z_gps(k) = gps_scale_factor * (x_true(k) + gps_bias) + v_gps;  
    
    v_imu = sqrt(R) * randn; % IMU ölçüm gürültüsü
    z_imu(k) = imu_scale_factor * (x_true(k) + imu_bias) + v_imu;  
    
    % Sensör füzyonu - Ağırlıklı ortalama
    K_gps = P_gps(k-1) / (P_gps(k-1) + R);  % GPS için Kalman kazancı
    K_imu = P_imu(k-1) / (P_imu(k-1) + R);  % IMU için Kalman kazancı

    % Sensör füzyonu- Ağırlıklı ortalama
    x_est_fusion(k) = (K_gps * z_gps(k) + K_imu * z_imu(k)) / (K_gps + K_imu);
    
    % Füzyon sonrası hata kovaryansı
    P_fusion = 1 / (1 / P_gps(k-1) + 1 / P_imu(k-1));
    
    % Kalman Filtresi - Füzyon
    % PREDICT Aşaması
    x_pred_fusion = x_est_fusion(k);  % Füzyon tahmini
    P_pred_fusion = P_fusion + Q;  % Füzyon hata kovaryansı güncellemesi
    
    % UPDATE Aşaması
    K_fusion = P_pred_fusion / (P_pred_fusion + R);  % Kalman kazancı
    x_est_fusion(k) = x_pred_fusion + K_fusion * (z_gps(k) - x_pred_fusion);  % Füzyon tahmini
    P_fusion = (1 - K_fusion) * P_pred_fusion;  % Füzyon hata kovaryansı güncellemesi
    
    % Kalman Filtresi - GPS
    % PREDICT Aşaması
    x_pred_gps = x_est_gps(k-1);
    P_pred_gps = P_gps(k-1) + Q;  
    
    % UPDATE Aşaması
    K_gps = P_pred_gps / (P_pred_gps + R);  % Kalman kazancı
    x_est_gps(k) = x_pred_gps + K_gps * (z_gps(k) - x_pred_gps);  % GPS tahmini
    P_gps(k) = (1 - K_gps) * P_pred_gps;  % Hata kovaryansı güncellemesi
    
    % Kalman Filtresi - IMU
    % PREDICT Aşaması
    x_pred_imu = x_est_imu(k-1);
    P_pred_imu = P_imu(k-1) + Q;  
    
    % UPDATE Aşaması
    K_imu = P_pred_imu / (P_pred_imu + R);  % Kalman kazancı
    x_est_imu(k) = x_pred_imu + K_imu * (z_imu(k) - x_pred_imu);  % IMU tahmini
    P_imu(k) = (1 - K_imu) * P_pred_imu;  % Hata kovaryansı güncellemesi
end


figure;

subplot(2,1,1);
plot(time, x_true, 'k-', 'LineWidth', 2); hold on; % Gerçek konum
plot(time, z_gps, 'ro', 'MarkerFaceColor', 'r'); % GPS ölçümleri
plot(time, z_imu, 'bo', 'MarkerFaceColor', 'b'); % IMU ölçümleri
plot(time, x_est_gps, 'g-', 'LineWidth', 1.5); % GPS tahmini
plot(time, x_est_imu, 'b-', 'LineWidth', 1.5); % IMU tahmini
plot(time, x_est_fusion, 'm-', 'LineWidth', 2); % Füzyon tahmini

xlabel('Zaman Adımı');
ylabel('Konum');
title('Konum Tahminleri ve Ölçümleri');
legend('Gerçek Konum', 'GPS Ölçümü', 'IMU Ölçümü', 'GPS Tahmini', 'IMU Tahmini', 'Füzyon Tahmini');
grid on;