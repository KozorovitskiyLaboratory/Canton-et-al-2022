clearvars
close all
cd('C:\Users\Neto\Desktop\KLab\Recording Data\NJ');
% cd('D:\Users\Earnest\Desktop\KLab\Recording Data\NJ');
% 

list={'nj124a' 'nj124b' 'nj125a' 'nj125b' 'nj126a' 'nj127a' 'nj127b' 'nj127c' };

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
   
    number1=floor(length(Total_summary.(Total_summary_fieldnames{i}).current_of_interest_waves(:,1))/3);

    number2=floor(number1/15);

    
   for j=1:number1


        mean_currents(j,:)=mean(Total_summary.(Total_summary_fieldnames{i}).current_of_interest_waves((1+(j-1)*3:3*j),:));

        mean_currents_sem(j,:)=std(Total_summary.(Total_summary_fieldnames{i}).current_of_interest_waves((1+(j-1)*3:3*j),:));

         
        
        mean_peak(j,:)=mean(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_L(1,(1+(j-1)*3:3*j)));
%         mean_peak(j,:)=mean(Total_summary.(Total_summary_fieldnames{i}).charge_L_allwaves(1,(1+(j-1)*3:3*j)));

        mean_peak_sem(j,:)=std(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_L(1,(1+(j-1)*3:3*j)));
        
        
      
   end
     mean_peak_1=reshape(mean_peak(1:number2*15),[15,number2]);
        
        
        mean_peak_sem_1=reshape(mean_peak_sem(1:number2*15),[15,number2]);
   
    Total_summary.(Total_summary_fieldnames{i}).mean_currents=mean_currents;
    Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem=mean_currents_sem;
    
    
    Total_summary.(Total_summary_fieldnames{i}).mean_peak=mean_peak_1;
    Total_summary.(Total_summary_fieldnames{i}).mean_peak_sem=mean_peak_sem_1;
    
%     Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps=abs(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(4,:)-Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,:));
%     Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps=abs(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,:));

end

%%


steps=(-100:10:40);


hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
    
    subplot(3,1,1)
    plot(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_L)
    title(Total_summary_fieldnames{i});
    
    
    subplot(3,1,2)
    
    plot((Total_summary.(Total_summary_fieldnames{i}).mean_currents(7+30,1:10000)))
    hold on
    plot((Total_summary.(Total_summary_fieldnames{i}).mean_currents(7+45,1:10000)))
    plot((Total_summary.(Total_summary_fieldnames{i}).mean_currents(7+60,1:10000)))

    title(Total_summary_fieldnames{i});
    subplot(3,1,3)
    plot(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps)
    title(Total_summary_fieldnames{i});
    hold on
    
%
end


    clear AHP_mean half_width_mean threshold_mean spike_amp_mean waveform_mean

%%

for i=1:length(Total_summary_fieldnames)
   
  for j=1:12
         
      
    
      
      b(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(1,1+(j-1)*10:10*j));
      b2(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(2,1+(j-1)*10:10*j));

      b3(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,1+(j-1)*10:10*j));
      b4(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(4,1+(j-1)*10:10*j));
              b5(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(5,1+(j-1)*10:10*j));

%      R_in(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(1,1+(j-1)*10:10*j));
        
                  Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps=abs(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(2,:)-Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,:));

              b6(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps(1+(j-1)*10:5+(j-1)*10));

              
  end
  

end

bb=b3-b4;
bb=b6;


b1=(bb(:,9)-bb(:,4));

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
    
  errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(8,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(8,1:10000)))
    errorbar(time_course(1:10000),(Total_summary.(Total_summary_fieldnames{i}).mean_currents(9,1:10000)),(Total_summary.(Total_summary_fieldnames{i}).mean_currents_sem(9,1:10000)))

   
end




%%

steps=(-100:10:40);
hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);


for i=1:length(Total_summary_fieldnames)
    
    
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    
    hax1 = axes('Parent', htab1);
 
% %     plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,1),'-','LineWidth',1.5);
%     hold on
%     plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,2),'--','LineWidth',1.5);
%     plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,3),'-','LineWidth',1.5);
% %     plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,4),'--','LineWidth',1.5);
%     plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,5),'-','LineWidth',1.5);
%     % plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,6),'--','LineWidth',1.5);

%         plot(steps,Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,2)-Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,3),'--','LineWidth',1.5);
  errorbar(steps,(Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,2)),(Total_summary.(Total_summary_fieldnames{i}).mean_peak_sem(:,2)))
  hold on
errorbar(steps,(Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,3)),(Total_summary.(Total_summary_fieldnames{i}).mean_peak_sem(:,3)))
errorbar(steps,(Total_summary.(Total_summary_fieldnames{i}).mean_peak(:,5)),(Total_summary.(Total_summary_fieldnames{i}).mean_peak_sem(:,4)))
    
    legend('1','2','3','4','5' ,'6')
    grid on
    
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