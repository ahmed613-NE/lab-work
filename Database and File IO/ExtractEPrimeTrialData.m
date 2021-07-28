function [trial, restperiods] = ExtractEPrimeTrialData(taskfile, tasktype, bvevents, params, savetable)

if (nargin < 5 || isempty(savetable))
    savetable = false;
end

taskonly = false;
if (nargin < 3 || isempty(bvevents))
    taskonly = true;
end

d = ParseEPrimeOutput(taskfile);

if (~taskonly)
    ttl = getTTLTimes(bvevents);
    
    trial = struct('Condition', [], 'Stimulus', [], 'Response', [], 'RT', [], 'ACC', [], ...
        'BlockType', [], 'Repetition', [], 'StimulusTime', [], 'ResponseTime', [], 'FeedbackTime', []);
else
    trial = struct('Condition', [], 'Stimulus', [], 'Response', [], 'RT', [], 'ACC', [], ...
        'BlockType', [], 'Repetition', []);
end

switch tasktype
    case "Simon"
        if (contains(taskfile, 'v2'))
            
            if (~taskonly)
                pidx = find(strcmpi(params(1:2:end), 'stimttlchan'));
                assert(~isempty(pidx), 'Simon v2: Please provide a Stimulus On/Offset TTL Channel: ''stimttlchan''');
                taskmarkers = ttl{params{pidx*2}}; % up = stim onset, down = feedback onset
                
                pidx = find(strcmpi(params(1:2:end), 'respttlchan'));
                assert(~isempty(pidx), 'Simon v2: Please provide a Response TTL Channel: ''respttlchan''');
                bps = ttl{params{pidx*2}}(1:2:end);
                
                pidx = find(strcmpi(params(1:2:end), 'samplerate'));
                assert(~isempty(pidx), 'Simon v2: Please provide a sample rate: ''samplerate''');
                samplerate = params{pidx*2};
                
                resttime = d.Session.RestTime;
            end
            
            numreps = length(d.Session.Block);
            dtrials = [d.Session.Block.Trial];
            trial = repmat(trial, 1, length(dtrials));
            
            if (~taskonly)
                assert(length(taskmarkers)/2 == length(trial), 'Simon v2: TTL and task files don''t match');
            end
            
            badtrials = false(1, length(trial));  
            
            for i = 1:length(trial)
                
                if (dtrials(i).Arrow == dtrials(i).Position)
                    trial(i).Condition = "Congruent";
                else
                    trial(i).Condition = "Incongruent";
                end
                
