%% Face Recognition With Support Vector Machine(SVM)
% Saeid-Moradi -> saeid.moradi436@gmail.com

%% Read Images from Dataset And extract Blockmean features

N = 400; % Number Of Images*
m = 40; % Number Of Classes*
W = 128; % With Of Window
H = 128; % Length Of Window
WinSize = 8; % Steps For Avaraging

Samples = zeros(((H/WinSize)*(W/WinSize))+1,N);
Targets = zeros(m,N);

n = 1;
for a = 1 : 40
    for b = 1 : 10
        Adress = ['ORL\s',num2str(a),'\',num2str(b),'.pgm'];
        if(exist(Adress,'file')) ~= 0
            I = imread(Adress);
            
            % Block Means Features
            FeatureVec1 = BlockMean(I,H,W,WinSize);            

            Samples(:,n) = FeatureVec1; % Matrix Of Features* 
            Targets(a,n) = 1; % Targets of features

            n = n+1;
        end
    end
end

[Samples1,Targets1] = Randomizer(Samples,Targets); % Randomize Samples And Targets
 
TrainCont = round(.7*N);
TestCont = N - TrainCont;
TrainSamples = Samples1(:,1:TrainCont);
TrainTargets = vec2ind(Targets1(:,1:TrainCont))';
 
for r = 1:m
TrainTargets1(:,r) = TrainTargets;
TrainTargets1(:,r) = (TrainTargets(:) == r);
end
 
 
TestSamples = Samples1(:, TrainCont+1 : end)';
TestTargets = Targets1(:, TrainCont+1 : end);
 
%% Step 2 : SVM training & Classifying
 
for r = 1:m
    
SVMStruct(r) = svmtrain(TrainSamples, TrainTargets1(:,r));
Class(:,r) = svmclassify(SVMStruct(r), TestSamples);

end
 
TestOutPut = Class';
TestTargetsIndex = vec2ind(TestTargets);

%% Step 3 : Test the trained system:
 Success=0;
 for i = 1:TestCont
     if( TestOutPut(TestTargetsIndex(i),i) == 1 & TestOutPut(1:TestTargetsIndex(i)-1,i) == 0  )
         if (TestTargetsIndex(i) < m)
             if ( TestOutPut(TestTargetsIndex(i)+1:m,i) == 0)
                 Success = Success + 1;
             end
         else
             Success = Success + 1;
         end
     end
     
 end
 
 
 Accuracy = 100*Success / TestCont