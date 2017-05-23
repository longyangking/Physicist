function lorenzsystem
    tspan = linspace(0,20,2001);
    y0 = [0.1,0.2,0.3,0.4,1,2];
    a = 10; b = 8/3; c = 8.0;
    fun = @(t,y)(RealLorenz(t,y,a,b,c));
    options = odeset('RelTol',1e-4,'AbsTol',[1e-4,1e-4,1e-4,1e-4,1e-4,1e-4]);
    [T,Y] = ode45(fun,tspan,y0,options);
    
    figure(1);

    plot(T,abs(Y(:,1)+Y(:,2)*1j),'-',T,abs(Y(:,3)+Y(:,4)*1j),'-.',T,abs(Y(:,5)+Y(:,6)*1j),'-.o','LineWidth',2.0);
    legend(['|X|'],['|Y|'],['|Z|'],'location','best');
    xlabel('t','FontSize',22);
    set(gca,'FontSize',18);
    %set(gca,'xtick',[0,2,4,6,8,10],'fontsize',18);
    %set(gca,'ytick',[-10,-5,0,2,10],'fontsize',18);

    figure(2);
    scatter(Y(:,1),Y(:,2));
    xlabel('Real X'); ylabel('Imag X');
    set(gca,'FontSize',18);

    figure(3);
    scatter(Y(:,3),Y(:,4));
    xlabel('Real Y'); ylabel('Imag Y');
    set(gca,'FontSize',18);

    figure(4);
    scatter(Y(:,5),Y(:,6));
    xlabel('Real Z'); ylabel('Imag Z');
    set(gca,'FontSize',18);
end

function dydt = RealLorenz(t,y,a,b,c)
    x1 = y(1); x2 = y(2); 
    y1 = y(3); y2 = y(4);
    z1 = y(5); z2 = y(6);

    A1 = a*(y1 - x1);
    A2 = a*(y2 - x2);
    A3 = c*x1 - y1 - (x1*z1 - x2*z2);
    A4 = c*x2 - y2 - (x2*z1 + x1*z2);
    A5 = x1*y1 - x2*y2 - b*z1;
    A6 = x2*y1 + x1*y2 - b*z2;

    dydt = [A1; A2; A3; A4; A5; A6];
end