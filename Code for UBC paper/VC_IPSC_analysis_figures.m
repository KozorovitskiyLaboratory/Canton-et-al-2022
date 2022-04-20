%%
% 
% %% Plot CDF
% figure
% 
% x=0:10:300;
% linecolors = jet(length(Allwaves_fieldnames));
% 
% 
% 
% for i=1:10:length(Allwaves_fieldnames)
%     
%     if strcmp(Allwaves.(Allwaves_fieldnames{i}).clamp,'Current')==1
%     
%         ISI=Allwaves.(Allwaves_fieldnames{i}).ISI_array_ms;
%     
%         [f,z]=hist(ISI,x);
%         % Make pdf by normalizing counts
% 
%         % Divide by the total counts and the bin width to make area under curve 1.
%         fNorm = f/(sum(f)*(z(2)-z(1))); 
% 
%         % cdf is no cumulative sum
%         fCDF = cumsum(fNorm);
% 
% 
%         % bar(z,fNorm) % display
%         if isempty(ISI)==1
%             ISI=zeros(10,1);
%         end
%         
%         h = cdfplot(ISI);
%         set(h,'Color',linecolors(i,:));
% 
%         hold on
%     
%     end
% end
% clearvars -except   RC_Check membrane_potential_all_sweeps Allwaves Extra Allwaves_fieldnames Extra_fieldnames cluster coefficient_variation_all_sweeps standard_deviation_all_sweeps  mean_firing_rates_all_sweeps mean_firing_rates_all_sweeps_2 Input_resistance_all_sweeps ISI_array_all_sweeps list list2 neuroncount top_directory capacitance_all_sweeps Rcpeak_Rcsteady_all_sweeps Rcpeak_Rcsteady_all_sweeps spike_amp_trace_all_sweeps spike_waveforms_all_sweeps threshold_all_sweeps half_width_all_sweeps AHP_depth_all_sweeps AHP_min_all_sweeps AP_peaks_all_sweeps mouse_gender mouse_age lobule list3 list4 list5;
% 

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
            
            plot(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).data)
            hold on
            
                            plot(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_trace,Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).peak_trace,'o')

            if isempty(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).peak_trace)==0
                plot(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_trace,Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).peak_trace,'o')
             
                plot(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_threshold,Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).peak_threshold,'o')
            
                plot(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_AHP,Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).data(Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).lk_AHP),'o')
                                
            end
             
            if Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).clamp=='Current';
                aaa=Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).membrane_potential;
                line([0 length((Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).data))],[Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).membrane_potential Allwaves.(Allwaves_fieldnames{i+(p*(j-1))}).membrane_potential],'Color','red','LineStyle','--');
            end
            
            title(Allwaves_fieldnames{i+(p*(j-1))});
%             xlim([139000 141000])
%             ylim([100 600])
        end
        hold on
    end
    
end

% clearvars -except   RC_Check membrane_potential_all_sweeps Allwaves Extra Allwaves_fieldnames Extra_fieldnames cluster coefficient_variation_all_sweeps standard_deviation_all_sweeps  mean_firing_rates_all_sweeps mean_firing_rates_all_sweeps_2 Input_resistance_all_sweeps ISI_array_all_sweeps list list2 neuroncount top_directory capacitance_all_sweeps Rcpeak_Rcsteady_all_sweeps Rcpeak_Rcsteady_all_sweeps spike_amp_trace_all_sweeps spike_waveforms_all_sweeps threshold_all_sweeps half_width_all_sweeps AHP_depth_all_sweeps AHP_min_all_sweeps AP_peaks_all_sweeps mouse_gender mouse_age lobule list3 list4 list5;


%% Raster plot of spikes

figure
for i=1:length(Allwaves_fieldnames)
        s{i}=Allwaves.(Allwaves_fieldnames{i}).spiketimes;
        t{i}=Allwaves.(Allwaves_fieldnames{i}).peak_trace;
end   

if exist('s','var')
    N = length(s);
    hold on
    for k = [1:N],
        height = [zeros(1,length(s{k})); 0.7*ones(1,length(s{k}))]+k;
        h = line([s{k}; s{k}], height);
        set(h, 'color', 'k');
    end  
end

line([1 1],[0 50])
line([2 2],[0 50])
% 
% % name=pwd;
% % name1=(name(1:end-12));
% % cd(name1);
% % name2=strcat(name(end-5:end),'_raster.jpg');
% % 
% % 
% % saveas(gcf,name2)
% % cd(name)
% 

% 
% 
% clearvars h height k s N i name name1 name2


s1=cell2mat(s(11:43));
t1=cell2mat(t(11:43));

clearvars h height k  N i name name1 name2




%%
%
      for k=1:length(Allwaves_fieldnames)
%             c2((k),:)=Allwaves.(Allwaves_fieldnames{k}).ISI_array_across(1:end);
            c=ISI_array_across_all_sweeps{1,k};
            c2((k),:)=c(1:297585);

      end
      d2=mean(c2);
      
      figure
      plot(d2)
      hold on
%

      for k=51:60
            c((k),:)=Allwaves.(Allwaves_fieldnames{k}).ISI_array_across(1:end);
      end
      d=mean(c);
      
      plot(d)
      
%
      
      for k=51:60
            c1((k),:)=Allwaves.(Allwaves_fieldnames{k}).ISI_array_across(1:end);
      end
      d1=mean(c1);
      
  
      plot(d1)


%% plot average data


figure

subplot(4,2,1)
bar(cell2mat(mean_firing_rates_all_sweeps))

subplot(4,2,2)
bar(cell2mat(coefficient_variation_all_sweeps))

subplot(4,2,3)
bar(cell2mat(standard_deviation_all_sweeps))

subplot(4,2,4)
bar(cell2mat(Input_resistance_all_sweeps))

subplot(4,2,5)
bar(cell2mat(membrane_potential_all_sweeps))

subplot(4,2,6)
bar(cell2mat(capacitance_all_sweeps))

subplot(4,2,7)
scatter(cell2mat(mean_firing_rates_all_sweeps),cell2mat(membrane_potential_all_sweeps))

subplot(4,2,8)
scatter(cell2mat(mean_firing_rates_all_sweeps),cell2mat(Input_resistance_all_sweeps))

%%
figure
scatter3(cell2mat(mean_firing_rates_all_sweeps),cell2mat(membrane_potential_all_sweeps),cell2mat(Input_resistance_all_sweeps));

