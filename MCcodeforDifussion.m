clear all
clc

% Initializing simulation Parameters
N = 100; %Number of simulaltions

%Properties of Aluminium
sigma_a = 0.235; % Absorption
sigma_s = 1.4; % Scatter
sigma_t = sigma_a + sigma_s; % Total
p = sigma_s / sigma_t;
A = 26.981539; % Atomic weight
R = 1; % Radius of Circle

% Initialization of Counters
WGT = 1;
FLUX = 0;
ESCAP = 0;
SCAT = 0;
ABS = 0;
i = 0; % Simulation counter
% Data Storage
fid=fopen('abcd.txt','w');
fprintf(fid,'|-------|-------|----------|------------|-------|-------|');
fprintf(fid,'\r\n|  Iterations\t| Distance Travelled\t|     FLUX\t    |\r\n');
fprintf(fid,'|-------|-------|----------|------------|-------|-------|');
fprintf(fid,'\r\n');

% Simulation Loop
while i<N
   Xpos =0; Ypos = 0; Zpos = 0;
   cos_theta = 2*rand - 1;
   PHI = 2*pi*2;
   sin_theta = sqrt(1-cos_theta^2);
   DTC = (-1/sigma_t)*log(1-rand)
   
   %New position Partical
   Xpos = Xpos + DTC * sin_theta * cos_theta;
   Ypos = Ypos + DTC * sin_theta * PHI;
   Zpos = Zpos + DTC * cos_theta;
   CHK_dist = sqrt (Xpos^2 + Ypos^2 + Zpos^2)
   
   if CHK_dist >= R
       ESCAP = ESCAP + 1;
       FLUX = 0;
   else
       FLUX = FLUX + WGT * DTC;
       %Collusion Detection
       t=rand;
       if t <= p
          SCAT = SCAT + 1;
       else
           ABS = ABS +1;
       end
   end
   
   fprintf(fid,'|  %d\t        |    %d\t    |  %d\t        | ',...
        i,CHK_dist,FLUX);
  fprintf(fid,'\r\n');
   CHK_dist = 0;
   i=i+1;
end
   
fprintf(fid,'|-------|-------|-------|-------|--------------------------');
fprintf(fid,'\r\nNo. Escap Particales:     ');
fprintf(fid,'%d',ESCAP);
fprintf(fid,'\r\nNo. Scatter Particales:   ');
fprintf(fid,'%d',SCAT);
fprintf(fid,'\r\nNo. Absorb Particales:   ');
fprintf(fid,'%d',ABS);

