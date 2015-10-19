function res = fly(m, cap)

clf;
clc;
cla;
thrust = [.270*4; .410*4; .520*4; .620*4; .710*4; .800*4; .880*4; .950*4; 1.020*4; 1.080*4; 1.190*4; 1.290*4; 1.360*4]; % -g
amps = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10; 12; 14; 15.3];
thrust = thrust .* 9.8; % convert the values to N
massC = 1.664; % kg
massT = (massC + m) * 9.8; % Newtons
lift = thrust - massT; % Newtons
timeF = cap ./ amps
initX = zeros(13, 1);
initV = zeros(13, 1);
results = zeros(13, 1);
hold on;
    for i = 1:13
        current_lift = lift(i);
        [T, Y] = ode45(@dragsolver, 1:timeF(i), [initX(i); initV(i)]);
        if Y(end, 1) > 0
            
            results(i) = Y(end, 1);
            velfinal(i) = Y(end, 2);
            xlabel('time (sec)')
            ylabel('acceleration (m/s/s)')
            legend('1 amp', '2 amp', '3 amp', '4 amp', '5 amp', '6 amp', '7 amp', '8 amp', '9 amp', '10 amp', '12 amp', '14 amp', '15.3 amp') 
        else
            results(i) = 0;
            velfinal(i) = 0;
        end
    end
    function res = dragsolver(t, X)
        v = X(2);
        Cd = 0.80; % drag coefficient
        A = .498 * .050; % cross sectional area
        den = 1.225; % kg/m^3
        drag = (1/2) * den * v^2 * Cd * A;
        fore = current_lift - drag; %forward motion
        a = fore./massT; 
        afinal = a - drag ./ massT;
        res = [v; afinal];
    end
xlabel('amps');
ylabel('distance (m)');
plot(amps,results,'o', 'color', rand(1,3));
xlabel('amps');
ylabel('distance (m)')
figure 
plot(amps,velfinal,'o', 'color', rand(1,3));
xlabel('amps');
ylabel('final velocity (m/s)')
res = results; 
end 
