classdef Rampa1 < Signal
    %Clase Rampa1, contiene la información correspondiente a la señal
    %rampa 1.
    
    properties
    end
    
    methods
        function obj = Rampa1(lim_inf, lim_sup, h_t, discreta)
            % Constructor de la clase Rampa 1.
            % Se instancian las variables a utilizar.
            obj = obj@Signal(lim_inf, lim_sup, h_t, discreta);
        end
        
        function  [tiempo, y_t] = calcular(obj)
            ta = obj.lim_inf;
            tb = obj.lim_sup;
            tq=tb-ta;
            tiempo = ta:1e-03:tb;
            m = 0.825;
            % Se discretiza el tiempo.
            if obj.discreta == 0
                tiempo = ta: (tq)/20: tb;              
            end
            y_t = (tiempo <= ta + 0.3*tq).*(0) + ((ta + 0.3*tq < tiempo) &...
                (tiempo < ta + 0.7*tq)).*(m*tiempo - m*(ta + 0.3*tq)) + ...
                (tiempo >= ta + 0.7*tq).*(0.4*m*tq*ones(1));
            % Se construyen las 20 muestras con los datos originales.            
            if obj.discreta == 0
                tiempo = ta: ta + length(y_t) - 1;          
            end
        end     
        
    end
end

