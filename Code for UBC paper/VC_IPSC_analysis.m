%% Current clamp analysis, gets basic firing properties, input resistance, spiketimes. Puts them into a struct
        
        trace=Allwaves.(Allwaves_fieldnames{i}).data;
        
        trace=trace-mean(trace(1:length(trace)/2));
       
        trace=medfilt1(trace,5);
        
        trace=trace*-1;
        event_detect_threshold=10;
        
        spike_window=int64(spike_window_sec*sampling_rate);
        RC_Check=int64(RC_Check_sec*sampling_rate);
        
        velocity=diff(medfilt1((trace),10));
%         velocity=diff(velocity);
        acceleration=diff(velocity);

        [peak_velocity,lk_velocity]=findpeaks(velocity(spike_window),'MinPeakHeight',.5,'MinPeakDistance',20);
        lk_velocity=lk_velocity-10;
        [peak_trace,lk_trace,width_trace, spike_amp_trace]=findpeaks(trace(spike_window),'MinPeakHeight',event_detect_threshold,'MinPeakDistance',50,'MinPeakWidth',50);
        [LASTMSG, LASTID] = lastwarn;
        warning('off',LASTID)
        width_trace=width_trace/(sampling_rate/1000); % converts to ms
        
        peak_velocity=peak_velocity(2:length(peak_velocity));
        lk_velocity=lk_velocity(2:length(lk_velocity));
        
        peak_trace=peak_trace(2:length(peak_trace));
        lk_trace=lk_trace(2:length(lk_trace));
        width_trace=width_trace(2:length(width_trace));
        spike_amp_trace=spike_amp_trace(2:length(spike_amp_trace));
        
        
        peak_velocity_temp=[];
        lk_velocity_temp=[];
        
%         for j=1:length(lk_velocity)
%             if lk_velocity(j)>50000 && lk_velocity(j) < 56000
%                 
%             else
%         lk_trace_temp=[];
%         peak_trace_temp=[];
%                 peak_velocity_temp(j)=peak_velocity(j);
%                 lk_velocity_temp(j)=lk_velocity(j);
%             end
%         end
        
        lk_velocity=lk_velocity_temp;
        lk_velocity(lk_velocity==0) = [];
        peak_velocity=peak_velocity_temp;
        peak_velocity(peak_velocity==0) = [];
        
        lk_trace_temp=[];
        peak_trace_temp=[];
        width_trace_temp=[];
        spike_amp_trace_temp=[];
        
        for j=1:length(lk_trace)
            if lk_trace(j)>50000 && lk_trace(j) < 56000
                
              
            else
                peak_trace_temp(j)=peak_trace(j);
                lk_trace_temp(j)=lk_trace(j);
                width_trace_temp(j)=width_trace(j); 
                spike_amp_trace_temp(j)=spike_amp_trace(j); 
            end
        end
        
        peak_trace=peak_trace_temp;
        peak_trace(peak_trace==0) = [];

        lk_trace=lk_trace_temp;
        lk_trace(lk_trace==0) = [];
        
        width_trace=width_trace_temp;
        width_trace(width_trace==0) = [];
        
        spike_amp_trace=spike_amp_trace_temp;
        spike_amp_trace(spike_amp_trace==0) = [];
        
%         
        threshold=NaN(1,length(peak_velocity));
        
%         for j=1:length(peak_velocity)
%             if lk_velocity(j)>0;
%                 if -60<trace(lk_velocity(j)) && trace(lk_velocity(j))<-20 ;
%                     threshold(j)=trace(lk_velocity(j));
%                 end
%             end
%         end
        
        lk_threshold=NaN(1,length(peak_trace));
        peak_threshold=NaN(1,length(peak_trace));
        
        for j=1:length(peak_trace)
            a=find((lk_trace(j)-20)<lk_velocity & (lk_trace(j))>lk_velocity);
            if isempty(a)==0
                lk_threshold(j)=lk_velocity(a);
                peak_threshold(j)=trace(lk_velocity(a));
            end
        end
        
%         threshold = threshold(threshold~=0);
        
        peak_AHP=[];
        peak_AHP_2=[];
        peak_AHP_3=[];
        lk_AHP=[];
        width_AHP=[];
        
        mov_membrane=movmean(medfilt1(trace,1000),100);
        
        for j=1:length(peak_trace)
            if lk_trace(j)<149950
                
