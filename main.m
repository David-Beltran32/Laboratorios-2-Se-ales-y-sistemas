classdef main < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                       matlab.ui.Figure
        titleLabel                     matlab.ui.control.Label
        GraficarButton                 matlab.ui.control.Button
        TabGroup                       matlab.ui.container.TabGroup
        ftTab                          matlab.ui.container.Tab
        TipodeSealDropDownLabel        matlab.ui.control.Label
        TipodeSealDropDown             matlab.ui.control.DropDown
        Panel_2                        matlab.ui.container.Panel
        ecuacionLabel_xt               matlab.ui.control.Label
        campo1_xtLabel                 matlab.ui.control.Label
        campo1_xt                      matlab.ui.control.NumericEditField
        campo2_xtLabel                 matlab.ui.control.Label
        campo2_xt                      matlab.ui.control.NumericEditField
        campo3_xtLabel                 matlab.ui.control.Label
        campo3_xt                      matlab.ui.control.NumericEditField
        campo4_xtLabel                 matlab.ui.control.Label
        campo4_xt                      matlab.ui.control.NumericEditField
        htTab                          matlab.ui.container.Tab
        Panel_3                        matlab.ui.container.Panel
        ecuacionLabel_ht               matlab.ui.control.Label
        campo4_ht                      matlab.ui.control.NumericEditField
        campo4_htLabel                 matlab.ui.control.Label
        campo3_ht                      matlab.ui.control.NumericEditField
        campo3_htLabel                 matlab.ui.control.Label
        campo2_ht                      matlab.ui.control.NumericEditField
        campo2_htLabel                 matlab.ui.control.Label
        campo1_ht                      matlab.ui.control.NumericEditField
        campo1_htLabel                 matlab.ui.control.Label
        TipodeSealDropDown_2Label      matlab.ui.control.Label
        TipodeSealDropDown_2           matlab.ui.control.DropDown
        ConvolucionarButton            matlab.ui.control.Button
        DominiodelTiempoDropDownLabel  matlab.ui.control.Label
        DominiodelTiempoDropDown       matlab.ui.control.DropDown
        axposicion                     matlab.ui.control.UIAxes
        axconvo                        matlab.ui.control.UIAxes
        Image                          matlab.ui.control.Image
        infoLabel                      matlab.ui.control.Label
        axeht                          matlab.ui.control.UIAxes
        axeft                          matlab.ui.control.UIAxes
        creditosLabel                  matlab.ui.control.Label
        errorLabel                     matlab.ui.control.Label
        infoLabel1                     matlab.ui.control.Label
        infoLabel2                     matlab.ui.control.Label
    end

    
    methods (Access = private)
        
        function setf(~,xval,yval)
            global f
            f=[xval;yval];
        end
        
        function seth(~,xval,yval)
            global h 
            h=[xval;yval];
        end        
    end
    
    methods
        function showCamposXT1(app, bool1, bool2)
            app.campo1_xt.Visible = bool1;
            app.campo1_xtLabel.Visible = bool1;
            app.campo2_xt.Visible = bool2; 
            app.campo2_xtLabel.Visible = bool2;         
        end
        function showCamposXT2(app, bool1, bool2)
            app.campo3_xt.Visible = bool1;
            app.campo3_xtLabel.Visible = bool1;
            app.campo4_xt.Visible = bool2;   
            app.campo4_xtLabel.Visible = bool2;       
        end
        function showCamposHT1(app, bool1, bool2)
            app.campo1_ht.Visible = bool1;
            app.campo1_htLabel.Visible = bool1;
            app.campo2_ht.Visible = bool2;   
            app.campo2_htLabel.Visible = bool2;        
        end
        function showCamposHT2(app, bool1, bool2)
            app.campo3_ht.Visible = bool1;
            app.campo3_htLabel.Visible = bool1;
            app.campo4_ht.Visible = bool2;     
            app.campo4_htLabel.Visible = bool2;        
        end
        function mostrarGraficas(app, conv)
            t2 = [];
            t1 = [];
            if (app.TipodeSealDropDown.Value~=" " && app.TipodeSealDropDown_2~=" ")
                tipo_funcion = app.TipodeSealDropDown.Value;
                app.errorLabel.Visible = false;
                
                switch tipo_funcion                  
                    case "Seno"
                        amplitud = app.campo1_xt.Value;
                        periodo = app.campo2_xt.Value;
                        if amplitud ~= 0 && periodo ~= 0
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                seno = Seno(periodo, amplitud, 0, 5, false, 0); 
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                seno = Seno(periodo, amplitud, 0, 5, false, 1);
                            end
                            [t1, y1] = seno.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Cuadrada"
                        amplitud = app.campo1_xt.Value;
                        periodo = app.campo2_xt.Value;
                        if amplitud ~= 0 && periodo ~= 0
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                rect = Rectangular(periodo, amplitud, 0, 5, false, 0); 
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                rect = Rectangular(periodo, amplitud, 0, 5, false, 1);
                            end
                            [t1, y1] = rect.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Triangular"
                        amplitud = app.campo1_xt.Value;
                        periodo = app.campo2_xt.Value;
                        if amplitud ~= 0 && periodo ~= 0
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                triang = Triangular(periodo, amplitud, 0, 5, false, 0); 
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                triang = Triangular(periodo, amplitud, 0, 5, false, 1);
                            end
                            [t1, y1] = triang.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Exponencial"
                        amplitud = app.campo1_xt.Value;
                        exponente = app.campo2_xt.Value;
                        lim_inf = app.campo3_xt.Value;
                        lim_sup = app.campo4_xt.Value;
                        if amplitud ~= 0 && lim_sup > lim_inf && exponente ~= 0
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                expo = Exponencial(exponente, amplitud, lim_inf, lim_sup, false, 0);  
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                expo = Exponencial(exponente, amplitud, lim_inf, lim_sup, false, 1);  
                            end
                            [t1, y1] = expo.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Rampa 1"
                        lim_inf = app.campo1_xt.Value;
                        lim_sup = app.campo2_xt.Value;
                        if lim_sup > lim_inf
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                rampa1 = Rampa1(lim_inf, lim_sup, false, 0);  
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                rampa1 = Rampa1(lim_inf, lim_sup, false, 1);  
                            end
                            [t1, y1] = rampa1.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Rampa 2"
                        lim_inf = app.campo1_xt.Value;
                        lim_sup = app.campo2_xt.Value;
                        if lim_sup > lim_inf
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                rampa2 = Rampa2(lim_inf, lim_sup, false, 0);  
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                rampa2 = Rampa2(lim_inf, lim_sup, false, 1);  
                            end
                            [t1, y1] = rampa2.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Rampa 3"
                        lim_inf = app.campo1_xt.Value;
                        lim_sup = app.campo2_xt.Value;
                        if lim_sup > lim_inf
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                rampa3 = Rampa3(lim_inf, lim_sup, false, 0);  
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                rampa3 = Rampa3(lim_inf, lim_sup, false, 1);  
                            end
                            [t1, y1] = rampa3.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                end
                
                %   Señal impulso h(h)
                tipo_funcionh = app.TipodeSealDropDown_2.Value;
                app.errorLabel.Visible = false;
                switch tipo_funcionh                     
                    case "Seno"
                        amplitud = app.campo1_ht.Value;
                        lim_inf = app.campo2_ht.Value;
                        lim_sup = app.campo3_ht.Value;
                        if amplitud ~= 0 && lim_sup > lim_inf
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                seno = Seno(0, amplitud, lim_inf, lim_sup, true, 0); 
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                        
                                seno = Seno(0, amplitud, lim_inf, lim_sup, true, 1); 
                            end
                            [t2, y2] = seno.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Cuadrada"
                        amplitud = app.campo1_ht.Value;
                        lim_inf = app.campo2_ht.Value;
                        lim_sup = app.campo3_ht.Value;
                        if amplitud ~= 0 && lim_sup > lim_inf
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                rect = Rectangular(0, amplitud, lim_inf, lim_sup, true, 0); 
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                        
                                rect = Rectangular(0, amplitud, lim_inf, lim_sup, true, 1); 
                            end
                            [t2, y2] = rect.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Triangular"
                        amplitud = app.campo1_ht.Value;
                        lim_inf = app.campo2_ht.Value;
                        lim_sup = app.campo3_ht.Value;
                        if amplitud ~= 0 && lim_sup > lim_inf
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                triang = Triangular(0, amplitud, lim_inf, lim_sup, true, 0); 
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                        
                                triang = Triangular(0, amplitud, lim_inf, lim_sup, true, 1); 
                            end
                            [t2, y2] = triang.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Exponencial"
                        amplitud = app.campo1_ht.Value;
                        exponente = app.campo2_ht.Value;
                        lim_inf = app.campo3_ht.Value;
                        lim_sup = app.campo4_ht.Value;
                        if amplitud ~= 0 && lim_sup > lim_inf && exponente ~= 0
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                expo = Exponencial(exponente, amplitud, lim_inf, lim_sup, true, 0);  
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                        
                                expo = Exponencial(exponente, amplitud, lim_inf, lim_sup, true, 1); 
                            end
                            [t2, y2] = expo.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Rampa 1"
                        lim_inf = app.campo1_ht.Value;
                        lim_sup = app.campo2_ht.Value;
                        if lim_sup > lim_inf
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                rampa1 = Rampa1(lim_inf, lim_sup, true, 0);  
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                rampa1 = Rampa1(lim_inf, lim_sup, true, 1);  
                            end
                            [t2, y2] = rampa1.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Rampa 2"
                        lim_inf = app.campo1_ht.Value;
                        lim_sup = app.campo2_ht.Value;
                        if lim_sup > lim_inf
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                rampa2 = Rampa2(lim_inf, lim_sup, true, 0);  
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                rampa2 = Rampa2(lim_inf, lim_sup, true, 1);  
                            end
                            [t2, y2] = rampa2.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                        
                    case "Rampa 3"
                        lim_inf = app.campo1_ht.Value;
                        lim_sup = app.campo2_ht.Value;
                        if lim_sup > lim_inf
                            if app.DominiodelTiempoDropDown.Value == "Discreta"                            
                                rampa3 = Rampa3(lim_inf, lim_sup, true, 0);  
                            elseif app.DominiodelTiempoDropDown.Value == "Continua"                            
                                rampa3 = Rampa3(lim_inf, lim_sup, true, 1);  
                            end
                            [t2, y2] = rampa3.calcular();
                            error = false;
                        else
                            app.errorLabel.Visible = true;
                            error = true;
                        end
                end
            end
            if isempty(t2) || isempty(t1)                
                app.infoLabel1.Visible = false;            
                app.infoLabel2.Visible = false;
                app.errorLabel.Visible = true;
                error = true;
            end
            if error == false
                if conv == false
                    if app.DominiodelTiempoDropDown.Value == "Discreta"
                        stem(app.axeft, t1, y1, 'b-', 'DisplayName', app.ecuacionLabel_xt.Text);
                        legend(app.axeft);
                        stem(app.axeht, t2, y2, 'm-', 'DisplayName', app.ecuacionLabel_ht.Text);
                        legend(app.axeht);
                    else
                        plot(app.axeft, t1, y1, 'b-', 'DisplayName', app.ecuacionLabel_xt.Text);
                        legend(app.axeft);
                        plot(app.axeht, t2, y2, 'm-', 'DisplayName', app.ecuacionLabel_ht.Text);
                        legend(app.axeht);
                    end                
                else
                    if app.DominiodelTiempoDropDown.Value == "Discreta"
                        stem(app.axeft, t1, y1, 'b-', 'DisplayName', app.ecuacionLabel_xt.Text);
                        legend(app.axeft);
                        stem(app.axeht, t2, y2, 'm-', 'DisplayName', app.ecuacionLabel_ht.Text);
                        legend(app.axeht);
                        app.infoLabel1.Visible = true;
                    else
                        app.infoLabel2.Visible = true;
                        plot(app.axeft, t1, y1, 'b-', 'DisplayName', app.ecuacionLabel_xt.Text);
                        legend(app.axeft);
                        plot(app.axeht, t2, y2, 'm-', 'DisplayName', app.ecuacionLabel_ht.Text);
                        legend(app.axeht);
                    end  
                    if app.DominiodelTiempoDropDown.Value == "Discreta" 
                        %longuitud f
                        l=length(t1);
                        %longuitud h
                        m=length(t2);                        
                    else
                        if(length(t2)>length(t1))
                            %longuitud f
                            l=length(t1);
                            %longuitud h
                            m=length(t2);
                        else
                            %longuitud f
                            l=length(t2);
                            %longuitud h
                            m=length(t1);
                        end
                    end
                    %longuitud y
                    y=l+m-1;
                    %vector y
                    y_t=zeros(1,y);
                    %tiempo y
                    ty=min(t1)+min(t2):(max(t1)+max(t2)-(min(t1)+min(t2)))/(y-1):max(t1)+max(t2);
                    %tiempo animacioj
                    if app.DominiodelTiempoDropDown.Value == "Discreta"
                        tani=min(t1)-(max(t2)-min(t2)):(max(t2)-min(t2))/(m-1):min(t1);
                    else
                        if (length(t2)>length(t1))
                            tani=min(t1)-(max(t2)-min(t2)):(max(t2)-min(t2))/(m-1):min(t1);
                        else
                            tani=min(t1)-(max(t2)-min(t2)):(max(t2)-min(t2))/(l-1):min(t1);
                        end
                        
                    end  
                    frames=(ty(2)-ty(1));
                    h2=fliplr(y2);
                    for i=1:y                        
                       for j=1:m
                           if (i-j+1>0 && i-j<m && j<=l )
                               if app.DominiodelTiempoDropDown.Value == "Discreta"
                                    y_t(i)=y_t(i)+y1(j)*y2(i-j+1);
                               else                   
                                    if (length(t2)>length(t1))
                                        y_t(i) = y_t(i) + 1e-03*y1(j)*y2(i - j + 1);
                                    else
                                        y_t(i) = y_t(i) + 1e-03*y2(j)*y1(i - j + 1);
                                    end
                               end                               
                           end                          
                       end
                       if app.DominiodelTiempoDropDown.Value == "Discreta"
                            stem(app.axposicion, tani,h2, 'm-', 'DisplayName', "h[n-k]");
                            hold(app.axposicion, "on");
                            stem(app.axposicion, t1,y1, 'b-', 'DisplayName', "f[k]");
                            hold(app.axposicion, "off");
                            stem(app.axconvo, ty,y_t, 'g-', 'DisplayName', "f[n]*h[n]");
                            legend(app.axposicion);
                            legend(app.axconvo);
                            pause(1);
                       else
                           plot(app.axposicion, t1,y1, 'b-', 'DisplayName', "f(tau)");
                           hold(app.axposicion, "on");
                           plot(app.axposicion, tani,h2, 'm-', 'DisplayName', "h(t-tau)");
                           hold(app.axposicion, "off");
                           plot(app.axconvo, ty, y_t, 'g-', 'DisplayName', "f(t)*h(t)");
                           legend(app.axposicion);
                           legend(app.axconvo);
                           pause(1e-30);
                       end
                       tani = frames + tani;
                    end
                end 
            end
        end
    end
    

    % Callbacks that handle component events
    methods (Access = private)

        % Callback function: Panel_2, TipodeSealDropDown
        function DropDownValueChanged(app, event)
            tipo_funcion = app.TipodeSealDropDown.Value;
            app.errorLabel.Visible = false;                
            app.infoLabel1.Visible = false;            
            app.infoLabel2.Visible = false;
            
            switch tipo_funcion
                case " "
                    app.Panel_2.Visible = false;                    
                case "Seno"
                    app.Panel_2.Visible = true;
                    app.campo1_xtLabel.Text = "Amplitud: ";
                    app.campo2_xtLabel.Text = "Período: ";
                    app.campo3_xtLabel.Text = "";
                    app.campo4_xtLabel.Text = "";
                    if app.DominiodelTiempoDropDown.Value == "Discreta"
                        app.ecuacionLabel_xt.Text = "y[n]=A\sin{2\pi n/N_{o}";
                    else
                        app.ecuacionLabel_xt.Text = "y(t)=A\sin{2\pi t/T}";
                    end
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposXT1(app, true, true);
                    showCamposXT2(app, false, false);
                    
                case "Cuadrada"
                    app.Panel_2.Visible = true;
                    app.campo1_xtLabel.Text = "Amplitud: ";
                    app.campo2_xtLabel.Text = "Período: ";
                    app.campo3_xtLabel.Text = "";
                    app.campo4_xtLabel.Text = "";
                    app.ecuacionLabel_xt.Text = "Señal Cuadrada";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposXT1(app, true, true);
                    showCamposXT2(app, false, false);
                    
                case "Triangular"
                    app.Panel_2.Visible = true;
                    app.campo1_xtLabel.Text = "Amplitud: ";
                    app.campo2_xtLabel.Text = "Período: ";
                    app.campo3_xtLabel.Text = "";
                    app.campo4_xtLabel.Text = "";
                    app.ecuacionLabel_xt.Text = "Señal Triangular";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposXT1(app, true, true);
                    showCamposXT2(app, false, false);
                    
                case "Exponencial"
                    app.Panel_2.Visible = true;
                    app.campo1_xtLabel.Text = "Amplitud: ";
                    app.campo2_xtLabel.Text = "Exponente (b): ";
                    app.campo3_xtLabel.Text = "Lím. Inferior: ";
                    app.campo4_xtLabel.Text = "Lím. Superior: ";
                    if app.DominiodelTiempoDropDown.Value == "Discreta"
                        app.ecuacionLabel_xt.Text = "y[n]=A*exp(-b*n)";
                    else
                        app.ecuacionLabel_xt.Text = "y(t)=A*exp(-b*t)";
                    end
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposXT1(app, true, true);
                    showCamposXT2(app, true, true); 
                    
                case "Rampa 1"
                    app.Panel_2.Visible = true;
                    app.campo1_xtLabel.Text = "Lím. Inferior: ";
                    app.campo2_xtLabel.Text = "Lím. Superior: ";
                    app.campo3_xtLabel.Text = "";
                    app.campo4_xtLabel.Text = "";
                    app.ecuacionLabel_xt.Text = "Señal Rampa 1";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposXT1(app, true, true);
                    showCamposXT2(app, false, false); 
                    
                case "Rampa 2"
                    app.Panel_2.Visible = true;
                    app.campo1_xtLabel.Text = "Lím. Inferior: ";
                    app.campo2_xtLabel.Text = "Lím. Superior: ";
                    app.campo3_xtLabel.Text = "";
                    app.campo4_xtLabel.Text = "";
                    app.ecuacionLabel_xt.Text = "Señal Rampa 2";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposXT1(app, true, true);
                    showCamposXT2(app, false, false);   
                    
                case "Rampa 3"
                    app.Panel_2.Visible = true;
                    app.campo1_xtLabel.Text = "Lím. Inferior: ";
                    app.campo2_xtLabel.Text = "Lím. Superior: ";
                    app.campo3_xtLabel.Text = "";
                    app.campo4_xtLabel.Text = "";
                    app.ecuacionLabel_xt.Text = "Señal Rampa 3";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposXT1(app, true, true);
                    showCamposXT2(app, false, false);  
            end
        end

        % Button pushed function: GraficarButton
        function GraficarButtonPushed(app, event)
            mostrarGraficas(app, false);           
        end

        % Value changed function: DominiodelTiempoDropDown
        function DominiodelTiempoDropDownValueChanged(app, event)
            value = app.DominiodelTiempoDropDown.Value;
            app.errorLabel.Visible = false;               
            app.infoLabel1.Visible = false;            
            app.infoLabel2.Visible = false;
            switch value
                case " "
                    app.TipodeSealDropDown.Enable = false;
                    app.TipodeSealDropDown_2.Enable = false;
                    app.ConvolucionarButton.Visible=false;
                    app.GraficarButton.Visible=false;
                    showCamposHT1(app, false, false);
                    showCamposHT2(app, false, false);
                    showCamposXT1(app, false, false);
                    showCamposXT2(app, false, false);
                    
                case "Discreta"
                    app.TipodeSealDropDown.Enable = true;
                    app.TipodeSealDropDown_2.Enable = true;
                    app.ftTab.Title="f[n]";
                    app.htTab.Title="h[n]";
                    app.axeft.Title.String="f[n]";
                    app.axeht.Title.String="h[n]";
                    app.axeft.XLabel.String="n";
                    app.axeht.XLabel.String="n";
                    app.axconvo.XLabel.String="n";
                    app.axposicion.XLabel.String="n";
                    app.axeft.YLabel.String="f[n]";
                    app.axeht.YLabel.String="h[n]";
                    app.axconvo.YLabel.String="f[n]*h[n]";
                    app.axposicion.YLabel.String="f[n]*h[n]";
                    app.axconvo.Visible=true;
                    app.axeft.Visible=true;
                    app.axeht.Visible=true;
                    app.axposicion.Visible=true;
                    
                    app.TabGroup.Visible=true;
                    app.ConvolucionarButton.Visible=true;
                    app.GraficarButton.Visible=true;
                    switch app.TipodeSealDropDown.Value
                        case "Seno"
                            app.ecuacionLabel_xt.Text = "y[n]=A*Sen(2pi n/No)";
                        case "Exponencial"
                            app.ecuacionLabel_xt.Text = "y[n]=A*exp(-b*n)";                            
                    end
                    switch app.TipodeSealDropDown_2.Value
                        case "Seno"
                            app.ecuacionLabel_ht.Text = "y[n]=A*Sen(2pi n/No)";
                        case "Exponencial"
                            app.ecuacionLabel_ht.Text = "y[n]=A*exp(-b*n)";                    
                    end
                        
                case "Continua"
                    app.TipodeSealDropDown.Enable = true;
                    app.TipodeSealDropDown_2.Enable = true;
                    app.ftTab.Title="f(t)";
                    app.htTab.Title="h(t)";
                    app.axeft.Title.String="f(t)";
                    app.axeht.Title.String="h(t)";
                    app.axeft.XLabel.String="t";
                    app.axeht.XLabel.String="t";
                    app.axposicion.XLabel.String="t";
                    app.axconvo.XLabel.String="t";
                    app.axeft.YLabel.String="f(t)";
                    app.axeht.YLabel.String="h(t)";
                    app.axposicion.YLabel.String="f(t)*h(t)";
                    app.axconvo.YLabel.String="f(t)*h(t)";
                    app.axconvo.Visible=true;
                    app.axeft.Visible=true;
                    app.axeht.Visible=true;
                    app.axposicion.Visible=true;
                    app.TabGroup.Visible=true;
                    
                    app.ConvolucionarButton.Visible=true;
                    app.GraficarButton.Visible=true;
                    switch app.TipodeSealDropDown.Value
                        case "Seno"
                            app.ecuacionLabel_xt.Text = "y(t)=A*Sen(2pi t/T)";
                        case "Exponencial"
                            app.ecuacionLabel_xt.Text = "y(t)=A*exp(-bt)";                            
                    end
                    switch app.TipodeSealDropDown_2.Value
                        case "Seno"
                            app.ecuacionLabel_ht.Text = "y(t)=A*Sen(2pi t/T)";
                        case "Exponencial"
                            app.ecuacionLabel_ht.Text = "y(t)=A*exp(-bt)";                    
                    end                   
                    
            end
        end

        % Value changed function: TipodeSealDropDown_2
        function TipodeSealDropDown_2ValueChanged(app, event)
            %   Señal impulso h(h)            
            app.errorLabel.Visible = false;               
            app.infoLabel1.Visible = false;            
            app.infoLabel2.Visible = false;
            tipo_funcionh = app.TipodeSealDropDown_2.Value;
            
            switch tipo_funcionh 
                case " "
                    app.Panel_3.Visible = false;                    
                case "Seno"
                    app.Panel_3.Visible = true;
                    app.campo1_htLabel.Text = "Amplitud: ";
                    app.campo2_htLabel.Text = "Lím. Inferior: ";
                    app.campo3_htLabel.Text = "Lím. Superior: ";
                    app.campo4_htLabel.Text = "";
                    if app.DominiodelTiempoDropDown.Value == "Discreta"
                        app.ecuacionLabel_ht.Text = "y[n]=A\sin{2\pi n/N_{o}";
                    else
                        app.ecuacionLabel_ht.Text = "y(t)=A\sin{2\pi t/T}";
                    end
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposHT1(app, true, true);
                    showCamposHT2(app, true, false);
                    
                case "Cuadrada"
                    app.Panel_3.Visible = true;
                    app.campo1_htLabel.Text = "Amplitud: ";
                    app.campo2_htLabel.Text = "Lím. Inferior: ";
                    app.campo3_htLabel.Text = "Lím. Superior: ";
                    app.campo4_htLabel.Text = "";
                    app.ecuacionLabel_ht.Text = "Señal Cuadrada";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposHT1(app, true, true);
                    showCamposHT2(app, true, false);
                    
                case "Triangular"
                    app.Panel_3.Visible = true;
                    app.campo1_htLabel.Text = "Amplitud: ";
                    app.campo2_htLabel.Text = "Lím. Inferior: ";
                    app.campo3_htLabel.Text = "Lím. Superior: ";
                    app.campo4_htLabel.Text = "";
                    app.ecuacionLabel_ht.Text = "Señal Triangular";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposHT1(app, true, true);
                    showCamposHT2(app, true, false);
                    
                case "Exponencial"
                    app.Panel_3.Visible = true;
                    app.campo1_htLabel.Text = "Amplitud: ";
                    app.campo2_htLabel.Text = "Exponente (b): ";
                    app.campo3_htLabel.Text = "Lím. Inferior: ";
                    app.campo4_htLabel.Text = "Lím. Superior: ";
                    if app.DominiodelTiempoDropDown.Value == "Discreta"
                        app.ecuacionLabel_ht.Text = "y[n]=A*exp(-b*n)";
                    else
                        app.ecuacionLabel_ht.Text = "y(t)=A*exp(-b*t)";
                    end
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposHT1(app, true, true);
                    showCamposHT2(app, true, true); 
                    
                case "Rampa 1"
                    app.Panel_3.Visible = true;
                    app.campo1_htLabel.Text = "Lím. Inferior: ";
                    app.campo2_htLabel.Text = "Lím. Superior: ";
                    app.campo3_htLabel.Text = "";
                    app.campo4_htLabel.Text = "";
                    app.ecuacionLabel_ht.Text = "Señal Rampa 1";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposHT1(app, true, true);
                    showCamposHT2(app, false, false); 
                    
                case "Rampa 2"
                    app.Panel_3.Visible = true;
                    app.campo1_htLabel.Text = "Lím. Inferior: ";
                    app.campo2_htLabel.Text = "Lím. Superior: ";
                    app.campo3_htLabel.Text = "";
                    app.campo4_htLabel.Text = "";
                    app.ecuacionLabel_ht.Text = "Señal Rampa 2";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposHT1(app, true, true);
                    showCamposHT2(app, false, false);   
                    
                case "Rampa 3"
                    app.Panel_3.Visible = true;
                    app.campo1_htLabel.Text = "Lím. Inferior: ";
                    app.campo2_htLabel.Text = "Lím. Superior: ";
                    app.campo3_htLabel.Text = "";
                    app.campo4_htLabel.Text = "";
                    app.ecuacionLabel_ht.Text = "Señal Rampa 3";
                    app.ecuacionLabel_xt.Visible = true;
                    showCamposHT1(app, true, true);
                    showCamposHT2(app, false, false);   
            end
        end

        % Button pushed function: ConvolucionarButton
        function ConvolucionarButtonPushed(app, event)
            mostrarGraficas(app, true); 
        end
    end

    % Component initialization
    methods (Access = private)

        % Create UIFigure and components
        function createComponents(app)

            % Create UIFigure and hide until all components are created
            app.UIFigure = uifigure('Visible', 'off');
            app.UIFigure.AutoResizeChildren = 'off';
            app.UIFigure.Color = [0.9412 0.9412 0.9412];
            app.UIFigure.Position = [100 50 980 780];
            app.UIFigure.Name = 'MATLAB App';
            app.UIFigure.Scrollable = 'on';

            % Create titleLabel
            app.titleLabel = uilabel(app.UIFigure);
            app.titleLabel.HorizontalAlignment = 'center';
            app.titleLabel.FontName = 'Tahoma';
            app.titleLabel.FontSize = 24;
            app.titleLabel.FontWeight = 'bold';
            app.titleLabel.FontColor = [0.051 0.0784 0.2314];
            app.titleLabel.Position = [330 690 629 69];
            app.titleLabel.Text = 'Convolución de señales';

            % Create GraficarButton
            app.GraficarButton = uibutton(app.UIFigure, 'push');
            app.GraficarButton.ButtonPushedFcn = createCallbackFcn(app, @GraficarButtonPushed, true);
            app.GraficarButton.FontSize = 13;
            app.GraficarButton.FontWeight = 'bold';
            app.GraficarButton.Visible = 'off';
            app.GraficarButton.Position = [173 70 108 32];
            app.GraficarButton.Text = 'Graficar';

            % Create TabGroup
            app.TabGroup = uitabgroup(app.UIFigure);
            app.TabGroup.AutoResizeChildren = 'off';
            app.TabGroup.Position = [34 133 248 408];

            % Create ftTab
            app.ftTab = uitab(app.TabGroup);
            app.ftTab.AutoResizeChildren = 'off';
            app.ftTab.Title = 'f(t)';

            % Create TipodeSealDropDownLabel
            app.TipodeSealDropDownLabel = uilabel(app.ftTab);
            app.TipodeSealDropDownLabel.HorizontalAlignment = 'right';
            app.TipodeSealDropDownLabel.FontSize = 13;
            app.TipodeSealDropDownLabel.Position = [14 334 85 22];
            app.TipodeSealDropDownLabel.Text = 'Tipo de Señal';

            % Create TipodeSealDropDown
            app.TipodeSealDropDown = uidropdown(app.ftTab);
            app.TipodeSealDropDown.Items = {' ', 'Seno', 'Cuadrada', 'Triangular', 'Exponencial', 'Rampa 1', 'Rampa 2', 'Rampa 3'};
            app.TipodeSealDropDown.ValueChangedFcn = createCallbackFcn(app, @DropDownValueChanged, true);
            app.TipodeSealDropDown.Enable = 'off';
            app.TipodeSealDropDown.FontSize = 13;
            app.TipodeSealDropDown.Position = [114 334 117 22];
            app.TipodeSealDropDown.Value = ' ';

            % Create Panel_2
            app.Panel_2 = uipanel(app.ftTab);
            app.Panel_2.AutoResizeChildren = 'off';
            app.Panel_2.Visible = 'off';
            app.Panel_2.SizeChangedFcn = createCallbackFcn(app, @DropDownValueChanged, true);
            app.Panel_2.Position = [16 37 215 279];

            % Create ecuacionLabel_xt
            app.ecuacionLabel_xt = uilabel(app.Panel_2);
            app.ecuacionLabel_xt.HorizontalAlignment = 'center';
            app.ecuacionLabel_xt.FontSize = 14;
            app.ecuacionLabel_xt.Position = [12 220 186 48];
            app.ecuacionLabel_xt.Text = 'a';

            % Create campo1_xtLabel
            app.campo1_xtLabel = uilabel(app.Panel_2);
            app.campo1_xtLabel.FontSize = 13;
            app.campo1_xtLabel.Position = [13 179 105 22];
            app.campo1_xtLabel.Text = 'campo1_xt';

            % Create campo1_xt
            app.campo1_xt = uieditfield(app.Panel_2, 'numeric');
            app.campo1_xt.FontSize = 13;
            app.campo1_xt.Position = [123 179 74 22];

            % Create campo2_xtLabel
            app.campo2_xtLabel = uilabel(app.Panel_2);
            app.campo2_xtLabel.FontSize = 13;
            app.campo2_xtLabel.Position = [13 136 105 22];
            app.campo2_xtLabel.Text = 'campo2_xt';

            % Create campo2_xt
            app.campo2_xt = uieditfield(app.Panel_2, 'numeric');
            app.campo2_xt.FontSize = 13;
            app.campo2_xt.Position = [123 136 74 22];

            % Create campo3_xtLabel
            app.campo3_xtLabel = uilabel(app.Panel_2);
            app.campo3_xtLabel.FontSize = 13;
            app.campo3_xtLabel.Position = [13 98 105 22];
            app.campo3_xtLabel.Text = 'campo3_xt';

            % Create campo3_xt
            app.campo3_xt = uieditfield(app.Panel_2, 'numeric');
            app.campo3_xt.FontSize = 13;
            app.campo3_xt.Position = [123 98 74 22];

            % Create campo4_xtLabel
            app.campo4_xtLabel = uilabel(app.Panel_2);
            app.campo4_xtLabel.FontSize = 13;
            app.campo4_xtLabel.Position = [13 55 105 22];
            app.campo4_xtLabel.Text = 'campo4_xt';

            % Create campo4_xt
            app.campo4_xt = uieditfield(app.Panel_2, 'numeric');
            app.campo4_xt.FontSize = 13;
            app.campo4_xt.Position = [123 55 74 22];

            % Create htTab
            app.htTab = uitab(app.TabGroup);
            app.htTab.AutoResizeChildren = 'off';
            app.htTab.Title = 'h(t)';

            % Create Panel_3
            app.Panel_3 = uipanel(app.htTab);
            app.Panel_3.AutoResizeChildren = 'off';
            app.Panel_3.Visible = 'off';
            app.Panel_3.Position = [16 37 215 279];

            % Create ecuacionLabel_ht
            app.ecuacionLabel_ht = uilabel(app.Panel_3);
            app.ecuacionLabel_ht.HorizontalAlignment = 'center';
            app.ecuacionLabel_ht.FontSize = 14;
            app.ecuacionLabel_ht.Position = [12 220 186 48];
            app.ecuacionLabel_ht.Text = 'a';

            % Create campo4_ht
            app.campo4_ht = uieditfield(app.Panel_3, 'numeric');
            app.campo4_ht.FontSize = 13;
            app.campo4_ht.Position = [123 55 74 22];

            % Create campo4_htLabel
            app.campo4_htLabel = uilabel(app.Panel_3);
            app.campo4_htLabel.FontSize = 13;
            app.campo4_htLabel.Position = [13 55 105 22];
            app.campo4_htLabel.Text = 'campo4_ht';

            % Create campo3_ht
            app.campo3_ht = uieditfield(app.Panel_3, 'numeric');
            app.campo3_ht.FontSize = 13;
            app.campo3_ht.Position = [123 98 74 22];

            % Create campo3_htLabel
            app.campo3_htLabel = uilabel(app.Panel_3);
            app.campo3_htLabel.FontSize = 13;
            app.campo3_htLabel.Position = [13 98 105 22];
            app.campo3_htLabel.Text = 'campo3_ht';

            % Create campo2_ht
            app.campo2_ht = uieditfield(app.Panel_3, 'numeric');
            app.campo2_ht.FontSize = 13;
            app.campo2_ht.Position = [123 136 74 22];

            % Create campo2_htLabel
            app.campo2_htLabel = uilabel(app.Panel_3);
            app.campo2_htLabel.FontSize = 13;
            app.campo2_htLabel.Position = [13 136 105 22];
            app.campo2_htLabel.Text = 'campo2_ht';

            % Create campo1_ht
            app.campo1_ht = uieditfield(app.Panel_3, 'numeric');
            app.campo1_ht.FontSize = 13;
            app.campo1_ht.Position = [123 179 74 22];

            % Create campo1_htLabel
            app.campo1_htLabel = uilabel(app.Panel_3);
            app.campo1_htLabel.FontSize = 13;
            app.campo1_htLabel.Position = [13 179 105 22];
            app.campo1_htLabel.Text = 'campo1_ht';

            % Create TipodeSealDropDown_2Label
            app.TipodeSealDropDown_2Label = uilabel(app.htTab);
            app.TipodeSealDropDown_2Label.HorizontalAlignment = 'right';
            app.TipodeSealDropDown_2Label.FontSize = 13;
            app.TipodeSealDropDown_2Label.Position = [14 334 85 22];
            app.TipodeSealDropDown_2Label.Text = 'Tipo de Señal';

            % Create TipodeSealDropDown_2
            app.TipodeSealDropDown_2 = uidropdown(app.htTab);
            app.TipodeSealDropDown_2.Items = {' ', 'Seno', 'Exponencial', 'Cuadrada', 'Triangular', 'Rampa 1', 'Rampa 2', 'Rampa 3'};
            app.TipodeSealDropDown_2.ValueChangedFcn = createCallbackFcn(app, @TipodeSealDropDown_2ValueChanged, true);
            app.TipodeSealDropDown_2.Enable = 'off';
            app.TipodeSealDropDown_2.FontSize = 13;
            app.TipodeSealDropDown_2.Position = [114 334 117 22];
            app.TipodeSealDropDown_2.Value = ' ';

            % Create ConvolucionarButton
            app.ConvolucionarButton = uibutton(app.UIFigure, 'push');
            app.ConvolucionarButton.ButtonPushedFcn = createCallbackFcn(app, @ConvolucionarButtonPushed, true);
            app.ConvolucionarButton.FontSize = 13;
            app.ConvolucionarButton.FontWeight = 'bold';
            app.ConvolucionarButton.Visible = 'off';
            app.ConvolucionarButton.Position = [35 71 105 30];
            app.ConvolucionarButton.Text = 'Convolucionar';

            % Create DominiodelTiempoDropDownLabel
            app.DominiodelTiempoDropDownLabel = uilabel(app.UIFigure);
            app.DominiodelTiempoDropDownLabel.HorizontalAlignment = 'right';
            app.DominiodelTiempoDropDownLabel.FontSize = 13;
            app.DominiodelTiempoDropDownLabel.Position = [35 573 120 22];
            app.DominiodelTiempoDropDownLabel.Text = 'Dominio del Tiempo:';

            % Create DominiodelTiempoDropDown
            app.DominiodelTiempoDropDown = uidropdown(app.UIFigure);
            app.DominiodelTiempoDropDown.Items = {' ', 'Continua', 'Discreta'};
            app.DominiodelTiempoDropDown.ValueChangedFcn = createCallbackFcn(app, @DominiodelTiempoDropDownValueChanged, true);
            app.DominiodelTiempoDropDown.FontSize = 13;
            app.DominiodelTiempoDropDown.Position = [167 573 114 22];
            app.DominiodelTiempoDropDown.Value = ' ';

            % Create axposicion
            app.axposicion = uiaxes(app.UIFigure);
            title(app.axposicion, 'Animación')
            xlabel(app.axposicion, 't')
            ylabel(app.axposicion, 'y(t)')
            app.axposicion.PlotBoxAspectRatio = [3.69035532994924 1 1];
            app.axposicion.FontSize = 13;
            app.axposicion.XGrid = 'on';
            app.axposicion.YGrid = 'on';
            app.axposicion.Position = [330 268 629 208];

            % Create axconvo
            app.axconvo = uiaxes(app.UIFigure);
            title(app.axconvo, 'Convolución')
            xlabel(app.axconvo, 't')
            ylabel(app.axconvo, 'y(t)')
            app.axconvo.PlotBoxAspectRatio = [3.49519230769231 1 1];
            app.axconvo.FontSize = 13;
            app.axconvo.XGrid = 'on';
            app.axconvo.YGrid = 'on';
            app.axconvo.Position = [330 28 629 222];

            % Create Image
            app.Image = uiimage(app.UIFigure);
            app.Image.Position = [35 690 246 69];
            app.Image.ImageSource = 'un_logo.png';

            % Create infoLabel
            app.infoLabel = uilabel(app.UIFigure);
            app.infoLabel.FontSize = 14;
            app.infoLabel.FontWeight = 'bold';
            app.infoLabel.Position = [35 621 247 43];
            app.infoLabel.Text = {'Seleccione el dominio y las '; 'funciones a graficar:'};

            % Create axeht
            app.axeht = uiaxes(app.UIFigure);
            title(app.axeht, '')
            xlabel(app.axeht, 't')
            ylabel(app.axeht, 'y(t)')
            app.axeht.PlotBoxAspectRatio = [1.75280898876405 1 1];
            app.axeht.FontSize = 13;
            app.axeht.XGrid = 'on';
            app.axeht.YGrid = 'on';
            app.axeht.Position = [654 496 305 182];

            % Create axeft
            app.axeft = uiaxes(app.UIFigure);
            title(app.axeft, '')
            xlabel(app.axeft, 't')
            ylabel(app.axeft, 'y(t)')
            app.axeft.PlotBoxAspectRatio = [1.80898876404494 1 1];
            app.axeft.FontSize = 13;
            app.axeft.XGrid = 'on';
            app.axeft.YGrid = 'on';
            app.axeft.Position = [330 496 313 183];

            % Create creditosLabel
            app.creditosLabel = uilabel(app.UIFigure);
            app.creditosLabel.FontSize = 10;
            app.creditosLabel.FontWeight = 'bold';
            app.creditosLabel.Position = [730 7 229 22];
            app.creditosLabel.Text = 'Realizado por David Beltrán y Enrique Niebles.';

            % Create errorLabel
            app.errorLabel = uilabel(app.UIFigure);
            app.errorLabel.FontSize = 13;
            app.errorLabel.FontWeight = 'bold';
            app.errorLabel.FontColor = [1 0 0];
            app.errorLabel.Visible = 'off';
            app.errorLabel.Position = [34 28 248 30];
            app.errorLabel.Text = {'Parámetros no válidos, por favor '; 'digite nuevamente.'};

            % Create infoLabel1
            app.infoLabel1 = uilabel(app.UIFigure);
            app.infoLabel1.FontSize = 13;
            app.infoLabel1.FontWeight = 'bold';
            app.infoLabel1.FontColor = [0 0.4471 0.7412];
            app.infoLabel1.Visible = 'off';
            app.infoLabel1.Position = [31 12 248 46];
            app.infoLabel1.Text = {'Las gráficas en tiempo discreto'; 'son una ampliación que conservan '; 'los datos originales.'};

            % Create infoLabel2
            app.infoLabel2 = uilabel(app.UIFigure);
            app.infoLabel2.FontSize = 13;
            app.infoLabel2.FontWeight = 'bold';
            app.infoLabel2.FontColor = [0 0.4471 0.7412];
            app.infoLabel2.Visible = 'off';
            app.infoLabel2.Position = [35 12 248 46];
            app.infoLabel2.Text = {'La convolución en tiempo continuo'; 'puede tomar un rato dada la exactitud.'; 'Por favor espere.'};

            % Show the figure after all components are created
            app.UIFigure.Visible = 'on';
        end
    end

    % App creation and deletion
    methods (Access = public)

        % Construct app
        function app = main

            % Create UIFigure and components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end