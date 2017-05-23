function lorenzsystem
    tspan = linspace(0,20,2001);
    y0 = [0.1,0.3,1];
    a = 10; b = 8/3; c = 8.0;
    fun = @(t,y)(RealLorenz(t,y,a,b,c));
    options = odeset('RelTol',1e-4,'AbsTol',[1e-4,1e-4,1e-4]);
    [T,Y] = ode45(fun,tspan,y0,options);
    
    figure(1);

    plot(T,Y(:,1),'-',T,Y(:,2),'-.',T,Y(:,3),'-.o','LineWidth',2.0);
    legend(['X'],['Y'],['Z'],'location','best');
    xlabel('t','FontSize',22);
    set(gca,'FontSize',18);
    %set(gca,'xtick',[0,2,4,6,8,10],'fontsize',18);
    %set(gca,'ytick',[-10,-5,0,2,10],'fontsize',18);

    figure(2);
    scatter(Y(:,1),Y(:,2));
    xlabel('X'); ylabel('Y');
    set(gca,'FontSize',18);

    figure(3);
    scatter(Y(:,1),Y(:,3));
    xlabel('X'); ylabel('Z');
    set(gca,'FontSize',18);

    figure(4);
    scatter(Y(:,2),Y(:,3));
    xlabel('Y'); ylabel('Z');
    set(gca,'FontSize',18);
end

function dydt = RealLorenz(t,y,a,b,c)
    %x1 = y(1); x2 = y(2); 
    %y1 = y(3); y2 = y(4);
    %z1 = y(5); z2 = y(6);
    A1 = a*(y(2) - y(1));
    A2 = c*y(1) - y(2) - y(1)*y(3);
    A3 = y(1)*y(2) - b*y(3);
    dydt = [A1; A2; A3];
end