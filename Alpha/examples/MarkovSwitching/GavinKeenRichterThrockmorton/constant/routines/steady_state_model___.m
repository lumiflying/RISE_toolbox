%% Code automagically generated by rise on 04-Sep-2013 09:46:38

function [y,param]=steady_state_model___(y,x,ss,param,def,s0,s1)

y=zeros(13,1);
y(7)=(param(22)-1)/param(22);
y(13)=param(24);
y(1)=param(2);
y(9)=1/y(1)-1+param(5);
param(16)=param(13)/y(1);
y(10)=param(16);
y(8)=max(1,y(10));
y(6)=y(1)*y(8);
y(11)=(y(7)*y(13)/(y(9)^param(1)*(1-param(1))^(1-param(1))*param(1)^param(1)))^(1/(1-param(1)));
param(9)=param(5)/y(13)*(param(1)/(1-param(1))*y(11)/y(9))^(1-param(1));
param(3)=(1-param(8)-param(9));
param(11)=((1-param(1))/param(1)*y(9)/y(11))^param(1)/y(13);
y(12)=(y(11)/(param(4)*param(11)^param(6)*param(3)^param(19)))^(1/(param(6)+param(19)));
y(5)=param(11)*y(12);
y(3)=param(9)*y(12);
y(4)=param(1)/(1-param(1))*y(11)/y(9)*y(5);
y(2)=param(3)*y(12);
param(7)=param(8)*y(12);
