function [JJ,He1,Le1,He2,Le2,Bf1,Bf2,HPS,Feul]=lab1_optimization(p1,p2,I1,I2,c,LPS,MPS,EP)
He1=(126*I1)/19 + (1231*c)/19 - (1800*p1)/19;

Le1=(1800*p1)/19 - (1250*c)/19 - (107*I1)/19;

Le2=(1800*p2)/19 - (107*I2)/19;

He2=(126*I2)/19 - (1800*p2)/19;

Bf1=LPS - I2 - I1 + MPS + c;

Bf2=(107*I1)/19 + (107*I2)/19 + LPS + (1250*c)/19 - (1800*p1)/19 - (1800*p2)/19;

HPS=I1+I2+Bf1;
Feul=(HPS)*3163/.75;
PP=p1+p2;
%%%
    C_Feul=10^(-6)*1.5;
    C_C=.008;
    C_EP=.05;
    C_PP=.02;
    C_demant_penalty=0.001;
  
%%%
    JJ=C_Feul*Feul+C_C*c+C_PP*PP+C_EP*EP+C_demant_penalty*(12000-EP);
   %     JJ=C_Feul*Feul+C_C*c+C_PP*PP+C_EP*EP;

return
