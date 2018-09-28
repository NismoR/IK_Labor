function y=fctrl(x)
    outmfs=[-1.01 -1 -0.8;
          -0.5 0 0.5;
           0.8 1 1.01];
           
    in1mfs=[0.3 -1;
              0.3 0;
              0.3 1];
          
    in2mfs=[0.03 -0.1;
             0.03 0;
             0.03 0.1];
    
    rules=[2 2 2;
           1 1 2;
           1 3 1;
           3 3 2;
           3 1 3;
           2 1 3;
           1 2 1;
           3 2 3;
           2 3 1];
    function out=triangle(x,b,k,j)
        if (x<=b || x>=j)
            out=0;
        elseif x>b && x<=k
            out=(x-b)/(k-b);
        else
            out=(j-x)/(j-k);
        end
    end

    function [ob,obk,ojk,oj]=cuttriangle(y,b,k,j)
       ob=b;
       oj=j;
       obk=y*(k-b)+b;
       ojk=j-y*(j-k);
    end

    function out=trapeze(x,b,bk,jk,j,plato)
       if (x<=b || x>=j)
            out=0;
        elseif x>b && x<bk
            out=(x-b)/(bk-b)*plato;
       elseif x>jk && x<j
            out=(j-x)/(j-jk)*plato;
       else
           out = plato;
        end
    end

    function out=gaussf(x,szor,varh)
        out=exp(-0.5*((x-varh)/szor)^2);
    end

    Yfuzz=zeros(1,201);

    for i = 1:size(rules,1)
        rule = rules(i,:);
        in1mf = in1mfs(rule(1),:);
        in2mf = in2mfs(rule(2),:);
        outmf = outmfs(rule(3),:);
        tau1 = gaussf(x(1),in1mf(1),in1mf(2));
        tau2 = gaussf(x(2),in2mf(1),in2mf(2));
        tau = min(tau1,tau2);
        [tb,tbk,tjk,tj]=cuttriangle(tau,outmf(1),outmf(2),outmf(3));
        left_boundary = int16(tb*100) + 101;
        left_boundary = max(left_boundary, 1);
        right_boundary = int16(tj*100) + 101;
        right_boundary = min(right_boundary, 201);
        
        %Trapez masolas
        for t=left_boundary:right_boundary
            point=single(t-101)/100;
            trap_point = trapeze(point,tb,tbk,tjk,tj,tau);
            Yfuzz(t) = max(Yfuzz(t),trap_point);
        end 
    end
    
    y_array = linspace(-1, 1, 201);
    YMu = y_array.*Yfuzz;
    
    sumYMu = sum(YMu);
    sumMu = sum(Yfuzz);
    
    y = sumYMu/sumMu;
    
    hold on 
    plot(y_array, Yfuzz)
    line([y y],[-1 1],'Color',[1 0 0])
    hold off
    
end