%                 trial(i).Stimulus = [dtrials(i).Arrow, dtrials(i).Position];
                trial(i).Stimulus = strcat(dtrials(i).Arrow, dtrials(i).Position);
                trial(i).Response = dtrials(i).Stimulus_RESP;
                if (dtrials(i).Running == "ControlList")
                    trial(i).BlockType = "Control";
                else
                    trial(i).BlockType = "Test";
                end
                trial(i).Repetition = find(i <= cumsum(arrayfun(@(x) length(x.Trial), d.Session.Block)), 1);
                trial(i).ACC = dtrials(i).Stimulus_ACC == 1;
                
                if (~taskonly)
                    trial(i).StimulusTime = taskmarkers((i-1)*2+1);
                    trial(i).FeedbackTime = taskmarkers(i*2);
                    if (trial(i).Response)
                        trial(i).ResponseTime = bps(find(bps > trial(i).StimulusTime, 1));
                        trial(i).RT = dtrials(i).Stimulus_RT;
                        %                     if (trial(i).RT < 0)
                        %                         badtrials(i) = true;    % I don't know why this happens, so just cut out this trial...
                        %                     end
                    end
                else
                    if (trial(i).Response)
                        trial(i).RT = dtrials(i).Stimulus_RT;
                    end
                end
                
            end
            
            
            if (~taskonly)
                restperiods = zeros(numreps,2);
                for i = 1:numreps
                    int2 = trial(find([trial.Repetition] == i, 1)).StimulusTime - resttime*samplerate/1000;
                    if (i > 1)
                        int1 = trial(find([trial.Repetition] == i-1, 1, 'last')).StimulusTime;
                    else
                        int1 = 0;
                    end
                    bpints = bps(bps > int1 & bps < int2);
                    if (length(bpints) > 1)
                        [~, idxs] = sort(diff(bpints), 'ascend');
                    else
                        idxs = 1;
                    end
                    restperiods(i,:) = bpints(idxs(end)) + [0, resttime*samplerate/1000];
                end
            else
                restperiods = [];
            end
            
            
        elseif (contains(taskfile, 'v3'))
        else
            error('Simon task version not supported');
        end
    case "Go/No-Go"
        if (contains(taskfile, 'v3'))

            if (~taskonly)
                pidx = find(strcmpi(params(1:2:end), 'resttime'));
                assert(~isempty(pidx), 'Go/No-Go v3: Please provide a rest time in ms: ''resttime''');
                resttime = params{pidx*2};

                pidx = find(strcmpi(params(1:2:end), 'numreps'));
                assert(~isempty(pidx), 'Go/No-Go v3: Please provide a number of repetitions: ''numreps''');
                numreps = params{pidx*2};

                pidx = find(strcmpi(params(1:2:end), 'samplerate'));
                assert(~isempty(pidx), 'Go/No-Go v3: Please provide a sample rate: ''samplerate''');
                samplerate = params{pidx*2};

                pidx = find(strcmpi(params(1:2:end), 'stimttlchan'));
                assert(~isempty(pidx), 'Go/No-Go v3: Please provide a Stimulus Onset TTL Channel: ''stimttlchan''');
                stimon = ttl{params{pidx*2}}(1:2:end);

                pidx = find(strcmpi(params(1:2:end), 'respttlchan'));
                assert(~isempty(pidx), 'Go/No-Go v3: Please provide a Response TTL Channel: ''respttlchan''');
                bps = ttl{params{pidx*2}}(1:2:end);
            end
            
            trial = repmat(trial, 1, length(d.Session.Block));
            assert(length(stimon) == length(trial), 'Go/No-Go v3: TTL and task files don''t match');
            
            badtrials = false(1, length(trial));  
            
            for i = 1:length(trial)
                trial(i).Condition = d.Session.Block(i).Condition;
                trial(i).Stimulus = d.Session.Block(i).Letter;
                trial(i).Response = ~isempty(d.Session.Block(i).StimulusDisplay_RESP);
                trial(i).RT = d.Session.Block(i).StimulusDisplay_RT;
                trial(i).BlockType = strrep(d.Session.Block(i).Procedure, 'TrialProc', '');
                if (i > 1)
                    trial(i).Repetition = sum(diff([false, [trial(1:i).BlockType]==trial(i).BlockType]) == 1);
                else
                    trial(i).Repetition = 1;
                end
                trial(i).ACC = (trial(i).Condition == "GO" && trial(i).Response) || (trial(i).Condition == "NOGO" && ~trial(i).Response);
                
                if (~taskonly)
                    trial(i).StimulusTime = stimon(i);
                    %                 trial(i).FeedbackTime = stimon(i) + feedbacktime*samplerate/1000;
                    if (trial(i).Response)
                        trial(i).FeedbackTime = stimon(i) + trial(i).RT*samplerate/1000; % v3 task displays feedback as soon as the button is pressed
                        trial(i).ResponseTime = bps(find(bps > trial(i).StimulusTime, 1));
                    end
                end
            end
            
            if (~taskonly)
                restperiods = zeros(numreps,2);
                for i = 1:numreps
                    int2 = trial(find([trial.Repetition] == i, 1)).StimulusTime;
                    if (i > 1)
                        int1 = trial(find([trial.Repetition] == i-1, 1)).StimulusTime;
                    else
                        %                     int1 = bps(1);
                        int1 = 0;
                    end
                    bpints = bps(bps > int1 & bps < int2);
                    [~, idxs] = sort(diff(bpints), 'ascend');
                    %                 restperiods(i,:) = [bpints(idxs(end)), bpints(idxs(end)+1)];
                    restperiods(i,:) = bpints(idxs(end)) + [0, resttime*samplerate/1000];
                end
            else
                restperiods = [];
            end
            
        elseif (contains(taskfile, 'v4'))
            
            numreps = length(d.Session.Block);
            restperiods = [];
            dtrials = [d.Session.Block.Trial];
            trial = repmat(trial, 1, length(dtrials));
            
            if (~taskonly)
                pidx = find(strcmpi(params(1:2:end), 'taskttlchan'));
                assert(~isempty(pidx), 'Go/No-Go v4: Please provide a Task Marker TTL Channel: ''taskttlchan''');
                taskmarkers = ttl{params{pidx*2}};
                
                pidx = find(strcmpi(params(1:2:end), 'respttlchan'));
                assert(~isempty(pidx), 'Go/No-Go v4: Please provide a Response TTL Channel: ''respttlchan''');
                bps = ttl{params{pidx*2}}(1:2:end);
                
                pidx = find(strcmpi(params(1:2:end), 'samplerate'));
                assert(~isempty(pidx), 'Go/No-Go v4: Please provide a sample rate: ''samplerate''');
                samplerate = params{pidx*2};
                
                [ttlwidths, idx] = sort(taskmarkers(2:2:end) - taskmarkers(1:2:end));
                assert(all(ttlwidths(1:numreps) < .5*d.Session.StimTime*samplerate/1000), 'Go/No-Go v4: Can''t find rest interval TTL markers');
                restperiods = sort(taskmarkers((idx(1:numreps)-1)*2+1) + [zeros(numreps,1), (d.Session.RestTime*samplerate/1000)*ones(numreps,1)], 1);
                taskmarkers(cell2mat(arrayfun(@(x) (x-1)*2+(1:2), idx(1:numreps)', 'uni', 0))) = [];
                
                assert(length(taskmarkers)/2 == length(trial), 'Go/No-Go v4: TTL and task files don''t match');
            end
            
            badtrials = false(1, length(trial));  
            
            for i = 1:length(trial)
                trial(i).Condition = dtrials(i).Condition;
                trial(i).Stimulus = dtrials(i).Letter;
                trial(i).Response = dtrials(i).RESP == "True";
                if (dtrials(i).Procedure == "TrialProc")
                    trial(i).BlockType = "S";
                else
                    trial(i).BlockType = "GNG";
                end
                trial(i).Repetition = find(i <= cumsum(arrayfun(@(x) length(x.Trial), d.Session.Block)), 1);
                trial(i).ACC = dtrials(i).ACC == "True";
                
                if (~taskonly)
                    trial(i).StimulusTime = taskmarkers((i-1)*2+1);
                    trial(i).FeedbackTime = taskmarkers(i*2);
                    if (trial(i).Response)
                        trial(i).ResponseTime = bps(find(bps > trial(i).StimulusTime, 1));
                        trial(i).RT = dtrials(i).StimulusDisplay_RT - dtrials(i).ISI;
                        if (trial(i).RT < 0)
                            badtrials(i) = true;    % I don't know why this happens, so just cut out this trial...
                        end
                        %                 else
                        %                     trial(i).RT = 0;
                    end
                else
                    if (trial(i).Response)
                        trial(i).RT = dtrials(i).StimulusDisplay_RT - dtrials(i).ISI;
                        if (trial(i).RT < 0)
                            badtrials(i) = true;    % I don't know why this happens, so just cut out this trial...
                        end
                    end
                end
                
            end
            
        else
            error('Go/No-Go task version not supported');
        end
    otherwise
        error('Task type not supported');
end

trial = trial(~badtrials);

if (savetable)
    d = struct2table(trial);
    d.RT(cellfun(@isempty, d.RT)) = {nan};
    d.RT = [d.RT{:}]';
    [fname, fpath] = uiputfile('*.xlsx');
    writetable(d, fullfile(fpath, fname));
end