%                 [peak_AHP_list,lk_AHP_list,width_AHP_list]=findpeaks(-1*(trace(lk_trace(j):lk_trace(j)+200)),'MinPeakHeight',30,'MinPeakDistance',50);
%             if isempty(peak_AHP_list)==0
%              
%                 peak_AHP(j)=peak_AHP_list(1).*-1;
%                 peak_AHP_2(j)=peak_AHP(j)-mov_membrane(lk_trace(j));
%                 lk_AHP(j)=lk_trace(j)+lk_AHP_list(1);
%                 width_AHP(j)=width_AHP_list(1);
%             
                peak_AHP(j)=min(trace(lk_trace(j):lk_trace(j)+200));
                lk_AHP(j)=lk_trace(j)+(find((trace(lk_trace(j):lk_trace(j)+200))==peak_AHP(j),1));
%                 peak_AHP(j)=peak_AHP(j).*-1;
                peak_AHP_2(j)=peak_AHP(j)-mov_membrane(lk_trace(j));
%                 
                
                peak_AHP(j)=min(trace(lk_trace(j):lk_trace(j)+200));
                lk_AHP(j)=lk_trace(j)+(find((trace(lk_trace(j):lk_trace(j)+200))==peak_AHP(j),1));
%                 peak_AHP(j)=peak_AHP(j).*-1;
                peak_AHP_3(j)=peak_AHP(j)-peak_threshold(j);
                
            else
                peak_AHP(j)=nan;
                lk_AHP(j)=nan;
                width_AHP(j)=nan;
            end
            
        end
        

        
        spiketimes=lk_trace;
        
        spike_waveforms=NaN(length(peak_trace),651);
        
        for j=1:length(spiketimes)
            if lk_trace(j)>51 && lk_trace(j)<(spike_window(end)-500) 
                spike_waveforms(j,:)=trace(lk_trace(j)-50:lk_trace(j)+600);
            else
%                 spike_waveforms(j,:)=[]; 
            end
        end
%         spike_waveforms(spike_waveforms==0) = [];
        
 
        spiketimes_array= spiketimes/sampling_rate;

        ISI_array= diff(spiketimes_array);

        firing_rate_array = 1./ISI_array;

               
        mean_event_rate = length(firing_rate_array)/spike_window_sec(end);
        standard_deviation = std2(firing_rate_array);
         coefficient_variation = standard_deviation/mean_event_rate;
        
        trace1=trace;
        trace1(trace>-35)=-45;
        membrane_potential=mean(medfilt1(trace1(1:50000),50000));
        
        if isempty(peak_trace)==0
        
            AHP_depth=membrane_potential-peak_AHP;
        else
            AHP_depth=[];
            
        end

%         peak_AHP=peak_AHP-membrane_potential;

        Allwaves.(Allwaves_fieldnames{i}).mouse_age=mouse_age;
        Allwaves.(Allwaves_fieldnames{i}).mouse_gender=mouse_gender;
        Allwaves.(Allwaves_fieldnames{i}).lobule=lobule;
        Allwaves.(Allwaves_fieldnames{i}).velocity=velocity;
        Allwaves.(Allwaves_fieldnames{i}).acceleration=acceleration;
        Allwaves.(Allwaves_fieldnames{i}).peak_velocity=peak_velocity;
        Allwaves.(Allwaves_fieldnames{i}).lk_velocity=lk_velocity;
        Allwaves.(Allwaves_fieldnames{i}).peak_threshold=peak_threshold;
        Allwaves.(Allwaves_fieldnames{i}).lk_threshold=lk_threshold;
        Allwaves.(Allwaves_fieldnames{i}).peak_trace=peak_trace;
        Allwaves.(Allwaves_fieldnames{i}).lk_trace=lk_trace;
        Allwaves.(Allwaves_fieldnames{i}).peak_AHP=peak_AHP;
        Allwaves.(Allwaves_fieldnames{i}).peak_AHP_Vm=peak_AHP_2;
        Allwaves.(Allwaves_fieldnames{i}).peak_AHP_thresh=peak_AHP_3;
        Allwaves.(Allwaves_fieldnames{i}).lk_AHP=lk_AHP;
        Allwaves.(Allwaves_fieldnames{i}).spike_waveforms=spike_waveforms;
        Allwaves.(Allwaves_fieldnames{i}).half_width=width_trace;
        Allwaves.(Allwaves_fieldnames{i}).spike_amp_trace=spike_amp_trace;
        Allwaves.(Allwaves_fieldnames{i}).AHP_depth=AHP_depth;
        Allwaves.(Allwaves_fieldnames{i}).AHP_width=width_AHP;
        Allwaves.(Allwaves_fieldnames{i}).spiketimes=spiketimes_array;
        Allwaves.(Allwaves_fieldnames{i}).ISI_array_ms=ISI_array*1000;
