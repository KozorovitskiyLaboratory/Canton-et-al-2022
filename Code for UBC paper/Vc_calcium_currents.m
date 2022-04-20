

RC_Check_VC=120000:140000;
% RC_Check_VC=110000:130000;
% RC_Check_VC=70000:90000;
time_of_interest=100000:120000;

% time_of_interest=90000:110000;


    
   

        
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

       
       
        %maybe medfilt1 
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
        
        charge_L_allwaves(i)=trapz(current_of_interest(100:1000));
        
        current_amp_L=min((current_of_interest(100:2000)));
        
        current_amp_L_sub=min((current_of_interest_sub(100:2000)));
       
        Allwaves.(Allwaves_fieldnames{i}).current_amp_L=current_amp_L;
        
     
        current_amp_all_sweeps_L(i)=current_amp_L;
        current_amp_all_sweeps_L_sub(i)=current_amp_L_sub;
        baseline_all_sweeps(i)=baseline;
        
  


% %%
% 
% a=reshape(current_amp_all_sweeps_L(1:5*(floor(length(current_amp_all_sweeps_L)/5))),5,floor(length(current_amp_all_sweeps_L)/5));
% T_type=a(:,1:2:end);
% L_type=a(:,2:2:end);   
% 
% a=reshape(current_amp_all_sweeps_L_sub(1:5*(floor(length(current_amp_all_sweeps_L)/5))),5,floor(length(current_amp_all_sweeps_L)/5));
% T_type_sub=a(:,1:2:end);
% L_type_sub=a(:,2:2:end);   
% 
% 
% 
% %%
% % a=reshape(Series_Resistance_all_sweeps(1:5*(floor(length(Series_Resistance_all_sweeps)/5))),5,floor(length(Series_Resistance_all_sweeps)/5));
% % Rc_T_type=a(:,1:2:end);
% % Rc_L_type=a(:,2:2:end);   
% 
%  
% %%
% 
% Input_Resistance_all_sweeps=movmean(Input_Resistance_all_sweeps,20);
% % Series_Resistance_all_sweeps=movmean(Series_Resistance_all_sweeps,20);
% 
% current_amp_all_sweeps_norm=current_amp_all_sweeps_L.*Series_Resistance_all_sweeps;
% 
% mean_currents_norm=movmean((current_amp_all_sweeps_norm),5);
% 
% % mean_currents=movmean((current_amp_all_sweeps_L),5);
% 
% mean_currents_L_type=mean((L_type));
% mean_currents_T_type=mean((T_type));
% 
% mean_currents_L_type_sub=mean((L_type_sub));
% mean_currents_T_type_sub=mean((T_type_sub));
% 
% mean_charge=movmean((charge_L_allwaves),5);
% 
% % mean_currents=mean_currents(3:5:end);
% 
% mean_charge=mean_charge(3:5:end);
% 
% % 
% % figure
% % plot(mean_currents_L_type)
% % hold on
% % plot(mean_currents_T_type)
% % 
% % figure
% % plot(mean_currents_L_type_sub)
% % hold on
% % plot(mean_currents_T_type_sub)
% % 
% % 
% % 
% % figure
% % plot(Series_Resistance_all_sweeps)
% 
% %%
% current_of_interest_waves_means=movmean(current_of_interest_waves,5);
% 
% 
% % 
% % figure
% % % for j=1:4:floor(length(current_of_interest_waves_means(:,1))/10)
% %     for j=1:4:20
% % 
% %     
% %      plot(current_of_interest_waves_means((3+((j-1)*10)),1:end),'LineWidth',2)
% %      hold on
% %         legend('1','2','3','4','5' ,'6')
% % end
% % 
% % 
% % figure
% % for j=1:4:(floor(length(current_of_interest_waves_means(:,1))/10))
% %     
% %      plot(current_of_interest_waves_means((6+((j-1)*10)),1:1000),'LineWidth',2)
% %         hold on
% % %         legend('1','2','3','4','5' ,'6')
% % end
% % 
% % 

% %%
% 
% name=pwd;
% name1=(name(1:end-12));
% name1=name;
% cd(name1);
% name2=name(end-5:end);
% name=strcat(name(end-5:end),'_summary.mat');
% 
% save(name,'current_amp_all_sweeps_L', 'Series_Resistance_all_sweeps','Input_Resistance_all_sweeps', 'mean_currents_T_type', 'mean_currents_L_type','holding_current_all_sweeps', 'baseline_all_sweeps', 'T_type' );
% 


