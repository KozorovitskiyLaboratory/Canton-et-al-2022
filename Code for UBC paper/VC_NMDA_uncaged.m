

RC_Check_VC=130000:150000;
% RC_Check_VC=110000:130000;
% RC_Check_VC=70000:90000;
% RC_Check_VC=270000:290000;

% 
time_of_interest(1,:)=[1:30000];
time_of_interest(2,:)=[50001:80000]; 
time_of_interest(3,:)=[100001:130000];   
% % 
% time_of_interest(1,:)=[1:60000];
% time_of_interest(2,:)=[100001:160000]; 
% time_of_interest(3,:)=[200001:260000]; 

        trace=Allwaves.(Allwaves_fieldnames{trial_number}).data;
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

       Rc_s=Rc(15004:15100);
       Rc_s=Rc_s';
       
       y=1:1:length(Rc_s);
       y=y';
       
       f0 = fit(y,Rc_s,g,'StartPoint',[[ones(size(y)), -exp(-y)]\Rc_s; 1]);

       xx=y;
       plot(y,Rc_s,'o',xx,f0(xx),'r-');
        
       tau_index=find(f0(xx)<.37*(max(f0(xx))));
       tau_index=tau(1)/sampling_rate;
       tau=

        holding_current=mean(trace(1:10000));
        holding_current_all_sweeps(trial_number)=holding_current;

        Rs_VC=(5*10^-3)/(Rc_peak*10^-12);
        
%         Cm=tau/Rs_VC;
%         
        Rs_Rm_VC=(10*10^-3)/(Rc_steady*10^-12);
        
        Rm_VC=Rs_Rm_VC-Rs_VC;
        
        Allwaves.(Allwaves_fieldnames{trial_number}).Series_Resistance=Rs_VC;
        Allwaves.(Allwaves_fieldnames{trial_number}).Input_Resistance=Rm_VC;


        Series_Resistance_all_sweeps(trial_number)=Rs_VC;
        Input_Resistance_all_sweeps(trial_number)=Rm_VC;
       
%         capacitance_all_sweeps(i)=Cm;
%         tau_all_sweeps(i)=tau;
        Rc_peak_all_sweeps(trial_number)=Rc_peak;
        Rc_steady_all_sweeps(trial_number)=Rc_steady;
%         
%         
        Rc2=Rc(10000:15000)-mean(Rc(14000:15000));
        Rc2=(-1*Rc2);
%         Rc2=7*Rc2;
        Rc2=7*(Rc2/2);
%         Rc2=medfilt1(Rc2,100);
        
        
    for k=1:3   
        current_of_interest(k,:)=trace(time_of_interest(k,:));
        
        baseline(k,:)=mean(current_of_interest(k,1:1000));
        
        current_of_interest(k,:)=current_of_interest(k,:)-baseline(k);
        current_of_interest(k,:)=medfilt1(current_of_interest(k,:),1000);

        
        
%          charge(k)=trapz(current_of_interest(k,:));
%          current_amp(k)=max(current_of_interest(k,:));
%         temp=(findpeaks(current_of_interest(k,9000:20000),'MinPeakWidth',200,'MinPeakHeight',5,'MinPeakDistance',10000));
                temp=(findpeaks(current_of_interest(k,:),'MinPeakWidth',200,'MinPeakHeight',2,'MinPeakDistance',10000));

        if isempty(temp)
            current_amp(k)=NaN;
            charge(k)=NaN;
        else
            current_amp(k)=temp(1,1);
            charge(k)=trapz(current_of_interest(k,:));
        end
    end
    current_of_interest_1(trial_number,:)=current_of_interest(2,:);
    
    Allwaves.(Allwaves_fieldnames{trial_number}).current_amp=current_amp;
 %% 
        

       
%         Allwaves.(Allwaves_fieldnames{trial_number}).current_amp=current_amp;
        
        
        
        current_amp_all_sweeps(trial_number,:)=current_amp;
        
        charge_all_sweeps(trial_number,:)=charge;
        
        
%         baseline_all_sweeps(i)=baseline;
        
        trace_all_waves(trial_number,:)=trace-mean(baseline);
        





