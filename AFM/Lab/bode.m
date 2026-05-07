fig1 = openfig('resonance_f.fig','invisible');
fig2 = openfig('closed_loop_9.fig','invisible');

ax1 = findall(fig1, 'type', 'axes');
ax2 = findall(fig2, 'type', 'axes');

newFig = figure;


mag1 = ax1(2);
mag2 = ax2(2);
phase1 = ax1(1);
phase2 = ax2(1);

newAx(1) = subplot(2,1,1);
newAx(2) = subplot(2,1,2);
% Find line/patch objects in the source axes and set the second one's color
hMagLines = findall(mag1, {'Type','line'}); % lines in mag1
if numel(hMagLines) < 2
    hMagLines = findall(mag1, '-regexp', 'Type', '^(line|stem|errorbar)$');
end
if numel(hMagLines) >= 2
    set(hMagLines(1), 'Color', get(hMagLines(1),'Color')); % keep first
    set(hMagLines(2), 'Color', [0 0.4470 0.7410]); % change second (blue)
end

hMagLines2 = findall(mag2, {'Type','line'});
if numel(hMagLines2) >= 1
    % ensure the second plotted object (if present) in combined target will use different color:
    set(hMagLines2(1), 'Color', [0.8500 0.3250 0.0980]); % orange for second source
end

% For phase axes
hPhaseLines = findall(phase1, {'Type','line'});
if numel(hPhaseLines) < 2
    hPhaseLines = findall(phase1, '-regexp', 'Type', '^(line|stem|errorbar)$');
end
if numel(hPhaseLines) >= 2
    set(hPhaseLines(2), 'Color', [0 0.4470 0.7410]); % change second
end

hPhaseLines2 = findall(phase2, {'Type','line'});
if ~isempty(hPhaseLines2)
    set(hPhaseLines2(1), 'Color', [0.8500 0.3250 0.0980]); % ensure distinct color
end
copyobj(allchild(mag1), newAx(1));
hold(newAx(1), 'on')
copyobj(allchild(mag2), newAx(1));

% Set titles and labels for the subplots
title(newAx(1), 'Magnitude');
xlabel(newAx(1), 'Frequency (Hz)');
ylabel(newAx(1), 'Magnitude (dB)');

copyobj(allchild(phase1), newAx(2));
hold(newAx(2), 'on');
copyobj(allchild(phase2), newAx(2));

% Set titles and labels for the second subplot
title(newAx(2), 'Phase');
xlabel(newAx(2), 'Frequency (Hz)');
ylabel(newAx(2), 'Phase (degrees)');

% logarithmic scaling
set(newAx(1), 'XScale', 'log');
set(newAx(2), 'XScale', 'log');


% grid
grid(newAx(1), 'on'); % Enable grid for magnitude plot
grid(newAx(2), 'on'); % Enable grid for phase plot

% legend
legend(newAx(1), {'Open-loop', 'Closed-loop'}, 'Location', 'southwest');
legend(newAx(2), {'Open-loop', 'Closed-loop'}, 'Location', 'southwest');

% Set x-axis limits to 10-100 for both subplots
xlim(newAx(1), [10 100]);
xlim(newAx(2), [10 100]);

