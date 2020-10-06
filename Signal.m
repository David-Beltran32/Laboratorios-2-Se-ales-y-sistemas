classdef Signal
    % Clase se�al, contiene la informaci�n com�n de todas las se�ales.
    
    properties
        lim_inf         % L�mite inferior de la se�al.
        lim_sup         % L�mite superior de la se�al.
        tiempo          % Intervalo de tiempo a graficar.
        y_t             % Funci�nn y(t).
        h_t             % Booleano que determina si se convoluciona o no.
        discreta        % 0 si la se�al es discreta 1 si es conitnua.
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

