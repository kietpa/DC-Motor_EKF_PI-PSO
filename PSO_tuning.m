function fitness = PSO_tuning(kk) % init
assignin('base', 'kk', kk);
sim('Offline_Tuning.slx');
int_error = ITAE_2(length(ITAE_2));

setp = 100; % input

result = stepinfo(omega_2, time, setp);

risetime = result.RiseTime;
overshoot = result.Overshoot;
settlingtime = result.SettlingTime;
err_ss = abs(setp-omega_2(end));

Fitness1 = (risetime)*50;
Fitness2 = (err_ss)*1;
Fitness3 = (overshoot)*1;
Fitness4 = int_error*5;
Fitness5 = settlingtime*5;
% 50 1 0.8 5 5

fitness = Fitness1 + Fitness2 + Fitness3 + Fitness4 + Fitness5;
    
end
