% find out global percentage of correct answers
% find out percentage of correct answers for each condition

% 1 trial 2 Question number, 3 Condition, 4 Instrument, 5 Correct answer, 6 User answer 
% Answers: 1-4 = conditions correct answers, 5 = total correct answers.


% Independant variable is the proccessing algorithm?
% Data paramtric(normal) except for condition 3(sine waves)
% Friedman test todo
clear all;

total = 72; %total number of questions

files = dir('Experment datalogs/*.txt');

for entry = 1:length(files)

    logs(entry) = importdata(files(entry).name, ",");
    
    %sort the data by instruments on collumn 4. 1 = Bass, 2 = Synth, 3 = Trumpet
    logs(entry).data = sortrows(logs(entry).data,logs(entry).data(6));
    
    %correct answers for each of the 4 condition
    for i = 1:4
        %all correct answers for each condition
        answers(entry,i) = countAnswers(logs(entry).data, 3, i);
        %bass correct answeres for eachcondition
        answers(entry, i + 5) = countAnswers(logs(entry).data(1:23,:), 3, i);
        %synth correct answers for each condition
        answers(entry, i + 10) = countAnswers(logs(entry).data(24:47,:), 3, i);
        %trumpet correct answers for each condition
        answers(entry, i + 15) = countAnswers(logs(entry).data(47:end,:), 3, i);
    end
  
    %total number of correct answers
    answers(entry, 5) = sum(answers(entry, 1:4));
    %total number of correct answers for bass
    answers(entry, 10) = sum(answers(entry, 6:9));
    %total number of correct answers for synth
    answers(entry, 15) = sum(answers(entry, 11:14));
    %total number of correct answers for trumpet
    answers(entry, 20) = sum(answers(entry, 16:19));
    %total percentage of correct answers
    answers(entry, 25) =  answers(entry,5)/total;
    
    for i = 1:4
       answers(entry,i+20) = answers(entry,i)/(total/4);  
    end 
end

%average correct answers / condition
for i = 1:25
    answers(35,i) = mean(answers(1:34,i));
    answers(36,i) = std(answers(1:34,i));
    %normality 
    answers(37,i) = jbtest(answers(1:34,i)); % chi-squared is sensitive to small samples, therefore JB is chosen
    %answers(38,i) = chi2gof(answers(1:34,i));
end

%Friedman test for all instruments
answers(38,5) = friedman(answers(1:34,1:4), 2, 'off');
%Friedman test for bass
answers(38,10) = friedman(answers(1:34,6:9), 2, 'off');
%Friedman test for synth
answers(38,15) = friedman(answers(1:34,11:14), 2, 'off');
%Friedman test for trumpet
answers(38,20) = friedman(answers(1:34,16:19), 2, 'off');



% t = tiledlayout(2,2); 
% title(t, 'Number of correct answers occurances for each condition');
% t.Padding = 'none';
% t.TileSpacing = 'none';
% 
% nexttile
% histogram(answers(1:25,1));
% title('Baseline')
% nexttile
% histogram(answers(1:25,2));
% title('Pitch shift');
% nexttile
% histogram(answers(1:25,3));
% title('Sine waves');
% nexttile
% histogram(answers(1:25,4));
% title('Haptic reinforcement');

figure
layout = tiledlayout(2,2); 
title(layout, 'Number of correct answers occurances for each condition (1-4)');
layout.Padding = 'none';
layout.TileSpacing = 'none';

nexttile
boxplot(answers(1:34,6:9))
title('Bass')
nexttile
boxplot(answers(1:34,11:14))
title('Synthesizer');
nexttile
boxplot(answers(1:34,16:19))
title('Trumpet');
nexttile
boxplot(answers(1:34,1:4))
title('Cumulated');



collumNames =   {'Cond_1', 'Cond_2', 'Cond_3', 'Cond_4', 'Total',...
                'B_Cond_1', 'B_Cond_2', 'B_Cond_3', 'B_Cond_4', 'Bass Total',...
                'Synth_Cond_1', 'Synth_Cond_2', 'Synth_Cond_3', 'Synth_Cond_4', 'Synth Total',...
                'Trum_Cond_1', 'Trum_Cond_2', 'Trum_Cond_3', 'Trum_Cond_4', 'Trump Total'...
                'Cond_1 Ratio', 'Cond_2 Ratio', 'Cond_3 Ratio', 'Cond_4 Ratio', 'Total Ratio'};

