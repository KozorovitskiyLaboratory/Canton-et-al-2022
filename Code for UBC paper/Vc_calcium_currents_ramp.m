

RC_Check_VC=120000:140000;
% RC_Check_VC=110000:130000;
% RC_Check_VC=70000:90000;
% time_of_interest=100000:120000;

time_of_interest=90000:110000;

time_course=(-110:.02:90);

    
   

        
        trace=Allwaves.(Allwaves_fieldnames{i}).data;
%         trace=interp(trace,2);
        
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
        holding_current_2=mean(trace(81000:82000));
        holding_current_3=mean(trace(110000:120000));
        holding_current_4=mean(trace(125000:130000));
        holding_current_5=mean(trace(133000:135000));
        

        holding_current_all_sweeps(1,i)=holding_current;
        holding_current_all_sweeps(2,i)=holding_current_2;
        holding_current_all_sweeps(3,i)=holding_current_3;
        holding_current_all_sweeps(4,i)=holding_current_4;
        holding_current_all_sweeps(5,i)=holding_current_5;
        
        
        Rs_VC=(20*10^-3)/(Rc_peak*10^-12);
        
%         Cm=tau/Rs_VC;
%         
        Rs_Rm_VC=(20*10^-3)/(Rc_steady*10^-12);
        
        Rm_VC=Rs_Rm_VC-Rs_VC;
        
        Allwaves.(Allwaves_fieldnames{i}).Series_Resistance=Rs_VC;
        Allwaves.(Allwaves_fieldnames{i}).Input_Resistance=Rm_VC;


        Series_Resistance_all_sweeps(i)=Rs_VC;
        Input_Resistance_all_sweeps(i)=Rm_VC;
       
%         capacitance_all_sweeps(i)=Cm;
%         tau_all_sweeps(i)=tau;
        Rc_steady_all_sweeps(i)=Rc_steady;
%         
%         
        Rc2=Rc(10000:15000)-mean(Rc(14000:15000));
        Rc2=(-1*Rc2);
%         Rc2=7*Rc2;
        Rc2=7*(Rc2/2);
%         Rc2=medfilt1(Rc2,100);
        
        
        
        current_of_interest=trace(time_of_interest);
        
        
        
        baseline=mean(current_of_interest(end-1000:end));
%         current_of_interest=current_of_interest-baseline;
        
%         [pk,lk]=findpeaks(current_of_interest(1:1000),'MinPeakHeight',100);
        
%         time=(0:.00005:1);
%         Rc_curve=pk(1)*(exp(-t/tau));
        
        current_of_interest_sub=current_of_interest;
        current_of_interest_sub=medfilt1(current_of_interest_sub,10);
        current_of_interest_sub(1:length(Rc2))=current_of_interest(1:length(Rc2))-Rc2;
        current_of_interest_sub=medfilt1(current_of_interest_sub,10);
        current_of_interest_waves_sub(i,:)=current_of_interest_sub;
        
        current_of_interest=medfilt1(current_of_interest,10);
        
        current_of_interest_waves(i,:)=current_of_interest;
        

 %% 
        
        charge_L_allwaves(i)=trapz(current_of_interest(2000:4000)*-1);
        
        current_amp_T=min((current_of_interest(100:4000)));
                current_amp_L=min((current_of_interest(5000:10000)));

%         [current_amp_T,lk_peak]=findpeaks((current_of_interest(100:4000)*-1),'MinPeakHeight',40,'MinPeakDistance',1000 );
%         [peak_velocity,lk_velocity]=findpeaks(velocity(spike_window),'MinPeakHeight',.5,'MinPeakDistance',20);
%                 [current_amp_T,lk_peak]=findpeaks(diff(current_of_interest(100:4000))*-1,'MinPeakHeight',3,'MinPeakDistance',1000 );

%         [current_amp_L,lk_peak_L]=findpeaks((current_of_interest(5000:10000)*-1),'MinPeakHeight',10,'MinPeakDistance',4000 );

%         current_amp_L_sub=min((current_of_interest_sub(100:3000)));
%        
%         Allwaves.(Allwaves_fieldnames{i}).current_amp_L=current_amp_L;
%         
%      
        current_amp_all_sweeps_T(i)=current_amp_T(1);
%         lk_peak_all_sweeps_T(i)=lk_peak(1);
%         
        current_amp_all_sweeps_L(i)=current_amp_L(1);
%         lk_peak_all_sweeps_L(i)=lk_peak_L(1);

        
%         
%         current_amp_all_sweeps_L_sub(i)=current_amp_L_sub;
        baseline_all_sweeps(i)=baseline;

%         subtracted_baseline_all_sweeps=holding_current_all_sweeps-baseline_all_sweeps;
