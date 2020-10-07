classdef Triangular < Signal
    %Clase Triangular, contiene la información correspondiente a la señal
    %triangular.
    
    properties
        periodo         % Frecuencia de la señal.
        amplitud        % Amplitud de la señal.
    end
    
    methods
        function obj = Triangular(periodo, amplitud, lim_inf, lim_sup, h_t, discreta)
            % Constructor de la clase Triangular.
            % Se instancian las variables a utilizar.
            obj = obj@Signal(lim_inf, lim_sup, h_t, discreta);
            obj.periodo = periodo;
            obj.amplitud = amplitud;
        end
        
        function  [tiempo, y_t] = calcular(obj)
            if obj.h_t == true   
                obj.periodo = obj.lim_sup - obj.lim_inf;
                tiempo = obj.lim_inf: 1e-03: obj.lim_sup;
                % Se discretiza el tiempo.
                if obj.discreta == 0
                    tiempo = obj.lim_inf: obj.periodo/20: obj.lim_sup;              
                end 
            else
                tiempo = 0: 1e-03: obj.periodo;
                % Se discretiza el tiempo.
                if obj.discreta == 0
                    tiempo = 0: obj.periodo/20: obj.periodo;              
                end 
            end           
            y_t = obj.amplitud*sawtooth(2*pi*(tiempo - obj.lim_inf)/...
                obj.periodo + (pi/2),0.5);
            % Se construyen las 20 muestras con los datos originales.            
            if obj.discreta == 0
                tiempo = obj.lim_inf: obj.lim_inf + length(y_t) - 1;                
            end             
        end       
    end
end

