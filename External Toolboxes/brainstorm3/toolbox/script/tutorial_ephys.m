function tutorial_ephys(tutorial_dir)
% TUTORIAL_EPHYS: Script that reproduces the online tutorials "Brainstorm's Suite for Multi-unit Electrophysiology"
%
% REFERENCE:
%     - https://neuroimage.usc.edu/brainstorm/e-phys/Introduction
%     - https://neuroimage.usc.edu/brainstorm/e-phys/SpikeSorting
%     - https://neuroimage.usc.edu/brainstorm/e-phys/RawToLFP
%     - https://neuroimage.usc.edu/brainstorm/e-phys/functions
%
% INPUTS: 
%     tutorial_dir: Directory where the sample_ephys.zip file has been unzipped

% @=============================================================================
% This function is part of the Brainstorm software:
% https://neuroimage.usc.edu/brainstorm
% 
% Copyright (c) University of Southern California & McGill University
% This software is distributed under the terms of the GNU General Public License
% as published by the Free Software Foundation. Further details on the GPLv3
% license can be found at http://www.gnu.org/copyleft/gpl.html.
% 
% FOR RESEARCH PURPOSES ONLY. THE SOFTWARE IS PROVIDED "AS IS," AND THE
% UNIVERSITY OF SOUTHERN CALIFORNIA AND ITS COLLABORATORS DO NOT MAKE ANY
% WARRANTY, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO WARRANTIES OF
% MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE, NOR DO THEY ASSUME ANY
% LIABILITY OR RESPONSIBILITY FOR THE USE OF THIS SOFTWARE.
%
% For more information type "brainstorm license" at command prompt.
% =============================================================================@
%
% Author: Francois Tadel, 2022


%% ===== FILES TO IMPORT =====
% You have to specify the folder in which the tutorial dataset is unzipped
if (nargin == 0) || isempty(tutorial_dir) || ~file_exist(tutorial_dir)
    error('The first argument must be the full path to the tutorial dataset folder.');
end
% Build the path of the files to import
T1Nii      = fullfile(tutorial_dir, 'sample_ephys', 'floyd_t1.nii');
CortexMesh = fullfile(tutorial_dir, 'sample_ephys', 'floyd_cortex.mesh');
PlxFile    = fullfile(tutorial_dir, 'sample_ephys', 'ytu288c-01.plx');
PosFile    = fullfile(tutorial_dir, 'sample_ephys', 'ytu288c-01_electrodes.txt');
EvtFile    = fullfile(tutorial_dir, 'sample_ephys', 'ytu288c-01_events.csv');
% Check if the folder contains the required files
if ~file_exist(T1Nii) || ~file_exist(PlxFile)
    error(['The folder ' tutorial_dir ' does not contain the folder from the file sample_ephys.zip.']);
end
% Subject name
SubjectName = 'Floyd';


%% ===== CREATE PROTOCOL =====
% Start brainstorm without the GUI
if ~brainstorm('status')
    brainstorm nogui
end
% Protocol name
ProtocolName = 'Tutorial_e-Phys';
% Delete existing protocol
gui_brainstorm('DeleteProtocol', ProtocolName);
% Create new protocol
gui_brainstorm('CreateProtocol', ProtocolName, 0, 0);
% Start a new report
bst_report('Start');


%% ===== IMPORT ANATOMY =====
% Process: Import MRI
bst_process('CallProcess', 'process_import_mri', [], [], ...
    'subjectname', SubjectName, ...
    'mrifile',     {T1Nii, 'ALL'});
% Process: MNI normalization
bst_process('CallProcess', 'process_mni_normalize', [], [], ...
    'subjectname', SubjectName, ...
    'method',      'maff8');
% Process: Generate head surface
bst_process('CallProcess', 'process_generate_head', [], [], ...
    'subjectname', SubjectName, ...
    'nvertices',   10000, ...
    'erodefactor', 0, ...
    'fillfactor',  2);
