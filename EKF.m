% EKF simulink block
function [X_pred1, P_pred1] = fcn(wm,theta,vt,ia,P)

w_est = 1*wm + 0.0005*ia + (-7.0677e-04*cos(theta)-1.4873e-04);
i_est = -0.0006*wm + 0.9991*ia + 3.5714e-04*vt;
X_pred1 = [w_est; i_est]; % prediksi state

Fk= [1.0000 0.0005; % jacobian
 -0.0006 0.9991];
Q =[0.5 0; 0 0.5]; % kovarians proses

P_pred1 = Fk*P*Fk'+ Q; % kovarians prediksi

function [w_est, P_pred2, i_est] = fcn(X_pred1, P_pred1, ia)

Hk = [0 0;0 1]; % jacobian
R = [0.5 0; 0 0.5]; % kovarians proses

yk = Hk*[0;ia]; % vektor observasi
Sk = Hk*P_pred1*Hk' + R; % kovarians inovasi

K_gain = P_pred1*Hk'*(Sk^-1); % kalman gain

X_pred2 = X_pred1 + K_gain*(yk - Hk*X_pred1); % estimasi state
P_pred2 = P_pred1*(eye(2)-K_gain*Hk); % estimasi kovarians prediksi

w_est = X_pred2(1); % estimasi kecepatan
i_est = X_pred2(2); % estimasi arus