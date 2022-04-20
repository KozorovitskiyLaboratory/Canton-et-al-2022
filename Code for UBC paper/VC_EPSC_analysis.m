


% % 
RC_Check_VC=270000:290000;
time_of_interest=10000:130000;
time_of_interest=19000:40000;


% RC_Check_VC=120000:140000;
% time_of_interest=9500:65000;

%%


        
        trace=Allwaves.(Allwaves_fieldnames{trial_number}).data;
%         trace=interp(trace,2);
        trace=trace*-1;


        Rc=trace(RC_Check_VC);
        Rc1=medfilt1(Rc,100);
        Rc_base=mean(Rc1(9000:9500));
        Rc=Rc-Rc_base;
        Rc1=Rc1-Rc_base;
        
%         Rc_steady=(Rc_base-min(Rc(1:6000)));
        
%         Rc_peak=max(Rc(10000:10500))-min(Rc(10000:10500));

        Rc_peak=-1*min(Rc(10000:10500));

%         Rc_steady=abs(Rc_base-min(Rc(10000:10500)));
     

        Rc_steady=abs(mean(Rc1(14500:14900)));
         
        
%         a=find(Rc(10000:10500)==min(Rc(10000:10500)));
%         tau=find(Rc((10000+a):end)>(-1*.37*(Rc_steady))-Rc_base);
%         tau=find(Rc((10000+a):end)>(-1*.37*(Rc_steady))-Rc_base);
% 
%         
%         tau=tau(1);
%         tau=tau(1)/20000;

       

        holding_current=mean(trace(1:10000));
        holding_current_all_sweeps(trial_number)=holding_current;

        Rs_VC=(20*10^-3)/(Rc_peak*10^-12);
        
%         Cm=tau/Rs_VC;
%         
        Rs_Rm_VC=(20*10^-3)/(Rc_steady*10^-12);
        
        Rm_VC=Rs_Rm_VC-Rs_VC;
        
        Allwaves.(Allwaves_fieldnames{trial_number}).Series_Resistance=Rs_VC;
        Allwaves.(Allwaves_fieldnames{trial_number}).Input_Resistance=Rm_VC;


        Series_Resistance_all_sweeps(trial_number)=Rs_VC;
        Input_Resistance_all_sweeps(trial_number)=Rm_VC;
       
%         capacitance_all_sweeps(trial_number)=Cm;
%         tau_all_sweeps(trial_number)=tau;
        Rc_steady_all_sweeps(trial_number)=Rc_steady;
%         
%         
        Rc2=Rc(10000:15000)-mean(Rc(14000:15000));
        Rc2=(-1*Rc2);
%         Rc2=7*Rc2;
        Rc2=7*(Rc2/2);
%         Rc2=medfilt1(Rc2,100);
        
        
        
        current_of_interest=trace(time_of_interest);
        
        
        
        baseline=mean(trace(1:1000));
        current_of_interest=current_of_interest-baseline;
        current_of_interest=medfilt1(current_of_interest,1);

%         [pk,lk]=findpeaks(current_of_interest(1:1000),'MinPeakHeight',100);
        
%         time=(0:.00005:1);
%         Rc_curve=pk(1)*(exp(-t/tau));
        
        current_of_interest_sub=current_of_interest;
%         current_of_interest_sub=medfilt1(current_of_interest_sub,100);
        current_of_interest_sub(1:length(Rc2))=current_of_interest(1:length(Rc2))-Rc2;
%         current_of_interest_sub=medfilt1(current_of_interest_sub,100);
        current_of_interest_waves_sub(trial_number,:)=current_of_interest_sub;
        
%         current_of_interest=medfilt1(current_of_interest,100);
        
        current_of_interest_waves(trial_number,:)=medfilt1(current_of_interest,10);
        
        
        current_of_interest_waves_means=movmean(current_of_interest_waves,5);


        
        %%
        

       
        
        [current_amp_first,lk_trace,width_trace, spike_amp_trace]=findpeaks(current_of_interest(30:2030),'MinPeakHeight',20,'MinPeakDistance',1000,'MinPeakWidth', 5);
        [LASTMSG, LASTID] = lastwarn;
        warning('off',LASTID)
        
        
                
        
        charge_first_allwaves(trial_number)=trapz(1/sampling_rate,current_of_interest(30:2030));
%         charge_first_allwaves(trial_number)=charge_first_allwaves(trial_number)/((width_trace(1)*2)/sampling_rate);  %converts to units /s
        
%         width_trace=width_trace/(sampling_rate/1000); % converts to ms
        %         current_amp_first=max((current_of_interest(1001:end)));
%         baseline_post=mean(current_of_interest(3001:end));
        
        if isempty(current_amp_first)==0
        
            current_decay=find((current_of_interest(lk_trace(1):end))<(.33*current_amp_first(1)));
        
            current_rise=find(current_of_interest(1001:end)>(.66*current_amp_first(1)));
            
        
            peak_times(trial_number)=lk_trace(1);
            
            if isempty(current_decay)==1
            
                 else
                    current_decay_all_sweeps(trial_number)=current_decay(1);
                 end
        
        
                if isempty(current_rise)==1
            
                else
                    current_rise_all_sweeps(trial_number)=current_rise(1);
                end
                
                
                Allwaves.(Allwaves_fieldnames{trial_number}).current_amp_first=current_amp_first(1);
                current_amp_all_sweeps_first(trial_number)=current_amp_first(1);
                half_width_all_sweeps(trial_number)=width_trace(1);

        end
        
        current_amp_mean(trial_number)=max((current_of_interest_waves_means(trial_number,1001:end)));

        
        current_amp_first_sub=min((current_of_interest_sub(5:500)));
       
        
%         charge_second_allwaves(trial_number)=trapz(current_of_interest(1005:1500));
        charge_second_allwaves(trial_number)=trapz(current_of_interest(10000:20000));
%         current_amp_second=min((current_of_interest(1005:1500)));
         current_amp_second=min(medfilt1((current_of_interest(10000:20000)),1));
        current_amp_second_sub=min((current_of_interest_sub(1005:1500)));

        
        current_amp_all_sweeps_first_sub(trial_number)=current_amp_first_sub;
        
        current_amp_all_sweeps_second(trial_number)=current_amp_second;
        current_amp_all_sweeps_second_sub(trial_number)=current_amp_second_sub;
        
        
        baseline_all_sweeps(trial_number)=baseline;
        
        trace_all_waves(trial_number,:)=trace-baseline;
        
   

