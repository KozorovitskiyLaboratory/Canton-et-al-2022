clearvars
% close all
% cd('C:\Users\Neto\Desktop\KLab\2-p Imaging Data');
cd('Z:\Neto\Box Sync\KLAB\KLab\2-p Imaging Data\NJ_im');
% 



% list={'JI049a' 'JI049b' 'JI049c' 'JI050a' 'JI050b' 'JI050c' 'JI051a' 'JI051b'...
%     'JI052a' 'JI052b' 'JI053a' 'JI054a' 'JI055a' 'JI055b' 'JI056a'...
%     'JI056b' 'JI057a' 'JI057b' 'JI058a' 'JI058b' 'JI058c' 'JI058d' ...
%     'JI59a' 'JI060a' 'JI061a' 'JI061b' 'JI061c'};


%Ctrl cells
% 
list={'JI049a' 'JI049b' 'JI049c' 'JI050a'  'JI050b' 'JI051a' ...
    'JI052a'  'JI055b' 'JI056a'...
    'JI056b' 'JI057a'  'JI058a'  ...
    'JI059a' 'JI060a' 'JI061a' };
% % 
% 
% %SKF81297 cells
% % 
% list={ 'JI050c' 'JI051b'...
%     'JI052b' 'JI054a' 'JI055b' 'JI056a'...
%     'JI056b' 'JI057b'  'JI058b' 'JI058c' 'JI058d' ...
%     'JI061b' 'JI061c'};


%%

Total_summary=struct;

for i=1:length(list)
    item=strcat(list{i},'_summary.mat');
    Total_summary.(list{i})=load(item);
    
end
   
Total_summary_fieldnames=sort(fieldnames(Total_summary)); 
    
clearvars -except Total_summary Total_summary_fieldnames list


%%

all_current_amps=[];
all_charges=[];
 Series_Resistance_all_sweeps=[];
  Input_Resistance_all_sweeps=[];
  Rc_peak_all_sweeps=[];


for i=1:length(Total_summary_fieldnames)
   
    Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps>75)=NaN;
    
    currents_by_cells{i}=reshape(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps,[length(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps)*3,1]);
    
    currents_by_cells{i}(isnan(currents_by_cells{i}))=[];

    
    temp=Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps;
    all_current_amps=vertcat(all_current_amps,temp);
    
    
    
    temp1=Total_summary.(Total_summary_fieldnames{i}).charge_all_sweeps;
    all_charges=vertcat(all_charges,temp1);
    
    
    temp2=Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps;
    Series_Resistance_all_sweeps=vertcat(Series_Resistance_all_sweeps,temp2');
    
    
    temp3=Total_summary.(Total_summary_fieldnames{i}).Input_Resistance_all_sweeps;
    Input_Resistance_all_sweeps=vertcat(Input_Resistance_all_sweeps,temp3');
    
    temp4=Total_summary.(Total_summary_fieldnames{i}).Rc_peak_all_sweeps;
    Rc_peak_all_sweeps=vertcat(Rc_peak_all_sweeps,temp4');
    
     
end

all_current_amps=reshape(all_current_amps,[length(all_current_amps)*3,1]);


%%
for i=1:length(Total_summary_fieldnames)
    mean_currents_by_group(i,:)=nanmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps);
    mean_currents_by_cell(i)=nanmean(currents_by_cells{i});
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
    plot(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps)
    title(Total_summary_fieldnames{i});
    
    subplot(3,1,2)
    hold on
    plot(Total_summary.(Total_summary_fieldnames{i}).charge_all_sweeps)

    title(Total_summary_fieldnames{i});
    subplot(3,1,3)
    plot(Total_summary.(Total_summary_fieldnames{i}).Input_Resistance_all_sweeps)
    title(Total_summary_fieldnames{i});
    hold on
    
    
    
    
end
    




%%


hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
%     
%   errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(3,1:10000)))
hold on
  errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(4,1:10000)))
    
%     
%     errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(5,1:10000)))
%   errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(6,1:10000)))
%      errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(7,1:10000)))
% 
%     
    
    
    errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(8,1:10000)))
    errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(9,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(9,1:10000)))

   
end


%%


hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
%     


%   errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(3,1:10000)))
hold on
  errorbar((Total_summary.(Total_summary_fieldnames{i}).mean_currents(5,:)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(5,:)))
    
%     
%     errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(5,1:10000)))
%   errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(6,1:10000)))
%      errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(7,1:10000)))
% 
%     
    
    
    errorbar((Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,:)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(8,:)))
