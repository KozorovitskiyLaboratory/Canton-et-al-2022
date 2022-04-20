clearvars
close all
% cd('C:\Users\Neto\Desktop\KLab\Recording Data\NJ');
% cd('D:\Users\Earnest\Desktop\KLab\Recording Data\NJ');
% 

% cd('Z:\Neto\Box Sync\KLAB\KLab\Recording Data\NJ');
cd('D:\Phys recordings')


%only good series
% list={ 'nj206e' 'nj207a'  'nj207b'   'nj211a'  'nj212a' 'nj213a' 'nj214a' 'nj214b' 'nj221c'  'nj223b' };
list={ 'nj207a'  'nj207b'   'nj211a'  'nj212a' 'nj213a' 'nj214a' 'nj214b' 'nj221c'  'nj223b' };

% list={  'nj211a' 'nj211a' 'nj212a' 'nj213a' 'nj214a' 'nj214b' 'nj221c'  'nj223b' };

% list={'nj206e' 'nj207a' 'nj207b'  'nj207c'  'nj211a'  'nj212a' 'nj213a' 'nj214a' 'nj214b' 'nj221a' 'nj221b' 'nj221c' 'nj223a' 'nj223b' 'nj238a'};



% list={'nj206e' 'nj207a' 'nj207b'  'nj207c'  'nj211a'  'nj212a' 'nj213a' 'nj214a' 'nj214b' 'nj221a' 'nj221b' 'nj221c' 'nj223a' 'nj223b' 'nj226a' 'nj238a'};



%%

Total_summary=struct;

for i=1:length(list)
    item=strcat(list{i},'_summary.mat');
    Total_summary.(list{i})=load(item);
    
end
   
Total_summary_fieldnames=sort(fieldnames(Total_summary)); 
    
clearvars -except Total_summary Total_summary_fieldnames list


%%


for i=1:length(Total_summary_fieldnames)
    
    
   a(1,i)=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(35:40)); 
   a(2,i)=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(41:50)); 
   a(3,i)=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(51:60));
   a(4,i)=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(61:70));
   a(5,i)=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(61:80));
   
    b(1,i)=mean(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps(35:40)); 
   b(2,i)=mean(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps(41:50)); 
   b(3,i)=mean(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps(51:60));
   b(4,i)=mean(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps(61:70));
   b(5,i)=mean(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps(71:80));
   

   
   
   
   c(1,i)=mean(Total_summary.(Total_summary_fieldnames{i}).charge_first_allwaves(35:40)); 
   c(2,i)=mean(Total_summary.(Total_summary_fieldnames{i}).charge_first_allwaves(41:50)); 
   c(3,i)=mean(Total_summary.(Total_summary_fieldnames{i}).charge_first_allwaves(51:60));
   c(4,i)=mean(Total_summary.(Total_summary_fieldnames{i}).charge_first_allwaves(61:70));
   c(5,i)=mean(Total_summary.(Total_summary_fieldnames{i}).charge_first_allwaves(51:70));
   
    
end
aa=a./a(1,:);

bb=b./b(1,:);

%%



for i=1:length(Total_summary_fieldnames)   

    mean_currents=movmean(Total_summary.(Total_summary_fieldnames{i}).current_of_interest_waves,10);
    mean_currents_sem=movstd(Total_summary.(Total_summary_fieldnames{i}).current_of_interest_waves,10);
    
    
    for j=1:length(Total_summary.(Total_summary_fieldnames{i}).current_of_interest_waves(:,1))
        peak_mean_currents(j)=max(mean_currents(j,:));
    end
    
    
    mean_holding=movmean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps,5); 


    Total_summary.(Total_summary_fieldnames{i}).mean_currents=mean_currents;
    Total_summary.(Total_summary_fieldnames{i}).peak_mean_currents=peak_mean_currents;
    Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem=mean_currents_sem;
    

    
    



end
%%


time_course=(-110:.02:90);

hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

%     mean_t=zeros(length(Total_summary_fieldnames),70);
  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
    
    subplot(3,1,1)
