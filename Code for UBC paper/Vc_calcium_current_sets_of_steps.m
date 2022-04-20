
% % % % 
% RC_Check_VC=135000:150000;
% time_of_interest=50000:60000;
% steps=(-100:10:-10);
% %  
% RC_Check_VC=50000:70000;
% time_of_interest=50000:60000;
% steps=(-100:10:40);
% 

RC_Check_VC=120000:140000;
% RC_Check_VC=70000:100000;
time_of_interest=100000:120000;

steps=(-100:10:40);


    
   
        
        trace=Allwaves.(Allwaves_fieldnames{i}).data;
       
        Rc=trace(RC_Check_VC);
        % Rc=medfilt1(Rc,1000);
        Rc_base=mean(Rc(9000:9500));
%         Rc_steady=(Rc_base-min(Rc(1:6000)));
        
        Rc_peak=max(Rc(10000:10500))-min(Rc(10000:10500));
%         Rc_steady=abs(Rc_base-min(Rc(10000:10500)));
        Rc_steady=Rc_peak;
        
        Rc_st=abs(Rc_base-min(Rc(14000:14500)));
        
        
        tau=find(Rc<Rc_base-.63*Rc_steady);


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
        

        Rs_VC=(10*10^-3)/(Rc_steady*10^-12);
        
        Rs_Rm_VC=(10*10^-3)/(Rc_st*10^-12);
        
        Rm_VC=Rs_Rm_VC-Rs_VC;
        
        Allwaves.(Allwaves_fieldnames{i}).Series_Resistance=Rs_VC;
        Allwaves.(Allwaves_fieldnames{i}).Input_Resistance=Rm_VC;


        Series_Resistance_all_sweeps(i)=Rs_VC;
        Input_Resistance_all_sweeps(i)=Rm_VC;
        
        current_of_interest=trace(time_of_interest);
        
        
        
        baseline=mean(current_of_interest(end-1000:end));
         baseline_all_sweeps(i)=baseline;
%         current_of_interest=current_of_interest-baseline;
        
%         current_of_interest=medfilt1(current_of_interest,100);
        
        current_of_interest_waves(i,:)=current_of_interest;
        
 %% 
        
        number=max(abs(current_of_interest(20:1000)))-baseline;
        number1=max(current_of_interest(20:1000))-baseline;
        
        if number==number1
           current_amp=number;
        else
           current_amp=(number*-1);
        end
        
%         a=diff(current_of_interest(2:1000));
%         b=find(a>-10 & a<10);
%         current_amp=(b(1)-baseline);
%         current_amp=min(current_of_interest(10:1000))-baseline;
        
        
%         current_amp_T=min(current_of_interest(5:150))-baseline;
        
        number=max(abs(current_of_interest(20:150)))-baseline;
        number1=max(current_of_interest(20:150))-baseline;
        
        if number==number1
           current_amp_T=number;
        else
           current_amp_T=(number*-1);
        end        
        
        charge_L_allwaves(i)=trapz(current_of_interest(100:3000));

%         current_amp_L=min(current_of_interest(150:1000))-baseline;
%         current_amp=min(current_of_interest(50:2000));
          
        number=max(abs(current_of_interest(100:2000)))-baseline;
        number1=max(current_of_interest(100:2000))-baseline;
        
        if number==number1
           current_amp_L=number;
        else
           current_amp_L=(number*-1);
        end        


      
        Allwaves.(Allwaves_fieldnames{i}).current_amp=current_amp;
        Allwaves.(Allwaves_fieldnames{i}).current_amp_T=current_amp_T;
        Allwaves.(Allwaves_fieldnames{i}).current_amp_L=current_amp_L;

        current_amp_all_sweeps(i)=current_amp;
        current_amp_all_sweeps_T(i)=current_amp_T;
        current_amp_all_sweeps_L(i)=current_amp_L;

        
        
        

%%


Input_Resistance_all_sweeps=movmean(Input_Resistance_all_sweeps,20);
Series_Resistance_all_sweeps=movmean(Series_Resistance_all_sweeps,20);

current_amp_all_sweeps_norm=current_amp_all_sweeps_L.*Series_Resistance_all_sweeps;

mean_currents=movmean((current_amp_all_sweeps_L),3);
mean_currents_norm=movmean((current_amp_all_sweeps_norm),3);


mean_charge=movmean((charge_L_allwaves),3);


% mean_currents=mean_currents(2:3:end);
% mean_currents=mean_currents(44:3:end);
% mean_currents=mean_currents(2:3:end);
mean_currents=mean_currents(2:3:end);
mean_currents_norm=mean_currents_norm(2:3:end);
% mean_currents=mean_currents(1:3:end);

mean_charge=mean_charge(2:3:end);

mean_currents=reshape(mean_currents(1:floor(length(current_amp_all_sweeps)/(3*length(steps)))*length(steps)),[length(steps),floor(length(current_amp_all_sweeps)/(3*length(steps)))]);
mean_currents_norm=reshape(mean_currents_norm(1:floor(length(current_amp_all_sweeps)/(3*length(steps)))*length(steps)),[length(steps),floor(length(current_amp_all_sweeps)/(3*length(steps)))]);

% mean_currents=reshape(mean_currents(1:90),[15,6]);
% mean_currents_norm=reshape(mean_currents_norm(1:90),[15,6]);

% mean_currents=reshape(mean_currents(1:75),[15,5]);

% mean_currents=reshape(mean_currents(1:60),[15,4]);
% mean_currents_norm=reshape(mean_currents_norm(1:60),[15,4]);


% mean_charge=reshape(mean_charge(1:60),[15,4]);

% mean_currents=reshape(mean_currents(1:60),[10,6]);