% Import cortex surface
iSubject = 1;
[iSurf, CortexFile] = import_surfaces(iSubject, CortexMesh, 'MESH', 0);


%% ===== ACCESS THE RECORDINGS =====
% Process: Create link to raw file
sFilesRaw = bst_process('CallProcess', 'process_import_data_raw', [], [], ...
    'subjectname',    SubjectName, ...
    'datafile',       {PlxFile, 'EEG-PLEXON'});
% Process: Import from file
bst_process('CallProcess', 'process_evt_import', sFilesRaw, [], ...
    'evtfile', {EvtFile, 'CSV-TIME'}, ...
    'delete',  0);
% Process: Add EEG positions
bst_process('CallProcess', 'process_channel_addloc', sFilesRaw, [], ...
    'channelfile', {PosFile, 'ASCII_NXYZ_WORLD'}, ...
    'fixunits',    0, ...
    'vox2ras',     1);
% Process: Set channels type
bst_process('CallProcess', 'process_channel_settype', sFilesRaw, [], ...
    'sensortypes', '', ...
    'newtype',     'SEEG');

% Display anatomy and sensors
hFig = view_channels_3d(sFilesRaw.ChannelFile, 'SEEG', 'scalp', 1);
hFig = view_surface(CortexFile{1}, 0.8, [1 0 0], hFig);
figure_3d('SetStandardView', hFig, 'right');
bst_report('Snapshot', hFig, [], 'Anatomy');
close(hFig);


%% ===== SPIKE SORTING =====
% Not executed here, in order to keep the original spiking events from the PLX file

% % Process: WaveClus
% sFilesWavclus = bst_process('CallProcess', 'process_spikesorting_waveclus', sFilesRaw, [], ...
%     'spikesorter', 'waveclus', ...
%     'binsize',     8, ...
%     'parallel',    0, ...
%     'usessp',      1, ...
%     'make_plots',  0, ...
%     'edit',        0);

% % Process: UltraMegaSort2000
% sFilesUMS = bst_process('CallProcess', 'process_spikesorting_ultramegasort2000', sFilesRaw, [], ...
%     'spikesorter', 'ultramegasort2000', ...
%     'binsize',     40, ...
%     'parallel',    0, ...
%     'usessp',      1, ...
%     'highpass',    700, ...
%     'lowpass',     4800, ...
%     'edit',        4800);

% % Process: KiloSort
% sFilesKilo = bst_process('CallProcess', 'process_spikesorting_kilosort', sFilesRaw, [], ...
%     'spikesorter', 'kilosort', ...
%     'binsize',     40, ...
%     'GPU',         0, ...
%     'usessp',      1, ...
%     'edit',        1);


%% ===== CONVERT TO LFP =====
% Process: Convert Raw to LFP
sFilesLfp = bst_process('CallProcess', 'process_convert_raw_to_lfp', sFilesRaw, [], ...
    'binsize',      40, ...
    'usessp',       1, ...
    'LFP_fs',       1000, ...
    'freqlist',     [], ...
    'filterbounds', [0.5, 150], ...
    'despikeLFP',   0, ...
    'parallel',     0);
% Process: Import MEG/EEG: Events
sFilesLfpEpochs = bst_process('CallProcess', 'process_import_data_event', sFilesLfp, [], ...
    'subjectname',   SubjectName, ...
    'condition',     '', ...
    'eventname',     'Stim On 1, Stim On 2, Stim On 3, Stim On 4, Stim On 5, Stim On 6, Stim On 7, Stim On 8, Stim On 9', ...
    'timewindow',    [], ...
    'epochtime',     [-0.5, 1], ...
    'split',         0, ...
    'createcond',    0, ...
    'ignoreshort',   1, ...
    'usectfcomp',    1, ...
    'usessp',        1, ...
    'freq',          500, ...
    'baseline',      'all', ...
    'blsensortypes', 'SEEG');


