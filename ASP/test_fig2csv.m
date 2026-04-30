% Open figure
fig = openfig('HU_mode1.fig');
ax = gca;
hLines = findobj(ax, 'Type', 'line');

% Extract and combine data from all lines
allData = [];
for i = 2:length(hLines)
    x = hLines(i).XData(:);
    y = hLines(i).YData(:);
    length(x)
    length(y)
    allData = [allData, x, y];
end

% Save to CSV
writematrix(allData, 'mode1.csv');
