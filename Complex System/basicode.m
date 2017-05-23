function basicode
    tspan = linspace(0,10,101);
    y0 = [pi-0.1,0];
    b = 0.25; c = 5.0;
    fun = @(t,y)(pend(t,y,b,c));
    options = odeset('RelTol',1e-4,'AbsTol',[1e-4,1e-4]);
    [T,Y] = ode45(fun,tspan,y0,options);
    
    figure(1);
    plot(T,Y(:,1),'-',T,Y(:,2),'-.','LineWidth',2.0);
    legend(['Theta(t)'],['Omega(t)'],'location','best');
    xlabel('t','FontSize',18);
    set(gca,'xtick',[0,2,4,6,8,10],'fontsize',18);
    %set(gca,'ytick',[-10,-5,0,2,10],'fontsize',18);
end

function dydt=pend(t,y,b,c)
    theta = y(1); omega = y(2);
    dydt = [omega; -b*omega - c*sin(theta)];
end