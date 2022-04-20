% clearvars
close all
% cd('C:\Users\Neto\Desktop\KLab\Recording Data\NJ');
cd('D:\Users\Earnest\Desktop\KLab\Recording Data\NJ');

% cd('C:\Users\Earnest\Dropbox\Neto Klab\Semi-Processed data\Summary data');
% cd('C:\Users\Neto\Dropbox\Neto Klab\Semi-Processed data\Summary data');

% 10 uM flow in
% list={'nj138b','nj138c','nj139a','nj139b','nj139c','nj140a','nj140b','nj140c'};

% list={'nj132a','nj133a','nj133b','nj133c','nj133c','nj134a','nj135a','nj135b','nj135c','nj135d','nj136a','nj136b','nj136c','nj136d','nj137a','nj137b','nj137c','nj137d','nj138a','nj143a','nj143b','nj143c','nj143d','nj143e','nj144a','nj144b','nj145a','nj145b'};

%ACSF puff All batch 9
% list={'nj134a','nj135a','nj135b'};

% puff batch 8
% list={'nj132a','nj142a','nj143a','nj143b','nj143c','nj143d','nj143e','nj144a','nj144b','nj145a','nj145b','nj146a'};
% list={'nj156a','nj156c','nj157a','nj158a','nj158b','nj158c','nj158d','nj159a','nj159b','nj160a','nj160b','nj160c','nj164b'};
% list={'nj132a','nj142a','nj143a','nj143b','nj143c','nj143d','nj143e','nj144a','nj144b','nj145a','nj145b','nj156a','nj156c','nj157a','nj158a','nj158b','nj158c','nj158d','nj159a','nj159b'};
% list={'nj132a','nj142a','nj143a','nj143b','nj143c','nj143e','nj144a','nj144b','nj145a','nj145b','nj156a','nj156c','nj157a','nj158a','nj158b','nj158c','nj158d','nj159a','nj159b'};

% All recordigns with batch 8/10
% list={'nj132a','nj132b','nj139b','nj139c','nj140a','nj140c','nj142a','nj143a','nj143b','nj143c','nj143d','nj143e','nj144a','nj144b','nj145a','nj145b','nj145c','nj150a','nj150b','nj150c','nj150d','nj156a','nj156b','nj156c','nj157a','nj158a','nj158b','nj158c','nj158d','nj159a','nj159b'};


% puff batch 8 Bayk644
% list={'nj158a','nj158b','nj158c','nj158d' 'nj159b'};



% % puff batch 8 nimodipine
% list={'nj132b','nj133b','nj133c','nj137b','nj137d','nj143b','nj143c','nj143d','nj143e','nj144b','nj150c', 'nj150d'};



% % puff batch 8 nimodipine
% list={'nj132b','nj133c','nj137d','nj159a','nj159b'};

% puff batch 9
% list={'nj133a','nj133b','nj133c','nj133c','nj135c','nj135d','nj136a','nj136b','nj136c','nj136d','nj137a','nj137b','nj137c','nj137d','nj138a'};
% list={'nj136c','nj137a','nj137b'};



% 500 um puff 34 C w TEA and CS in external (this is best way to do this experiment)

% ACSF puff 34 usable
% list={'nj165a','nj165b','nj166a','nj167a','nj168a'};

%SKF puff usable 34C
% list={'nj166b','nj166e','nj167d','nj168b','nj171b','nj171c','nj171d'};

list={'nj166e','nj167d','nj168b','nj171b','nj171c','nj171d'};


% list={'nj166b','nj166e','nj167d','nj168b','nj171b','nj171c','nj171d' 'nj165a','nj165b','nj166a','nj167a','nj168a'};

% list={'nj166b','nj166e','nj167d','nj168b','nj171b','nj171c','nj171d','nj132a','nj142a','nj143a','nj143b','nj143e','nj144b','nj145a','nj145b'};
% 
% most effect
% list={'nj129c' 'nj133a' 'nj133c' 'nj137a' 'nj138c' 'nj138b' 'nj166e'};



% High Ca conotoxin  TTA2

% list={'nj193a' 'nj193b' 'nj194a' 'nj194c' 'nj195a' 'nj195b' 'nj196a' 'nj196b' 'nj197a' 'nj197b' 'nj197c'};


%%

Total_summary=struct;

for i=1:length(list)
    item=strcat(list{i},'_summary.mat');
    Total_summary.(list{i})=load(item);
    
end
   
Total_summary_fieldnames=sort(fieldnames(Total_summary)); 
    
