amplitud = 1;
periodo = 5;
exponente = 1;
lim_inf = 0;
lim_sup = 5;
h_t = false;
discreta = 1;

if h_t == true   
    expo = Exponencial(exponente, amplitud, lim_inf, lim_sup, h_t, discreta); 
else
    expo = Exponencial(exponente, amplitud, 0, 2, h_t, discreta);
end
% % [t1, y1] = expo.calcular();
[t2, y2] = expo.calcular();

% if h_t == true   
%     rampa = Rampa1(lim_inf, lim_sup, h_t, discreta); 
% else
%     rampa = Rampa1(0, 10, h_t, discreta);
% end
% [t1, y1] = rampa.calcular();

h_t = true;
if h_t == true   
    rampa2 = Rampa3(lim_inf, lim_sup, h_t, discreta); 
else
    rampa2 = Rampa3(0, 10, h_t, discreta);
end
% [t2, y2] = rampa2.calcular();
% 
% h_t = false;
% if h_t == true   
%     triang = Triangular(periodo, amplitud, lim_inf, lim_sup, h_t, discreta); 
% else
%     triang = Triangular(periodo, amplitud, 0, 5, h_t, discreta);
% end
[t1, y1] = rampa2.calcular();

% h_t = true;
% if h_t == true   
%     seno = Seno(periodo, amplitud, lim_inf, lim_sup, h_t, discreta); 
% else
%     seno = Seno(periodo, amplitud, 0, 5, h_t, discreta);
% end
% [t2, y2] = triang.calcular();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if h_t == true
    convolucion(t2, t1, y2, y1, discreta);
else
    convolucion(t1, t2, y1, y2, discreta);
end

function convolucion(t1, t2, y1, y2, discreta)
    %longuitud f
    l=length(t1);
    %longuitud h
    m=length(t2);
    %longuitud y
    y=l+m-1;
    %vector y
    y_t=zeros(1,y);
    %tiempo y
    ty=min(t1)+min(t2):(max(t1)+max(t2)-(min(t1)+min(t2)))/(y-1):max(t1)+max(t2);
    %tiempo animacioj
    tani=min(t1)-(max(t2)-min(t2)):(max(t2)-min(t2))/(m-1):min(t1);
    frames=(ty(2)-ty(1));
    %Reflejar h(t)
    h2 = fliplr(y2);
    for i=1:y
       for j=1:m
           if (i-j+1>0 && i-j<m && j<=l )
               if discreta == 0
                    y_t(i)= y_t(i) + y1(j)*y2(i-j+1);
               else
                    y_t(i) = y_t(i) + 1e-03*y1(j)*y2(i - j + 1);
               end
           end
       end
       if discreta == 0
            subplot(2,1,1)
            stem(tani,h2, 'b-')
            hold on
            stem(t1,y1, 'm-')
            hold off
            subplot(2,1,2)
            stem(ty,y_t, 'g-')
            pause(1)
       else
           subplot(2,1,1)
           plot(t1,y1, 'b-');
           hold on;
           plot(tani,h2, 'm-')
           hold off;
           subplot(2,1,2)
           plot(ty, y_t, 'g-')
           pause(1e-10)
       end
       tani = frames + tani;
    end
end