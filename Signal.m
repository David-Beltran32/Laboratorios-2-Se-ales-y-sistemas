classdef Signal
    % Clase señal, contiene la información común de todas las señales.
    
    properties
        lim_inf         % Límite inferior de la señal.
        lim_sup         % Límite superior de la señal.
        tiempo          % Intervalo de tiempo a graficar.
        y_t             % Funciónn y(t).
        h_t             % Booleano que determina si se convoluciona o no.
        discreta        % 0 si la señal es discreta 1 si es conitnua.
    end
    
    methods
        function obj = Signal(lim_inf, lim_sup, h_t, discreta)
            % Constructor de la clase Signal.
            % Se instancian las variables a utilizar.
            obj.lim_inf = lim_inf;
            obj.lim_sup = lim_sup;
            obj.h_t = h_t;
            obj.discreta = discreta;
        end
    end
end

