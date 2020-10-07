classdef Exponencial < Signal
    %Clase Exponencial, contiene la información correspondiente a la señal
    %exponencial.
    
    properties
        exponente         % Exponente.
        amplitud          % Amplitud de la señal.
    end
    
    methods
        function obj = Exponencial(exponente, amplitud, lim_inf, lim_sup, h_t, discreta)
            % Constructor de la clase Exponencial.
            % Se instancian las variables a utilizar.
            obj = obj@Signal(lim_inf, lim_sup, h_t, discreta);
            obj.exponente = exponente;
            obj.amplitud = amplitud;
        end
        
        function  [tiempo, y_t] = calcular(obj)
            tiempo = obj.lim_inf: 1e-03: obj.lim_sup;  
            if obj.discreta == 0
                tiempo = obj.lim_inf:(obj.lim_sup-obj.lim_inf)/20 : obj.lim_sup;                
            end
            y_t = obj.amplitud*exp(-obj.exponente*(tiempo - obj.lim_inf));
            % Se construyen las 20 muestras con los datos originales. 
            if obj.discreta == 0
                tiempo = obj.lim_inf: obj.lim_inf + length(y_t) - 1;                
            end 
        end         
    end
end

