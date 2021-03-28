function features = get_features(data, header_data,leads_idx) %get_ECGLeads_features

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Purpose: Extract features from ECG signals of every lead
% Inputs:
% 1. ECG data from available leads (data)
% 2. Header files including the number of leads (header_data)
% 3. The available leads index (in data/header file)
%
% Outputs:
% features for every ECG lead:
% 1. Age 2. Sex 3. root square mean (RSM) of the ECG leads
%
% Author: Nadi Sadr, PhD, <nadi.sadr@dbmi.emory.edu>
% Version 1.0
% Date 25-Nov-2020
% Version 2.1, 25-Jan-2021
% Version 2.2, 11-Feb-2021
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% read number of leads, sample frequency and adc_gain from the header.
[recording,Total_time,num_leads,Fs,adc_gain,age,sex,Baseline] = extract_data_from_header(header_data);
num_leads = length(leads_idx);
jj=1;
try
    % ECG processing
    % Preprocessing
    for i = [leads_idx{:}]
        
        % Apply adc_gain and remove baseline
        LeadswGain(i,:)   = (data(i,:) - Baseline(i))./adc_gain(i);
        
        % Extract root square mean (RSM) feature
        RSM(i) = sqrt(sum(LeadswGain(i,:).^2))./length(LeadswGain(i,:));       
        features(jj) = RSM(i);
        jj = jj+1;
    end
    
catch
    features_length = num_leads;
    features = nan(1,features_length);
end

% The last two features are age and sex from header file
features(num_leads+1) = age;
features(num_leads+2) = sex;
end
