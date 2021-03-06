%Function For CSE 150 Hw#2
%Import txt file for zipcodes
%Random Variables:
%   - Z = {0,1,...,99999}
%   - Di = {0,1,...,9}
%   - E: evidence at some intermediate round of game
%Script to analyze zip code data
%Inputs:
%   -zip: pass in the parsed vector of all the numbers of the zipcode
%   -currentZip: pass in a vector of all the correct guesses so far
%   -wrongDigits: pass in vector of all wrong Digits that is not contained
%   in zip


function probD = analyzeZip (zip, correctDigits, wrongDigits)    
    %the probability of P(E|Z=z)
    probC = 1;  %Correct digit
    probW = 1;  %Wrong digit
     
    tempvar = correctDigits > -1;
    tempvar = correctDigits(tempvar);
    
    %Loop through each wrong guess so far
    if(isempty(wrongDigits))
        %if it's empty, do nothing
    else
        for i=1:length(wrongDigits)
            %Check if that wrong digit is in the current Z zipcode
            %if so, impossible to be this current zip(i) -> break
            if ismember(wrongDigits(i), zip)
                probW = 0;
                break;
            end
        end
    end%We have now obttained P(E|Z=z)    
    
    check = isempty(correctDigits);
    
    if(probW == 1 && ~check)
        %loop through each corrected guess so far        
        for i=1:5
            %the currentZip contains either:
                %1. -1, not guessed yet
                %2. #, in the current zip(i)
                %3. #, not in current zip(i) -> break, not possible
            %means that no currect guess on this index yet
            if(correctDigits(i) == -1)
                if(ismember(zip(i), tempvar))
                    probC = 0;
                    break;
                else
                    probC = 1;
                end
                %no correct guess yet
            elseif(correctDigits(i) == zip(i))
                probC = 1;
                %current number in zip code is correct for zip(i)
            else
                probC = 0; %one incorrect number
                break;
            end
        end
    else
        probD = 0;
    end
    probD = probC && probW;
end