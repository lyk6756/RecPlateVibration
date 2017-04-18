% PROGRAM: Calculate the vibration modes of a rectangular plate
% with free-free boundary conditions by the Ritz method
% AUTHOR: Li Yukun @HIT
% DATE: 2017/4/18
%
% w{m,n}         Vibration shape functions with m*n orders
%
% omega(m,n)     Natural frequencies with m*n orders

%% Input
a = 5; % Length
b = 3; % Width
m = 5; % order x
n = 5; % order y

E = 210e9; % Young's modulus
v = 0.343; % Poisson's ratio
h = 0.001; % Thickness
rho = 7.85e3; % Density

D = E * h^3 / 12 / (1 - v^2);

%% Natural frequency
% $\alpha_m a$
alphaa(1) = 0;
alphaa(2) = 0;
alphaa(3) =  4.73004;
alphaa(4) =  7.85320;
alphaa(5) =  10.9956;
if m >= 6
    for i = 6 : m
        alphaa(i) = (2*i - 3) * pi / 2;
    end
end

% $\alpha_n b$
alphab(1) = 0;
alphab(2) = 0;
alphab(3) =  4.73004;
alphab(4) =  7.85320;
alphab(5) =  10.9956;
if n >= 6
    for i = 6 : n
        alphab(i) = (2*i - 3) * pi / 2;
    end
end

% $E_{mm}$
EE(1) = 0;
EE(2) = 0;
EE(3) = -12.3062;
EE(4) = -46.0501;
EE(5) = -98.9048;
if m >= 6
    for i = 6 : m
        EE(i) = -(i - 3/2) * pi * ( (i - 3/2) * pi - 2 );
    end
end

% $F_{nn}$
F(1) = 0;
F(2) = 0;
F(3) = -12.3062;
F(4) = -46.0501;
F(5) = -98.9048;
if n >= 6
    for i = 6 : n
        F(i) = -(i - 3/2) * pi * ( (i - 3/2) * pi - 2 );
    end
end

% $H_{mm}$
H(1) = 0;
H(2) = 12.0000;
H(3) = 49.4808;
H(4) = 108.925;
H(5) = 186.867;
if m >= 6
    for i = 6 : m
        H(i) = (i - 3/2) * pi * ( (i - 3/2) * pi + 6 );
    end
end

% $K_{nn}$
K(1) = 0;
K(2) = 12.0000;
K(3) = 49.4808;
K(4) = 108.925;
K(5) = 186.867;
if n >= 6
    for i = 6 : n
        K(i) = (i - 3/2) * pi * ( (i - 3/2) * pi + 6 );
    end
end

for i = 1:m
    for j = 1:n
        lambda2(i,j) = sqrt(alphaa(i)^4 * (b/a)^4 + 2 * ( v*EE(i)*F(j) + (1-v)*H(i)*K(j) ) * (b/a)^4 + alphab(j)^4);
        omega(i,j) = lambda2(i,j) / b^2 * sqrt(D/rho/h);
    end
end


%% Vibration mode
x=0:a/10:a;
y=0:b/10:b;
[x,y]=meshgrid(x,y);

if m >= 3
    for i = 3 : m
        C(i) = ( cosh(alphaa(i)) - cos(alphaa(i)) ) / ( sinh(alphaa(i)) - sin(alphaa(i)) );
    end
end

X{1} = 1;
X{2} = sqrt(3) * (1 - 2*x/a);
for i = 3:m
    X{i} = (cosh(alphaa(i)*x/a) + cos(alphaa(i)*x/a)) - C(i) * (sinh(alphaa(i)*x/a) + sin(alphaa(i)*x/a));
end

if n >= 3
    for i = 3 : n
        C(i) = ( cosh(alphab(i)) - cos(alphab(i)) ) / ( sinh(alphab(i)) - sin(alphab(i)) );
    end
end

Y{1} = 1;
Y{2} = sqrt(3) * (1 - 2*y/b);
for i = 3:n
    Y{i} = (cosh(alphab(i)*y/b) + cos(alphab(i)*y/b)) - C(i) * (sinh(alphab(i)*y/b) + sin(alphab(i)*y/b));
end

for i = 1:m
    for j = 1:n
        w{i,j} = X{i} .* Y{j};
    end
end


%% plot
for k = 2 : m*n
    i = ceil(k/n);
    j = mod(k,n);
    if j == 0
        j = n;
    end
    subplot(m,n,k);
    mesh(x,y,w{i, j});
    title(['f=',num2str(omega(i,j)/2/pi)]);
end
