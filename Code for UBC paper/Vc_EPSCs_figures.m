
%% Graph all the trials

m=5;
n=2;
p=m*n;
graph_no=ceil(length(Allwaves_fieldnames)/p);

hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);


for j=1:graph_no
    
    htab1 = uitab(htabgroup, 'Title', num2str(j));
    hax1 = axes('Parent', htab1);
    for i=1:p
        
        subplot(m,n,i);
        if length(Allwaves_fieldnames)>=(i+(p*(j-1)))
            
            plot(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).data(time_of_interest))
            hold on
            if strcmp(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).clamp,'Current')==1
%                 plot(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_trace,Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).peak_trace,'o')
%                 hold on
%                 plot(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_acceleration,Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).data(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_acceleration),'o')
%                 hold on
%                 plot(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_AHP,Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).data(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_AHP),'o')
            end
            
            title(Allwaves_fieldnames{i+(p*(j-1))});
%             xlim([139000 141000])
            ylim([-100 200])
        end
        hold on
    end
    
end

% clearvars -except   RC_Check membrane_potential_all_sweeps Allwaves Extra Allwaves_fieldnames Extra_fieldnames cluster coefficient_variation_all_sweeps standard_deviation_all_sweeps  mean_firing_rates_all_sweeps mean_firing_rates_all_sweeps_2 Input_resistance_all_sweeps ISI_array_all_sweeps list list2 neuroncount top_directory capacitance_all_sweeps Rcpeak_Rcsteady_all_sweeps Rcpeak_Rcsteady_all_sweeps spike_amp_trace_all_sweeps spike_waveforms_all_sweeps threshold_all_sweeps half_width_all_sweeps AHP_depth_all_sweeps AHP_min_all_sweeps AP_peaks_all_sweeps mouse_gender mouse_age lobule list3 list4 list5;

%%
a=reshape(current_amp_all_sweeps_L(1:5*(floor(length(current_amp_all_sweeps_L)/5))),5,floor(length(current_amp_all_sweeps_L)/5));
T_type=a(:,1:2:end);
L_type=a(:,2:2:end);   

a=reshape(current_amp_all_sweeps_L_sub(1:5*(floor(length(current_amp_all_sweeps_L)/5))),5,floor(length(current_amp_all_sweeps_L)/5));
T_type_sub=a(:,1:2:end);
L_type_sub=a(:,2:2:end);   



%%
% a=reshape(Series_Resistance_all_sweeps(1:5*(floor(length(Series_Resistance_all_sweeps)/5))),5,floor(length(Series_Resistance_all_sweeps)/5));
% Rc_T_type=a(:,1:2:end);
% Rc_L_type=a(:,2:2:end);   

 
%%

Input_Resistance_all_sweeps=movmean(Input_Resistance_all_sweeps,20);
% Series_Resistance_all_sweeps=movmean(Series_Resistance_all_sweeps,20);

current_amp_all_sweeps_norm=current_amp_all_sweeps_L.*Series_Resistance_all_sweeps;

mean_currents_norm=movmean((current_amp_all_sweeps_norm),5);

% mean_currents=movmean((current_amp_all_sweeps_L),5);

mean_currents_L_type=mean((L_type));
mean_currents_T_type=mean((T_type));

mean_currents_L_type_sub=mean((L_type_sub));
mean_currents_T_type_sub=mean((T_type_sub));

mean_charge=movmean((charge_L_allwaves),5);

% mean_currents=mean_currents(3:5:end);

mean_charge=mean_charge(3:5:end);


figure
plot(mean_currents_L_type)
hold on
plot(mean_currents_T_type)

figure
plot(mean_currents_L_type_sub)
hold on
plot(mean_currents_T_type_sub)


figure
plot(current_amp_all_sweeps_L)


figure
plot(Series_Resistance_all_sweeps)

%%
current_of_interest_waves_means=movmean(current_of_interest_waves,5);


% 
% figure
% % for j=1:4:floor(length(current_of_interest_waves_means(:,1))/10)
%     for j=1:4:20
% 
%     
%      plot(current_of_interest_waves_means((3+((j-1)*10)),1:end),'LineWidth',2)
%      hold on
%         legend('1','2','3','4','5' ,'6')
% end
% 
% 
% figure
% for j=1:4:(floor(length(current_of_interest_waves_means(:,1))/10))
%     
%      plot(current_of_interest_waves_means((6+((j-1)*10)),1:1000),'LineWidth',2)
%         hold on
% %         legend('1','2','3','4','5' ,'6')
% end
% 
% 