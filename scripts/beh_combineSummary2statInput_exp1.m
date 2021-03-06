%% zero the world
clear, clc, close all

%% work path setup
work_dir = '/Volumes/Data/Project/motion_analysis/data/';

%% import
target_data = kb_ls([work_dir 'sub*.csv']);
for i=1:numel(target_data)
    disp(target_data{i})
    temp=readtable(target_data{i});
    temp_acc(i,:)=table2array(temp(2,2:end));
    temp_mean(i,:)=table2array(temp(3,2:end));
    temp_median(i,:)=table2array(temp(4,2:end));
end

%% dv gen
temp_eff = temp_acc./temp_mean;

%% summary
summaryData_acc = array2table(temp_acc);
summaryData_mean = array2table(temp_mean);
summaryData_median = array2table(temp_median);
summaryData_eff = array2table(temp_eff);
var_name = temp.Properties.VariableNames;
var_name = var_name(2:end);
summaryData_acc.Properties.VariableNames=var_name;
summaryData_mean.Properties.VariableNames=var_name;
summaryData_median.Properties.VariableNames=var_name;
summaryData_eff.Properties.VariableNames=var_name;

%% output
writetable(summaryData_acc,['data_acc' '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)
writetable(summaryData_mean,['data_rt_mean' '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)
writetable(summaryData_median,['data_rt_median' '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)
writetable(summaryData_eff,['data_rt_eff' '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)

%% prep condition meraged data
merge_acc = combineMotion(temp_acc);
merge_rt_mean = combineMotion(temp_mean);
merge_eff = combineMotion(temp_eff);

%% name condition
summaryData_acc_merage = array2table(merge_acc);
summaryData_acc_merage.Properties.VariableNames={'motion_congruent','motion_incongruent','motion_no','snd_congruent', 'snd_incongruent','snd_no'};
summaryData_mean_merage = array2table(merge_rt_mean);
summaryData_mean_merage.Properties.VariableNames={'motion_congruent','motion_incongruent','motion_no','snd_congruent', 'snd_incongruent','snd_no'};
summaryData_eff_merage = array2table(merge_eff);
summaryData_eff_merage.Properties.VariableNames={'motion_congruent','motion_incongruent','motion_no','snd_congruent', 'snd_incongruent','snd_no'};

%% output
writetable(summaryData_acc_merage,['data_acc_merge' '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)
writetable(summaryData_mean_merage,['data_rt_mean_merge' '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)
writetable(summaryData_eff_merage,['data_eff_merge' '_beh.csv'],'WriteVariableNames', 1,'WriteRowNames',1)