function [answers, ratio] = countAnswers(data, targetCollumn, condition)

answers = 0;

    for i = 1:length(data)
        if data(i, targetCollumn) == condition
            if data(i,5) == data(i,6)
                answers = answers+1;  
            end
        end
    end
    ratio = answers / length(data);

end

