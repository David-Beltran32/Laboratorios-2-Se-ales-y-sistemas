classdef Rampa2<Signal
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods
        function obj = Rampa2(lim_inf, lim_sup, h_t, discreta)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            obj = obj@Signal(lim_inf, lim_sup, h_t, discreta);
        end
        
        function  [tiempo, y_t] = calcular(obj)
            ta = obj.lim_inf;
            tb = obj.lim_sup;
            tq=tb-ta;
            tiempo = ta:1e-03:tb;
            m = 0.825;
            if obj.discreta == 0
                    tiempo = ta: tq/20: tb;              
            end
            y_t = (tiempo <= ta + 0.3*tq).*(0.4*m*tq*ones(1)) + ((ta + 0.3*tq < tiempo) &...
                (tiempo < ta + 0.7*tq)).*(m*(ta + 0.7*tq) - m*tiempo) + ...
                (tiempo >= ta + 0.7*tq).*(0);
            
            if obj.discreta == 0
                tiempo = ta:length(y_t) - 1;                
            end
        end         
    end
end