%     plot(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first)
    plot(movmean(Total_summary.(Total_summary_fieldnames{i}).current_decay_all_sweeps,5))
    title(Total_summary_fieldnames{i});
    subplot(3,1,2)
    hold on
    plot(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps)

    title(Total_summary_fieldnames{i});
    subplot(3,1,3)
%     plot(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps)
    plot(Total_summary.(Total_summary_fieldnames{i}).peak_mean_currents)

    title(Total_summary_fieldnames{i});
    hold on
    
     
end
   

%%

hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    
    hax1 = axes('Parent', htab1);
    
    plot(time_course(1:10000),cumtrapz(Total_summary.(Total_summary_fieldnames{i}).mean_currents(40,1:10000)))
    hold on
    plot(time_course(1:10000),cumtrapz(Total_summary.(Total_summary_fieldnames{i}).mean_currents(70,1:10000)))
    plot(time_course(1:10000),cumtrapz(Total_summary.(Total_summary_fieldnames{i}).mean_currents(90,1:10000)))

    zz(1,i)=max(Total_summary.(Total_summary_fieldnames{i}).mean_currents(40,1:10000));
        zz(2,i)=max(Total_summary.(Total_summary_fieldnames{i}).mean_currents(60,1:10000));
    zz(3,i)=max(Total_summary.(Total_summary_fieldnames{i}).mean_currents(90,1:10000));
   
end


%%

time_course=0:(500/10000):500;
hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
   htab1 = uitab(htabgroup, 'Title', num2str(i));
    
    hax1 = axes('Parent', htab1);
    

     hold on
    
      x=time_course(1:10000);
      y=Total_summary.(Total_summary_fieldnames{i}).mean_currents(40,1:10000);
      yu=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(40,1:10000))+(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(40,1:10000));

      yl=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(40,1:10000))-(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(40,1:10000));
    
      fill([x fliplr(x)], [yu fliplr(yl)], [.75 .75  .75 ], 'linestyle', 'none','FaceAlpha',.5)
      
      plot(x,y)
%       
     set(gca,'TickDir','out');
     

      y=Total_summary.(Total_summary_fieldnames{i}).mean_currents(55,1:10000);
      yu=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(55,1:10000))+(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(55,1:10000));

      yl=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(55,1:10000))-(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(55,1:10000));
    
      fill([x fliplr(x)], [yu fliplr(yl)], [.5 .5  .5 ], 'linestyle', 'none','FaceAlpha',.5 )
      
      plot(x,y)
%       


   xlabel('ms')
   ylabel('pA')
   
%    xlim([-110 90])
   legend('Baseline SD','Baseline Mean','SKF SD', 'SKF Mean')
%    ylim([-300 90])

end

%% Plots peak current over time

hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);


time_course=0:(50/100):50;
for i=1:length(Total_summary_fieldnames)

        htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
    
    
    x=time_course(1:100);
    y=movmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(1:100),5);

    
    
    plot(x,y)
   hold on
    line([21 30],[70 70],'Color','red','LineWidth',3)
    
    ylim([0 100])
    xlabel('minutes')
    ylabel('pA')
     set(gca,'TickDir','out');
end





%%

hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

time_course=0:(50/100):50;

for i=1:length(Total_summary_fieldnames)

        htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
    
    
    base=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(36:40));

    

    x=time_course(1:80);
    y=(movmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(1:80),5)./base);
   
    plot(x,y)
    
    hold on
    line([21 30],[1.6 1.6],'Color','red','LineWidth',3)
    ylim([0 2])
    
    ylabel('norm current')
end


%% Makes mean graph of currents across cells with SEM


% figure
time_course=0:(50/100):50;

for i=1:length(Total_summary_fieldnames)
base=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(36:40));

    

    x=time_course(11:100);
    y=(movmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(1:100),5));

%     plot(x,y)
    
    hold on
    line([21 30],[1.6 1.6],'Color','red','LineWidth',3)
%     ylim([0 2])
    
    ylabel('norm current')
    mean_all(i,:)=y;
    
end
% 

% mean_all_norm=mean_all./mean_all(1,35:40);

figure

