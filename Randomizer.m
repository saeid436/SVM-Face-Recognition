%% Rnadomize Training Data before traing the system:
 
function [Samples1,Targets1] = Randomizer(BLMSample,BLMTarget)

	[Row1_1,Column1_1] = size(BLMSample);
	[Row2_1,Column2_1] = size(BLMTarget);
	Samples1 = zeros(Row1_1,Column1_1); 
	Targets1 = zeros(Row2_1,Column2_1);

	x = randperm(Column1_1);
	for i = 1:Column1_1
		Randcol = x(i);

		Samples1(:,Randcol) = BLMSample(:,i);
		Targets1(:,Randcol) = BLMTarget(:,i);

	end

end