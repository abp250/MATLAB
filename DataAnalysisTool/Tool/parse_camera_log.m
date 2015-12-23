function trackableData = parse_camera_log(filepath)
%loads position, quaternion orientation and euler angles from rigidbody
%trajectories exported to csv in Motive 1.5.1 and returns them in the
%array of structs
%tested for one and three rigid bodies
%license: GPL, author Frieder Wittmann, email frieder.wittmann@gmail.com

openedFile = fopen(filepath,'r');

currentLineNo = 0;

%go through the first lines which dont contain data of interest
for lineIndex = 1:41                                                        % edited by RZ: to match the OptiTrack Tools software used by the Controls Lab at Iowa State University
    readNextLine(openedFile);
    currentLineNo = currentLineNo +1;
end

commaSeperatedValues = csvStringFromOpenedFile(openedFile);
numberOfFrames = str2num(commaSeperatedValues{3})

commaSeperatedValues = csvStringFromOpenedFile(openedFile);
numberOfRidgidBodies = str2num(commaSeperatedValues{3})

%create container of size numberOfRidgidBodies for the output data
RigidBodies = repmat(struct(...
    'Name', 'empty_name', ...                                               % added by RZ: name of the trackable
    'T', NaN(numberOfFrames,1), ...
    'P', NaN(numberOfFrames,3), ...
    'Q', NaN(numberOfFrames,4), ...
    'Euler', NaN(numberOfFrames,3)),numberOfRidgidBodies,1);

%the next lines contain information about the markerpositions on the ridigd bodies. we ignore this infrmation
for i = 1:numberOfRidgidBodies 
    commaSeparatedValues = csvStringFromOpenedFile(openedFile);
    name = commaSeparatedValues{2};
    if(isequal(name(1),'"'))    % taking care of this issue. Occurs sometimes only.
        name(1) = '';
        name(end) = '';
    end
    RigidBodies(i).Name = name;
end


frameIndex = 0; %every nth (numberOfRidgidBodies+1) contains the ridgidbody information of a frame/timestamp
numberOfLinesUntilNextFrameLine = numberOfRidgidBodies+1;

for lineIndex = 1:numberOfFrames*numberOfLinesUntilNextFrameLine 
%there is always a frame line and then one line per rigid body with details which are not of interest to us here  
    
    currentLineContent = readNextLine(openedFile);
    
    %if current line is a line with frame information  
    if( mod(lineIndex,numberOfLinesUntilNextFrameLine) == 1)     
        frameIndex = frameIndex+1; %we're at the next frame
        frameLine = currentLineContent;
        commaSeperatedValues = regexp(frameLine, ',', 'split');

        frameIndexFromFile = str2num(commaSeperatedValues{2});
        timestamp = str2num(commaSeperatedValues{3});
        %check how many ridig bodies were tracked, sometimes so are out of
        %sight and hence not tracked
        numberOFTrackedRidigdBodiesInThisFrame = str2num(commaSeperatedValues{4});
        currentCSVIndex = 4;
        
        if (numberOFTrackedRidigdBodiesInThisFrame > 0)
            currentCSVIndex = currentCSVIndex+1;
            currentRidgidBodyID = str2num(commaSeperatedValues{currentCSVIndex});
            
            for(expectedRidigbBodyID = 1:numberOfRidgidBodies + 1)   
                if (expectedRidigbBodyID ~= currentRidgidBodyID)
                    break %go to next 
                end
                currentCSVIndex = currentCSVIndex+1;
                [p, q, euler ] = readPQEulerStartingAtIndex(currentCSVIndex, commaSeperatedValues);              
                RigidBodies(currentRidgidBodyID).T(frameIndex,:) = timestamp;
                RigidBodies(currentRidgidBodyID).P(frameIndex,:) = p;
                RigidBodies(currentRidgidBodyID).Q(frameIndex,:) = q; 
                RigidBodies(currentRidgidBodyID).Euler(frameIndex,:) = euler;
                currentCSVIndex = currentCSVIndex+10; %the ten values are p(3),q(4)euler(3)=10
                if (currentCSVIndex + 11 < length(commaSeperatedValues))
                    currentRidgidBodyID = str2num(commaSeperatedValues{currentCSVIndex}); %get next ridgid body id
                else
                    break;
                end
            end
        end           
    end
end

% added by RZ: to output the structure in readable format
trackableData.numOfTrackables = length(RigidBodies);
for i=1:trackableData.numOfTrackables
    eval(['trackableData.' RigidBodies(i).Name ' = RigidBodies(i);']);
end

end

function lineContent = readNextLine(openedFile)
    lineContent = fgetl(openedFile);
end

function csvString = csvStringFromOpenedFile(openedFile)
    lineContent = readNextLine(openedFile);
    csvString = regexp(lineContent, ',', 'split');
end

function [p, q, euler] = readPQEulerStartingAtIndex(index, commaSeperatedValues)
                positionX = str2double(commaSeperatedValues{index});
                positionY = str2double(commaSeperatedValues{index+1});
                positionZ = str2double(commaSeperatedValues{index+2});

                p = [positionX, positionY, positionZ];

                QuaternionX = str2double(commaSeperatedValues{index+3});
                QuaternionY = str2double(commaSeperatedValues{index+4});
                QuaternionZ = str2double(commaSeperatedValues{index+5});
                QuaternionW =  str2double(commaSeperatedValues{index+6});

                q = [QuaternionX, QuaternionY, QuaternionZ, QuaternionW];
                
                EulerX = str2double(commaSeperatedValues{index+7});
                EulerY = str2double(commaSeperatedValues{index+8});
                EulerZ = str2double(commaSeperatedValues{index+9});
                
                euler = [EulerX, EulerY, EulerZ];
end