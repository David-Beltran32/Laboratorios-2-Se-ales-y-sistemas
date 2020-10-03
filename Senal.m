classdef Senal
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        seno
        cua
        tri
        pul
        exp
        ramp1
        ramp2 
        ramp3
    end
    
    methods
        function obj = Senal()
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            
            
            
        end
        
        function obj = Seno(obj,F,A)
            t=0:2/(100*F):2/F;
            obj.seno=[[-2/(100*F),t,(2/F)+(2/(100*F))] ; [0,A*sin(2*pi*F*t),0]];
        end
        function obj = Cuadra(obj,F,A)
            t=0:2/(100*F):2/F;
            obj.cua=[[-2/(100*F),t,(2/F)+(2/(100*F))] ; [0,A*square(2*pi*F*t),0]];
        end
        function obj = Trian(obj,F,A)
            t=0:2/(100*F):2/F;
            obj.tri=[[-2/(100*F),t,(2/F)+(2/(100*F))] ; [0,A*sawtooth((2*pi*F*t)+(pi/2),0.5),0]];
        end
        
        function obj= Expo(obj,a,b,ta,tb)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here  
            
            t=ta:(tb-ta)/100:tb;
            y=a*exp(-b*t);
            obj.exp=[t;y];
        end
        
        function obj=Rampa1(obj,ta,tb)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here
            tq=tb-ta;
            t= ta:(tb-ta)/100:tb;
            t1= ta:(tb-ta)/100:ta+0.3*tq;
            t2= ta+0.3*tq+(tb-ta)/100:(tb-ta)/100:ta+0.7*tq;
            t3= ta+0.7*tq+(tb-ta)/100:(tb-ta)/100:tb;
            y1= zeros(1,length(t1));
            y2= 0.825*t2-0.825*(ta+0.3*tq+(tb-ta)/100);
            y3= y2(length(y2))*ones(1,length(t3)); 
            y=[y1,y2,y3];
            obj.ramp1=[[ta-(tb-ta)/100,t,tb+(tb-ta)/100];[0,y,0]];
        end
        
        function obj= Rampa2(obj,ta,tb)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here 
            tq=tb-ta;
            t= ta:(tb-ta)/100:tb;
            t1= ta:(tb-ta)/100:ta+0.3*tq;
            t2= ta+0.3*tq+(tb-ta)/100:(tb-ta)/100:ta+0.7*tq;
            t3= ta+0.7*tq+(tb-ta)/100:(tb-ta)/100:tb;
            
            y2= -0.825*t2+0.825*(ta+0.7*tq+(tb-ta)/100);
            y1= y2(1)*ones(1,length(t1));
            y3= zeros(1,length(t3)); 
            y=[y1,y2,y3];
            obj.ramp2=[[ta-(tb-ta)/100,t,tb+(tb-ta)/100];[0,y,0]];
        end
        
        function obj= Rampa3(obj,ta,tb)
            %UNTITLED Construct an instance of this class
            %   Detailed explanation goes here 
            tq=tb-ta;
            t= ta:(tb-ta)/100:tb;
            t1= ta:(tb-ta)/100:ta+0.3*tq;
            t2= ta+0.3*tq+(tb-ta)/100:(tb-ta)/100:ta+0.7*tq;
            t3= ta+0.7*tq+(tb-ta)/100:(tb-ta)/100:tb;
            y1= 1.1*t1-1.1*ta;
            y2= y1(length(y1))*ones(1,length(t2));
            y3= -1.1*t3+1.1*tb;
            y=[y1,y2,y3];
            obj.ramp3=[[ta-(tb-ta)/100,t,tb+(tb-ta)/100];[0,y,0]];
            
        end
        
    end
end

