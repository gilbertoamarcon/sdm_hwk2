%findInformation

%Author Geoff Hollinger
%Calculates the information retrieved for a point given Gaussian
%information sources

function info = findInformation(pos,map)

info = 0;
for k = 1:map.numSources
    info = info + exp(-sqrt(sum((pos-map.sources(k,1:2)).^2))/map.sourceStd(k));
end