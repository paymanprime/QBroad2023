clc
clear
close all

I = eye(2);
ket0 = [1;0];
ket1 = [0;1];
ket00 = kron(ket0,ket0);
ket01 = kron(ket0,ket1);
ket10 = kron(ket1,ket0);
ket11 = kron(ket1,ket1);
ket0000 = kron(ket00,ket00);
ket0001 = kron(ket00,ket01);
ket0010 = kron(ket00,ket10);
ket0011 = kron(ket00,ket11);
ket0100 = kron(ket01,ket00);
ket0101 = kron(ket01,ket01);
ket0110 = kron(ket01,ket10);
ket0111 = kron(ket01,ket11);
ket1000 = kron(ket10,ket00);
ket1001 = kron(ket10,ket01);
ket1010 = kron(ket10,ket10);
ket1011 = kron(ket10,ket11);
ket1100 = kron(ket11,ket00);
ket1101 = kron(ket11,ket01);
ket1110 = kron(ket11,ket10);
ket1111 = kron(ket11,ket11);


% Quantum system without noise
syms a0 a1 real

Psi = 0.5.*(kron(ket0000,ket00)+kron(ket0101,ket01)+kron(ket1010,ket10)+kron(ket1111,ket11));
rho = Psi*conj(Psi');

U_MB=[a0^2/(a0^2 + a1^2)^2,  (a0*a1)/(a0^2 + a1^2)^2,  (a0*a1)/(a0^2 + a1^2)^2,     a1^2/(a0^2 + a1^2)^2
     (a0*a1)/(a0^2 + a1^2)^2,    -a0^2/(a0^2 + a1^2)^2,     a1^2/(a0^2 + a1^2)^2, -(a0*a1)/(a0^2 + a1^2)^2
     (a0*a1)/(a0^2 + a1^2)^2,     a1^2/(a0^2 + a1^2)^2,    -a0^2/(a0^2 + a1^2)^2, -(a0*a1)/(a0^2 + a1^2)^2
      a1^2/(a0^2 + a1^2)^2, -(a0*a1)/(a0^2 + a1^2)^2, -(a0*a1)/(a0^2 + a1^2)^2,     a0^2/(a0^2 + a1^2)^2];

U_Charlie = U_Charlie_gen();
Unitary = kron(eye(4),U_Charlie);
rho = Unitary*(rho*conj(Unitary'));
rho = M_Charlie(rho);
Unitary = kron(U_MB,eye(4));
rho = simplify(Unitary*(rho*conj(Unitary')));
Unitary = U_Alice_gen();
rho = simplify(Unitary*(rho*conj(Unitary')));
rho = simplify(M_Alice(rho));
out = kron([a0;a1],[a0;a1]);
in1 = kron([a0;a1],[a0;a1]);
in2 = kron([a0;a1],[-a1;a0]);
in3 = kron([-a1;a0],[a0;a1]);
in4 = kron([-a1;a0],[-a1;a0]);
Unitary = 1/2*(out*in1'+out*in2'+out*in3'+out*in4');
rho = simplify(Unitary*(rho*conj(Unitary')));

% Quantum system with Amplitude-Damping noise
syms P_AD real

E_AD_0 = [1 0;0 sqrt(1-P_AD)];
E_AD_1 = [0 sqrt(P_AD);0 0];

Psi = 0.5.*(kron(ket0000,ket00)+kron(ket0101,ket01)+kron(ket1010,ket10)+kron(ket1111,ket11));
% AD noise over A1 and A2 qubits
% E_0 = kron(kron(E_AD_0,E_AD_0),kron(kron(E_AD_0,E_AD_0),kron(E_AD_0,E_AD_0)));
% E_1 = kron(kron(E_AD_1,E_AD_1),kron(kron(E_AD_1,E_AD_1),kron(E_AD_1,E_AD_1)));

% AD noise over A1 qubit
E_0 = kron(kron(E_AD_0,E_AD_0),kron(kron(I,I),kron(E_AD_0,E_AD_0)));
E_1 = kron(kron(E_AD_1,E_AD_1),kron(kron(I,I),kron(E_AD_1,E_AD_1)));

rho_AD = E_0*((Psi*conj(Psi'))*conj(E_0'))+E_1*((Psi*conj(Psi'))*conj(E_1'));

Unitary = kron(eye(4),U_Charlie);
rho_AD = Unitary*(rho_AD*conj(Unitary'));
rho_AD = M_Charlie(rho_AD);
Unitary = kron(U_MB,eye(4));
rho_AD = simplify(Unitary*(rho_AD*conj(Unitary')));
Unitary = U_Alice_gen();
rho_AD = simplify(Unitary*(rho_AD*conj(Unitary')));
rho_AD = simplify(M_Alice(rho_AD));
out = kron([a0;a1],[a0;a1]);
in1 = kron([a0;a1],[a0;a1]);
in2 = kron([a0;a1],[-a1;a0]);
in3 = kron([-a1;a0],[a0;a1]);
in4 = kron([-a1;a0],[-a1;a0]);
Unitary = 1/2*(out*in1'+out*in2'+out*in3'+out*in4');
rho_AD = simplify(Unitary*(rho_AD*conj(Unitary')));

% Quantum system with Phase-Damping noise
syms P_PD real

E_PD_0 = sqrt(1-P_PD).*eye(2);
E_PD_1 = sqrt(P_PD).*[1 0;0 0];
E_PD_2 = sqrt(P_PD).*[0 0;0 1];

Psi = 0.5.*(kron(ket0000,ket00)+kron(ket0101,ket01)+kron(ket1010,ket10)+kron(ket1111,ket11));
% PD noise over A1 and A2 qubits
E_0 = kron(kron(E_PD_0,E_PD_0),kron(kron(I,I),kron(E_PD_0,E_PD_0)));
E_1 = kron(kron(E_PD_1,E_PD_1),kron(kron(I,I),kron(E_PD_1,E_PD_1)));
E_2 = kron(kron(E_PD_2,E_PD_2),kron(kron(I,I),kron(E_PD_2,E_PD_2)));

% PD noise over A1 qubit
% E_0 = kron(kron(E_PD_0,E_PD_0),kron(kron(I,I),kron(I,I)));
% E_1 = kron(kron(E_PD_1,E_PD_1),kron(kron(I,I),kron(I,I)));
% E_2 = kron(kron(E_PD_2,E_PD_2),kron(kron(I,I),kron(I,I)));

rho_PD = E_0*((Psi*conj(Psi'))*conj(E_0'))+E_1*((Psi*conj(Psi'))*conj(E_1'));

Unitary = kron(eye(4),U_Charlie);
rho_PD = Unitary*(rho_PD*conj(Unitary'));
rho_PD = M_Charlie(rho_PD);
Unitary = kron(U_MB,eye(4));
rho_PD = simplify(Unitary*(rho_PD*conj(Unitary')));
Unitary = U_Alice_gen();
rho_PD = simplify(Unitary*(rho_PD*conj(Unitary')));
rho_PD = simplify(M_Alice(rho_PD));
out = kron([a0;a1],[a0;a1]);
in1 = kron([a0;a1],[a0;a1]);
in2 = kron([a0;a1],[-a1;a0]);
in3 = kron([-a1;a0],[a0;a1]);
in4 = kron([-a1;a0],[-a1;a0]);
Unitary = 1/2*(out*in1'+out*in2'+out*in3'+out*in4');
rho_PD = simplify(Unitary*(rho_PD*conj(Unitary')));

syms t p
syms a3 a4 real
% B = cos(t/2).*ket0+exp(-1i*p).*sin(t/2).*ket1;
% D = cos(t/2).*ket0+exp(-1i*p).*sin(t/2).*ket1;
B = a0.*ket0+a1.*ket1;
D = a0.*ket0+a1.*ket1;

BD = kron(B,D);

Fidelity = simplify(conj(BD')*(rho*BD));
% simplify(sum(sum(rho*rho_AD)))
Fidelity_AD = simplify(conj(BD')*(rho_AD*BD));
Fidelity_PD = simplify(conj(BD')*(rho_PD*BD));
% F_AD = simplify(sum(sum(rho*rho_AD)))
% F_PD = simplify(sum(sum(rho*rho_PD)))
% F_AD = simplify(subs(F_AD,a1,sqrt(1-a0^2)));
% F_PD = simplify(subs(F_PD,a1,sqrt(1-a0^2)));




