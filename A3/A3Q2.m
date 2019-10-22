close all;
clear;

T = 1;
N = 500;
x = ones(N);
t = linspace(0, T/2, N);

figure (1); hold on;
plot(t-1.5, -x, 'k')
plot(t-1, x, 'k')
plot(t-.5, -x, 'k')
plot(t, x, 'k')
plot(t+.5, -x, 'k')
plot(t+1, x, 'k')
title("Periodic Step Function")
xlabel("t")
ylim([-1.5 1.5])
ylabel("x(t)")

time = linspace(-3*T/2, 3*T/2, N);
f = zeros(1, N);
for n=1:2:N
    Sm = 4/(n*pi);
    f = f + Sm * sin(2*pi*n*time/T);
    terms = (n+1)/2;
    if terms==1 || terms==2 || terms==5 || terms==10 || terms==100
        figure(2); hold on;
        plot(time, f)
    end
end
title("Fourier transform of x(t)")
xlabel("t")
ylabel("x(t)")
legend('1 term', '2 terms', '5 terms', '10 terms', '100 terms');