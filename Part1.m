%Case Study 2 Part 1
%Creating an SIRD Model.
%The plan is to create a model that follows x(t+1) = Ax(t) for t > 0, until the final time step T has been reached.
%The algorithm will operate as follows:
%1. For a given matrix time invariant A, x(t+1) = Ax(t) will be calculated.
% x(t=1) = (99, 1, 0, 0)^T. 
%2. Let the matrix P represent the time series matrix of the population x
%at time t. P[1] = x_1. At each time step we concatenate the new x(t+1) to
%p.
%3. Repeat steps (1) and (2) until T is reached or there is no longer a
%sus population.

%Model 1: No reinfections.

x_t = [95; 5; 0; 0];

A = [0.95, 0, 0, 0;
    0.05, 0.85, 0, 0;
    0, 0.10, 1, 0;
    0, 0.05, 0,1];

T = 499;

P = x_t;

for t = 1:T
    x_t_1 = A*x_t;
    P = cat(2,P,x_t_1);
    x_t = x_t_1;
end

figure()

hold on

title("Covid Spread Over 100 Days(Without Rounding)")

xlabel("Days")

ylabel("Population")

plot(P(1,:))

plot(P(2,:))

plot(P(3,:))

plot(P(4,:))

legend("Susceptible", "Infected", "Recovered", "Dead")

hold off

figure()

hold on

P = round(P, TieBreaker = "plusinf");

title("Covid Spread Over(With Rounding)")

xlabel("Days")

ylabel("Population")

plot(P(1,:))

plot(P(2,:))

plot(P(3,:))

plot(P(4,:))

legend("Susceptible", "Infected", "Recovered", "Dead")

hold off
%% 

%Model 2: Reinfections enabled

%Now we have a nonzero entry in the first entry of the vector representing
%infections.

y_t = [95, 5, 0, 0]';

B = [0.95, 0.19, 0, 0;
    0.05, 0.70, 0, 0;
    0, 0.1, 1, 0;
    0, 0.01, 0,1];

%Reinfection population matrix.

P_R = y_t;

for t = 1:T
    y_t_1 = B*y_t;
    P_R = cat(2,P_R,y_t_1);
    y_t = y_t_1;
end

figure()

hold on

title("Covid with Reinfection(Without Rounding)")

xlabel("Days")

ylabel("Population")

plot(P_R(1,:))

plot(P_R(2,:))

plot(P_R(3,:))

plot(P_R(4,:))

legend("Susceptible", "Infected", "Recovered", "Dead")

hold off

figure()

hold on

P_R = round(P_R, TieBreaker = "plusinf");

title("Covid w/ Reinfection Spread(With Rounding)")

xlabel("Days")

ylabel("Population")

plot(P_R(1,:))

plot(P_R(2,:))

plot(P_R(3,:))

plot(P_R(4,:))

legend("Susceptible", "Infected", "Recovered", "Dead")

hold off