%     errorbar((Total_summary.(Total_summary_fieldnames{i}).mean_currents(9,:)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(9,:)))

   xlim([000 20000])
end



%%


hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    
    hax1 = axes('Parent', htab1);
    
    plot(time_course(1:10000),cumtrapz(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)))
    hold on
    plot(time_course(1:10000),cumtrapz(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)))
    plot(time_course(1:10000),cumtrapz(Total_summary.(Total_summary_fieldnames{i}).mean_currents(9,1:10000)))

    
   
end



%%


hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
% ar=[-80,-110,40,-80,-100];

for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    
    hax1 = axes('Parent', htab1);
    
    plot(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,31:120))
    hold on
%     plot(Total_summary.(Total_summary_fieldnames{i}).baseline_all_sweeps)
%     plot(Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps(1:120))
%     ylim([0 30])
   
end





%%


time_course=0:(500/10000):500;
% hfig1 = figure('WindowStyle','normal');
% htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
%    htab1 = uitab(htabgroup, 'Title', num2str(i));
%     
%     hax1 = axes('Parent', htab1);
    
    figure
 iti=floor(length(Total_summary.(Total_summary_fieldnames{i}).mean_currents(:,1)));
      for j=8:4:iti
     
        hold on
    
      x=time_course(1:10000);
      y=Total_summary.(Total_summary_fieldnames{i}).mean_currents(j,1:10000);
      yu=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(j,1:10000))+(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(j,1:10000));

      yl=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(j,1:10000))-(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(j,1:10000));
    
      fill([x fliplr(x)], [yu fliplr(yl)], [.75-(j*.01) .75-(j*.01)  .75-(j*.01) ], 'linestyle', 'none')
      
      plot(x,y)
%       
     set(gca,'TickDir','out');
%       
%        x=time_course(1:10000);
%       y=Total_summary.(Total_summary_fieldnames{i}).mean_currents(10,1:10000);
%       yu=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(10,1:10000))+(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(10,1:10000));
% 
%       yl=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(10,1:10000))-(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(10,1:10000));
%     
%       fill([x fliplr(x)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')
%       
%       plot(x,y)
% % %       
      


   xlabel('ms')
   ylabel('pA')
   
%    xlim([-110 90])
   legend('Baseline SD','Baseline Mean','SKF SD', 'SKF Mean')
%    ylim([-300 90])

   end
end

%%
time_course=0:(50/100):50;
for i=1:length(Total_summary_fieldnames)

figure
    


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


time_course=0:(50/100):50;

for i=1:length(Total_summary_fieldnames)
base=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(36:40));
figure
    

    x=time_course(1:80);
    y=(movmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(1:80),5)./base);
   
    plot(x,y)
    
    hold on
    line([21 30],[1.6 1.6],'Color','red','LineWidth',3)
    ylim([0 2])
    
    ylabel('norm current')
end
%%


% figure
time_course=0:(50/100):50;
for i=1:length(Total_summary_fieldnames)
base=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(31:40));
% base=1;
% figure
    

    x=time_course(1:100);
    y=(movmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(1:100),10));
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
y=mean_all_2(20:2:end-1)
yu=y+sem_all_2(20:2:end-1);
yl=y-sem_all_2(20:2:end-1);


%   errorbar(mean_all_2(20:2:end-1),sem_all_2(20:2:end-1),'o')
%    line([10 20],[1.4 1.4],'Color','red','LineWidth',3)
   
   fill([x fliplr(x)], [yu fliplr(yl)], [.75 .75  .75 ], 'linestyle','none')
hold on
   
   scatter(x,y)
   
   axis square
%     ylim([.75 1.5])
%         xlim([0 41])

%%

% figure
time_course=0:(50/100):50;
for i=1:length(Total_summary_fieldnames)
base=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(31:40));
% base=1;
% figure
    

    x=time_course(1:100);
    y=(movmean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_first(1:100),10)./base);
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
y=mean_all_2(20:2:end-1)
yu=y+sem_all_2(20:2:end-1);
yl=y-sem_all_2(20:2:end-1);


%   errorbar(mean_all_2(20:2:end-1),sem_all_2(20:2:end-1),'o')
%    line([10 20],[1.4 1.4],'Color','red','LineWidth',3)
   
   fill([x fliplr(x)], [yu fliplr(yl)], [.75 .75  .75 ], 'linestyle','none')
hold on
   
   scatter(x,y)
   
   axis square
    ylim([.75 1.6])
%         xlim([0 41])