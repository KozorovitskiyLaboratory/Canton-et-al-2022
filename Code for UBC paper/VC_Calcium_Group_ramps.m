clearvars
close all
cd('C:\Users\Neto\Desktop\KLab\Recording Data\NJ');
% cd('D:\Users\Earnest\Desktop\KLab\Recording Data\NJ');
% 


% list={'nj194c' 'nj199a' 'nj200a' 'nj200b' 'nj200c'  'nj200d' 'nj201a' 'nj201b' 'nj201c' 'nj201d' };
% list={'nj200a'  'nj200d' 'nj201a' 'nj201b' 'nj201c' 'nj201d' 'nj203a' 'nj203b' 'nj203c' 'nj203d' 'nj203e' };
list={ 'nj200a' 'nj200b'  'nj200c' 'nj200d' 'nj201a' 'nj201b' 'nj201c' 'nj201d' 'nj203a' 'nj203b' 'nj203c' 'nj203d' 'nj203e' };

% 'nj198b' 'nj198a' 'nj197a' 'nj197b'
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
   
   for j=1:9
        mean_currents(j,:)=mean(Total_summary.(Total_summary_fieldnames{i}).current_of_interest_waves((1+(j-1)*10:10*j),:));

        mean_currents_sem(j,:)=std(Total_summary.(Total_summary_fieldnames{i}).current_of_interest_waves((1+(j-1)*10:10*j),:));

        
        mean_holding(j,:)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(:,(1+(j-1)*10:10*j))'); 
   
   end
    Total_summary.(Total_summary_fieldnames{i}).mean_currents=mean_currents;
    Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem=mean_currents_sem;
    
    
%    Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps= mean(Total_summary.nj203e.holding_current_all_sweeps(:,31:40)');

    
    
    Total_summary.(Total_summary_fieldnames{i}).mean_holding=mean_holding;
    Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps=abs(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(4,:)-Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,:));

    
    
    %     Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps=abs(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,:));

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
    plot(Total_summary.(Total_summary_fieldnames{i}).charge_L_allwaves)
    title(Total_summary_fieldnames{i});
    subplot(3,1,2)
    hold on
%     plot(Total_summary.(Total_summary_fieldnames{i}).mean_currents_L_type)

    title(Total_summary_fieldnames{i});
    subplot(3,1,3)
    plot(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps)
    title(Total_summary_fieldnames{i});
    hold on
    
    
    
    
end
    





%%


summary_of_summary={};


hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
    
    subplot(3,1,1)
    plot(Total_summary.(Total_summary_fieldnames{i}).charge_L_allwaves)
    title(Total_summary_fieldnames{i});
    
    
    subplot(3,1,2)
    
    plot(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)))
    hold on
    plot(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)))
    plot(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(9,1:10000)))

    title(Total_summary_fieldnames{i});
    subplot(3,1,3)
    plot(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps)
    title(Total_summary_fieldnames{i});
    hold on
    
%
end


    clear AHP_mean half_width_mean threshold_mean spike_amp_mean waveform_mean

%%


%%


% steps=[-80,-110,-40,-80,-100];
steps=[-80,-110,-40];

hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
    
   
    plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_holding(8,1:3)-Total_summary.(Total_summary_fieldnames{i}).mean_holding(4,1:3))
    hold on
    plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_holding(8,1:3)-Total_summary.(Total_summary_fieldnames{i}).mean_holding(5,1:3))
    plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_holding(8,1:3)-Total_summary.(Total_summary_fieldnames{i}).mean_holding(6,1:3))
    title(Total_summary_fieldnames{i}); 
    
    
    
    
%
end
%%


for i=1:length(Total_summary_fieldnames)
   
  for j=1:9
         
%       
%       a(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).charge_L_allwaves(1+(j-1)*10:10*j));
%       a1(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_L(1+(j-1)*10:10*j));
%       a2(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_T(1+(j-1)*10:10*j));

      
      b(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(1,1+(j-1)*10:10*j));
      b2(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(2,1+(j-1)*10:10*j));

      b3(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,1+(j-1)*10:10*j));
      b4(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(4,1+(j-1)*10:10*j));
              b5(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(5,1+(j-1)*10:10*j));

%      R_in(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(1,1+(j-1)*10:10*j));
        
                  Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps=abs(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(4,:)-Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,:));

              b6(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps(1+(j-1)*10:5+(j-1)*10));

              
  end
  

end

% bb=b3-b4;
bb=b3;


b1=(bb(:,9)-bb(:,4));
% b1=(mean(bb((5:9),:))-bb(:,4));

% 
% scatter(ones(length(a),1),a(:,1))
% hold on
% scatter(2*ones(length(a),1),a(:,2))
% scatter(3*ones(length(a),1),a(:,3))
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
  errorbar((Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,:)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(4,:)))
    
%     
%     errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(5,1:10000)))
%   errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(6,1:10000)))
%      errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(7,1:10000)))
% 
%     
    
    
    errorbar((Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,:)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(8,:)))
    errorbar((Total_summary.(Total_summary_fieldnames{i}).mean_currents(9,:)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(9,:)))

   xlim([18000 20000])
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

  
ar=[-80,-110,40,-80,-100];

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
%%



hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
   htab1 = uitab(htabgroup, 'Title', num2str(i));
    
    hax1 = axes('Parent', htab1);
    
    

%     
%   errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(3,1:10000)))
hold on
%   errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(4,1:10000)))
    
%     
%     errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(5,1:10000)))
%   errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(6,1:10000)))
%      errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(7,1:10000)))
% 
%     
    
%       plot(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)))
%       plot(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)))
%       plot(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000)))

      x=time_course(1:10000);
      y=Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000);
      yu=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000))+(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(4,1:10000));

      yl=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(4,1:10000))-(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(4,1:10000));
    
      fill([x fliplr(x)], [yu fliplr(yl)], [.5 .5 .5], 'linestyle', 'none')
      
      plot(x,y)
%       
     
      
       x=time_course(1:10000);
      y=Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000);
      yu=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000))+(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(8,1:10000));

      yl=(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000))-(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(8,1:10000));
    
      fill([x fliplr(x)], [yu fliplr(yl)], [.9 .9 .9], 'linestyle', 'none')
      
      plot(x,y)
% %       
      
      
      %       plot(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)))
%             plot(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(9,1:10000)))


%     errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(8,1:10000)))
%     errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(9,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(9,1:10000)))

   xlabel('mV')
   ylabel('pA')
   
   xlim([-110 90])
   legend('Baseline SD','Baseline Mean','SKF puff SD', 'SKF puff Mean')
%    ylim([-300 90])
end