%% ===== TUNING CURVES =====
% Process: Tuning curves
bst_process('CallProcess', 'process_tuning_curves', sFilesLfp, [], ...
    'eventsel',   {'Stim On 1', 'Stim On 2', 'Stim On 3', 'Stim On 4', 'Stim On 5', 'Stim On 6', 'Stim On 7', 'Stim On 8', 'Stim On 9'}, ...
    'spikesel',   {'Spikes Channel AD06', 'Spikes Channel AD08 |1|'}, ...
    'timewindow', [0.05, 0.12]);


%% ===== NOISE CORRELATION =====
% Process: Noise correlation
sFilesNoiseCorr = bst_process('CallProcess', 'process_noise_correlation', sFilesLfpEpochs, [], ...
    'timewindow', [0, 0.3]);
% Process: Snapshot: Time-frequency maps
bst_process('CallProcess', 'process_snapshot', sFilesNoiseCorr, [], ...
    'type',     'timefreq', ...  % Time-frequency maps
    'modality', 6, ...  % SEEG
    'Comment',  'Noise correlation');


%% ===== SPIKE FIELD COHERENCE =====
% Process: Select data files in: Floyd/*/Stim On 1
sFilesStim1 = bst_process('CallProcess', 'process_select_files_data', [], [], ...
    'subjectname',   SubjectName, ...
    'condition',     '', ...
    'tag',           'Stim On 1', ...
    'includebad',    0, ...
    'includeintra',  0, ...
    'includecommon', 0);
% Process: Spike field coherence
sFilesSFC = bst_process('CallProcess', 'process_spike_field_coherence', sFilesStim1, [], ...
    'timewindow',  [-0.15, 0.15], ...
    'sensortypes', 'EEG, SEEG', ...
    'parallel',    0);
% Process: Snapshot: Time-frequency maps
hFig = view_timefreq(sFilesSFC.FileName, 'SingleSensor', 'Spikes Channel AD03');
bst_report('Snapshot', hFig, [], 'Spike field coherence');
close(hFig);


%% ===== RASTER PLOT =====
% Process: Raster plot per neuron
sFilesRaster = bst_process('CallProcess', 'process_rasterplot_per_neuron', sFilesStim1, []);
% Process: Snapshot: Time-frequency maps
hFig = view_timefreq(sFilesRaster.FileName, 'SingleSensor', 'Spikes Channel AD01 |1|');
panel_time('SetCurrentTime',  0.158);
bst_report('Snapshot', hFig, [], 'Raster plot per neuron');
close(hFig);


%% ===== SPIKE TRIGGERED AVERAGE =====
% Process: Spike triggered average
sFilesAvg = bst_process('CallProcess', 'process_spike_triggered_average', sFilesStim1, [], ...
    'timewindow', [-0.15, 0.15], ...
    'parallel',   0);

% Process: Select data files in: Floyd/*/Stim On 1 (AD01 #1)
sFilesAvgAD01 = bst_process('CallProcess', 'process_select_files_data', [], [], ...
    'subjectname',   SubjectName, ...
    'condition',     '', ...
    'tag',           'Stim On 1 (AD01 #1)', ...
    'includebad',    0, ...
    'includeintra',  0, ...
    'includecommon', 0);
% Process: Snapshot: Recordings time series
bst_process('CallProcess', 'process_snapshot', sFilesAvgAD01, [], ...
    'type',     'data', ...  % Recordings time series
    'modality', 6, ...  % SEEG
    'Comment',  'Spike triggered average: AD01 #1');
% View 2DLayout
hFig = view_topography(sFilesAvgAD01.FileName, 'SEEG', '2DLayout');
bst_report('Snapshot', hFig, [], 'Spike triggered average: AD01 #1');
close(hFig);

% Save and display report
ReportFile = bst_report('Save', []);
bst_report('Open', ReportFile);



