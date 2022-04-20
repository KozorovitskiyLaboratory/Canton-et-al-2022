
current_of_interest_waves_means=movmean(current_of_interest_waves,3);


for j=1:6
    figure
    for i=1:length(steps)
    
    
        
        plot(current_of_interest_waves_means(((2+((i-1)*3))+((j-1)*45)),1:1000))
        hold on
        legend('1','2','3','4','5' ,'6')
    end
end



figure
for i=1:length(steps)
    
    subplot(8,2,i)
figure
    for j=1:6
        
        plot(current_of_interest_waves_means(((2+((i-1)*3))+((j-1)*45)),150:1000))
        hold on
        legend('1','2','3','4','5' ,'6')
    end
end




figure
plot(min(mean_currents))

%%

figure
% colormap bone;
% 
plot(steps,mean_currents(:,1),'-','LineWidth',1.5);
hold on
plot(steps,mean_currents(:,2),'--','LineWidth',1.5);
plot(steps,mean_currents(:,3),'-','LineWidth',1.5);
plot(steps,mean_currents(:,4),'--','LineWidth',1.5);
plot(steps,mean_currents(:,5),'-','LineWidth',1.5);
plot(steps,mean_currents(:,6),'--','LineWidth',1.5);

legend('1','2','3','4','5' ,'6')
grid on


%%

figure
colormap bone;
% 
plot(steps,mean_currents_norm(:,1),'-','LineWidth',1.5);
hold on
plot(steps,mean_currents_norm(:,2),'--','LineWidth',1.5);
plot(steps,mean_currents_norm(:,3),'-','LineWidth',1.5);
plot(steps,mean_currents_norm(:,4),'--','LineWidth',1.5);
plot(steps,mean_currents_norm(:,5),'-','LineWidth',1.5);
plot(steps,mean_currents_norm(:,6),'--','LineWidth',1.5);
% 
% plot(mean_currents(:,1));
% hold on
% plot(mean_currents(:,2));
% plot(mean_currents(:,3));
% plot(mean_currents(:,4));
% plot(mean_currents(:,5));
% plot(mean_currents(:,6));

legend('1','2','3','4','5' ,'6')
grid on

%%
figure


% for i=1:length(mean_currents(1,:))
    for i=2:4

plot(steps,mean_currents(:,i))
hold on
end