clearvars -except Total_summary Total_summary_fieldnames list


%%


summary_of_summary={};


hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

%     mean_t=zeros(length(Total_summary_fieldnames),70);
  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
    
    subplot(3,1,1)
    plot(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_L)
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

%     mean_t=zeros(length(Total_summary_fieldnames),70);
  
for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    hax1 = axes('Parent', htab1);
    
    subplot(3,1,1)
    plot(Total_summary.(Total_summary_fieldnames{i}).current_amp_all_sweeps_L)
    title(Total_summary_fieldnames{i});
    subplot(3,1,2)
    plot(Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type)
    hold on
%     plot(Total_summary.(Total_summary_fieldnames{i}).mean_currents_L_type)

    title(Total_summary_fieldnames{i});
    subplot(3,1,3)
    plot(Total_summary.(Total_summary_fieldnames{i}).Series_Resistance_all_sweeps)
    title(Total_summary_fieldnames{i});
    hold on
    
    a{i}=(Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type/Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type(4));
    a1{i}=(Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type);

    
%     mean_t(i,:)=Total_summary.(Total_summary_fieldnames{i}).T_type;

t_base(1,i)=Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type(4);
t_base(2,i)=max(Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type(10));
if length(Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type)>11;
t_base(3,i)=max(Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type(12));
end


%     t_all(i,:)=Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type(1:12);
%     t_all_norm(i,:)=t_all(i,:)/t_all(i,4);

% series(i)=Total_summary.(Total_summary_fieldnames{i}).T_type(1,4);

% 
% t_base(1,i)=Total_summary.(Total_summary_fieldnames{i}).T_type(1,4);
% t_base(2,i)=mean(Total_summary.(Total_summary_fieldnames{i}).T_type(1,8:9));
% if length(Total_summary.(Total_summary_fieldnames{i}).mean_currents_T_type)>11;
% t_base(3,i)=mean(Total_summary.(Total_summary_fieldnames{i}).T_type(1,12));
% end

    % t_d(1,i)=Total_summary.(Total_summary_fieldnames{i}).T_type(1,4);

    clear AHP_mean half_width_mean threshold_mean spike_amp_mean waveform_mean
end
t_base_norm(1,:)=t_base(1,:)./t_base(1,:);
t_base_norm(2,:)=t_base(2,:)./t_base(1,:);
t_base_norm(3,:)=t_base(3,:)./t_base(1,:);

t_diff=t_base(2,:)-t_base(1,:);

[h,p]=signrank(t_base(1,:),t_base(3,:));

% clear i j AHP_mean half_width_mean threshold_mean spike_amp_mean

%%


hfig1 = figure('WindowStyle','normal');
htabgroup = uitabgroup(hfig1);

  
a=[-80,-110,40,-80,-100];

for i=1:length(Total_summary_fieldnames)
   
    htab1 = uitab(htabgroup, 'Title', num2str(i));
    
    hax1 = axes('Parent', htab1);
    
    plot(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(1:120)-Total_summary.(Total_summary_fieldnames{i}).baseline_all_sweeps(1:120))
    hold on
%     plot(Total_summary.(Total_summary_fieldnames{i}).baseline_all_sweeps)
%     plot(Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps(1:120))
%     ylim([0 30])
   
end


%%

for i=1:length(Total_summary_fieldnames)
   
  for j=1:9
         
     
      
      b(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(1,2+(j-1)*10:5+(j-1)*10));
      b2(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(2,2+(j-1)*10:5+(j-1)*10));

      b3(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,2+(j-1)*10:5+(j-1)*10));
      b4(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(4,2+(j-1)*10:5+(j-1)*10));
              b5(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(5,2+(j-1)*10:5+(j-1)*10));
              
              
              
                  Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps=abs(Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(4,:)-Total_summary.(Total_summary_fieldnames{i}).holding_current_all_sweeps(3,:));

              b6(i,j)=mean(Total_summary.(Total_summary_fieldnames{i}).subtracted_baseline_all_sweeps(1+(j-1)*10:5+(j-1)*10));

  end
  

end

% bb=b5-b4;
bb=b;


b1=(bb(:,9)-bb(:,4));
% b1=(bb(:,9)-bb(:,4))./bb(:,4);


% b1=(b(:,9)-b(:,4));

% 
% scatter(ones(length(a),1),a(:,1))
% hold on
% scatter(2*ones(length(a),1),a(:,2))
% scatter(3*ones(length(a),1),a(:,3))