mean_all_2=mean(mean_all);
std_all_2=std(mean_all);
sem_all_2=std_all_2/sqrt(length(mean_all(:,1)));

x=(1:40);
y=mean_all_2(21:2:end-1);
yu=y+sem_all_2(21:2:end-1); 
yl=y-sem_all_2(21:2:end-1);


%   errorbar(mean_all_2(20:2:end-1),sem_all_2(20:2:end-1),'o')
%    line([10 20],[1.4 1.4],'Color','red','LineWidth',3)
   
   fill([x fliplr(x)], [yu fliplr(yl)], [.75 .75  .75 ], 'linestyle','none')
hold on
   
   scatter(x,y)
   
   axis square
    ylim([30 80])
%         xlim([0 41])

%% Makes norm. mean graph of currents across cells with SEM


time_course=0:(50/100):50;
for i=1:length(Total_summary_fieldnames)
base=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(36:40));
% base=1;
% figure
    

    x=time_course(1:100);
    y=(movmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(1:100),5)./base);
%        y=(movmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(1:100),1)./base);

%     plot(x,y)
    
    hold on
    line([21 30],[1.6 1.6],'Color','red','LineWidth',3)
%     ylim([0 2])
    
    ylabel('norm current')
    mean_all(i,:)=y;
    
end
% 
figure

mean_all_2=mean(mean_all);
std_all_2=std(mean_all);
sem_all_2=std_all_2/sqrt(length(mean_all(:,1)));

x=(1:40);
y=mean_all_2(21:2:end-1)
yu=y+sem_all_2(21:2:end-1);
yl=y-sem_all_2(21:2:end-1);


%   errorbar(mean_all_2(21:2:end-1),sem_all_2(21:2:end-1),'o')
%    line([10 20],[1.4 1.4],'Color','red','LineWidth',3)
   
   fill([x fliplr(x)], [yu fliplr(yl)], [.75 .75  .75 ], 'linestyle','none')
hold on
   
   scatter(x,y)
   
   axis square
    ylim([.75 1.6])
%         xlim([0 41])


    set(gca,'fontsize', 25);
    set(gca,'LineWidth',2,'TickLength',[0.025 0.025]);
    set(gca,'TickDir','out');
    set(gca, 'FontName', 'Arial')
    
    ylabel('norm current')
    xlabel('Time (min)')
    %% Makes norm. mean graph of currents across cells with SEM


time_course=0:(50/100):50;
for i=1:length(Total_summary_fieldnames)
base=mean(Total_summary.(Total_summary_fieldnames{i}).current_rise_all_sweeps(36:40));
% base=1;
% figure
    

    x=time_course(1:100);
    y=(movmean(Total_summary.(Total_summary_fieldnames{i}).current_rise_all_sweeps(1:100),1));
%        y=(movmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(1:100),1)./base);

%     plot(x,y)
    
    hold on
    line([21 30],[1.6 1.6],'Color','red','LineWidth',3)
%     ylim([0 2])
    
    ylabel('norm current')
    mean_all(i,:)=y;
    
end
% 
figure

mean_all_2=nanmean(mean_all);
std_all_2=nanstd(mean_all);
sem_all_2=std_all_2/sqrt(length(mean_all(:,1)));

% x=(1:40);
% y=mean_all_2(21:2:end-1)
% yu=y+sem_all_2(21:2:end-1);
% yl=y-sem_all_2(21:2:end-1);

y=mean_all_2;
yu=y+sem_all_2;
yl=y-sem_all_2;


%   errorbar(mean_all_2(21:2:end-1),sem_all_2(21:2:end-1),'o')
%    line([10 20],[1.4 1.4],'Color','red','LineWidth',3)
   
   fill([x fliplr(x)], [yu fliplr(yl)], [.75 .75  .75 ], 'linestyle','none')
hold on
   
   scatter(x,y)
   
   axis square
%     ylim([.75 1.6])
%         xlim([0 41])


    set(gca,'fontsize', 25);
    set(gca,'LineWidth',2,'TickLength',[0.025 0.025]);
    set(gca,'TickDir','out');
    set(gca, 'FontName', 'Arial')
    
    ylabel('norm current')
    xlabel('Time (min)')