%         Allwaves.(Allwaves_fieldnames{i}).ISI_array_across=ISI_array_across*1000;

        Allwaves.(Allwaves_fieldnames{i}).mean_firing_rate=mean_event_rate;
        Allwaves.(Allwaves_fieldnames{i}).standard_deviation=standard_deviation;
        Allwaves.(Allwaves_fieldnames{i}).coefficient_variation=coefficient_variation;
        Allwaves.(Allwaves_fieldnames{i}).membrane_potential=membrane_potential;
        Allwaves.(Allwaves_fieldnames{i}).threshold=threshold;
        Allwaves.(Allwaves_fieldnames{i}).mov_mebrane=mov_membrane;
        
        
        Allwaves.(Allwaves_fieldnames{i}).RC=trace(RC_Check);
        
        Rc=trace(RC_Check);
        Rc_base=mean(medfilt1(Rc(1:10000),1000));
        Rc_steady=(Rc_base-min(Rc(14000:end)));
        Rc_peak=(Rc_base-min(Rc(1:14000)));
        Rcpeak_Rcsteady=Rc_peak/Rc_steady;
        
        Allwaves.(Allwaves_fieldnames{i}).Input_Resistance=((mean(medfilt1(trace(130000:140000),1000))-min(trace(142000:150000)))/RC_pulse)*1000;
        Allwaves.(Allwaves_fieldnames{i}).Rcpeak_Rcsteady=Rcpeak_Rcsteady;
        
        Rc=Rc(10000:end);
        tau=find(Rc<Rc_base-.63*Rc_steady);
        
        if isempty(tau)==0
            Cm=tau(1)/Allwaves.(Allwaves_fieldnames{i}).Input_Resistance;
        else
            Cm=[];
        end
        
        Allwaves.(Allwaves_fieldnames{i}).capacitance=Cm;
        
        time_length=(1:length(trace));
        if isempty(ISI_array)==0
            
            for j=2:length(spiketimes)

              ind=time_length(time_length>spiketimes(j-1) & time_length<spiketimes(j));

              ISI_array_across(ind(1):ind(end))=ISI_array(j-1);

            
            end
        else
            ISI_array_across=[];
            
        end
        

        if strcmp(Allwaves.(Allwaves_fieldnames{i}).clamp,'Current')==1
            Input_resistance_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).Input_Resistance;
            mean_firing_rates_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).mean_firing_rate;
            standard_deviation_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).standard_deviation;
            coefficient_variation_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).coefficient_variation;
            membrane_potential_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).membrane_potential;
            ISI_array_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).ISI_array_ms;
            capacitance_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).capacitance;
            Rcpeak_Rcsteady_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).Rcpeak_Rcsteady;
            spike_amp_trace_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).spike_amp_trace;
            spike_waveforms_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).spike_waveforms;
            threshold_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).peak_threshold;
            half_width_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).half_width;
            
            AHP_depth_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).AHP_depth;
            AHP_width_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).AHP_width;

            AHP_min_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).peak_AHP;
            AHP_Vm_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).peak_AHP_Vm;
            AHP_thresh_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).peak_AHP_thresh;
            AP_peaks_all_sweeps{i}=Allwaves.(Allwaves_fieldnames{i}).peak_trace;
        end
            ISI_array_across_all_sweeps{i}=ISI_array_across;
 trace_all_waves(i,:)=trace;
% clearvars -except  RC_pulse RC_pulse_VC RC_Check_VC RC_Check membrane_potential_all_sweeps Allwaves Extra Allwaves_fieldnames Extra_fieldnames cluster coefficient_variation_all_sweeps standard_deviation_all_sweeps  mean_firing_rates_all_sweeps mean_firing_rates_all_sweeps_2 Input_resistance_all_sweeps ISI_array_all_sweeps list list2 neuroncount top_directory capacitance_all_sweeps Rcpeak_Rcsteady_all_sweeps Rcpeak_Rcsteady_all_sweeps spike_amp_trace_all_sweeps spike_waveforms_all_sweeps threshold_all_sweeps half_width_all_sweeps AHP_depth_all_sweeps AHP_min_all_sweeps AP_peaks_all_sweeps mouse_gender mouse_age lobule list3 list4 list5;

