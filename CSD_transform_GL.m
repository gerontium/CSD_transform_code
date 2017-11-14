% CSD transform EEG data - Ger Loughnane 14/11/2017
clear
close all
clc

% set path to the CSD toolbox folder, where the .asc and .csd files are
path_to_CSD_toolbox = 'C:\Program Files\MATLAB\R2015b\toolbox\CSDtoolbox\';

% read the relevant channels for your montage. if it's Monash Brain
% Products, it's chans64_monash.asc
E = textread([path_to_CSD_toolbox,'chans64_monash.asc'],'%s');
% get the channel locations on the scalp.
M = ExtractMontage([path_to_CSD_toolbox,'10-5-System_Mastoids_EGI129.csd'],E);
% map the montage to make sure it's correct
MapMontage(M);
% get the parameters for CSD transformation, G and H.
[G,H] = GetGH(M);

% This is where you actually do the CSD transform then, when you're
% creating your trial-by-trial erp.
% erp is 64 channels x 1000 samples x 100 trials, same for erp_CSD.
% I'm creating a dummy set here.
erp = ones(64,1000,100);
% go through each subject
for s = 1:length(subjects)
    % go through their trials
    for n = 1:size(erp,3)
        % ep is one the epoch of one trial, channels x samples
        ep = squeeze(erp(:,:,n));
        % CSD transform the epoch
        ep_CSD = CSD(ep,G,H);
        % create new CSD transformed erp_CSD, exactly same size as erp
        erp_CSD(:,:,n) = ep_CSD;
    end
end
