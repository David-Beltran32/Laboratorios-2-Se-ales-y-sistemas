classdef Exponencial<Signal
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
            % Se discretiza el tiempo en caso de que la señal sea discreta.
            if obj.discreta == 0
                tiempo = unique(round(tiempo));                
            end
            y_t = obj.amplitud*exp(-obj.exponente*(tiempo - obj.lim_inf));
        end         
    end
end

