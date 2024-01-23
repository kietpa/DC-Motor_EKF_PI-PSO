tstart = tic;
% PSO parameters 
nVar = 2;   
ub = [30 50];    
lb = [0 0];   
fobj = @PSO_tuning;      

noP = 25;    
maxIter = 30;  
wMax = 1;
wMin = 0.1;
c1 = 2;
c2 = 2;


% Initialize
for k = 1 : noP
    Swarm.Particles(k).X = (ub-lb) .* rand(1,nVar) + lb; % posisi awal
    Swarm.Particles(k).V = zeros(1, nVar); % kecepatan awal
    Swarm.Particles(k).PBEST.X = zeros(1,nVar); 
    Swarm.Particles(k).PBEST.O = inf; % Pbest awal
    
    Swarm.GBEST.X = zeros(1,nVar); 
    Swarm.GBEST.O = inf; % Gbest awal
end
vMax = (ub - lb) .* 0.2; 
vMin  = -vMax;

% Main loop
for t = 1 : maxIter 
    % Fitness value
    for k = 1 : noP
        currentX = Swarm.Particles(k).X;
        Swarm.Particles(k).O = fobj(currentX);
        % Update Best Position
        if Swarm.Particles(k).O < Swarm.Particles(k).PBEST.O 
            Swarm.Particles(k).PBEST.X = currentX;
            Swarm.Particles(k).PBEST.O = Swarm.Particles(k).O;
        end
        % Update Global Best
        if Swarm.Particles(k).O < Swarm.GBEST.O
            Swarm.GBEST.X = currentX;
            Swarm.GBEST.O = Swarm.Particles(k).O;
        end
    end
    % Update X and V
    w = wMax - t .* ((wMax - wMin) / maxIter);
    for k = 1 : noP
        % update V
        Swarm.Particles(k).V = w .* Swarm.Particles(k).V ...
        + c1 .* rand(1,nVar) .* (Swarm.Particles(k).PBEST.X - Swarm.Particles(k).X) ...
        + c2 .* rand(1,nVar) .* (Swarm.GBEST.X - Swarm.Particles(k).X);                                                                         
        % Check V
        index1 = find(Swarm.Particles(k).V > vMax);
        index2 = find(Swarm.Particles(k).V < vMin);
        
        Swarm.Particles(k).V(index1) = vMax(index1);
        Swarm.Particles(k).V(index2) = vMin(index2);
        % update X
        Swarm.Particles(k).X = Swarm.Particles(k).X + Swarm.Particles(k).V;
        % Check X 
        index1 = find(Swarm.Particles(k).X > ub);
        index2 = find(Swarm.Particles(k).X < lb);
        
        Swarm.Particles(k).X(index1) = ub(index1);
        Swarm.Particles(k).X(index2) = lb(index2);
    end
    
    outmsg = ['Iterasi#', num2str(t) , ' Global Best = ' , num2str(Swarm.GBEST.O),' X = ', num2str(Swarm.GBEST.X)];
    disp(outmsg);
    
    cgCurve(t) = Swarm.GBEST.O;
end
% Plot Iterations
semilogy(cgCurve);
xlabel('Iterasi')
ylabel('Weight')
tend = toc(tstart);
disp(tend);