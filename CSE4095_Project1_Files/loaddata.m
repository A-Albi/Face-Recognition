% This part just graphs the data I saved for K = 10, 20, 30 and loads the
% graphs.

DETECTION10 = {0.6598,0.6853,0.6954,0.6497,0.7005,0.6853,0.7056,0.7005,0.6853,0.6548};
DETECTION20 = {0.7005,0.7107,0.7259,0.7107,0.7462,0.7005,0.7310,0.7310,0.7157,0.6751};
DETECTION30 = {0.7056,0.7107,0.7310,0.7208,0.7513,0.7005,0.7259,0.7310,0.7157,0.6751};

DETECTION10V = cell2mat(DETECTION10);
DETECTION20V = cell2mat(DETECTION20);
DETECTION30V = cell2mat(DETECTION30);

figure('Name', 'K=10');
plot(DETECTION10V);
xlabel('Face Group');
ylabel('Detection Rate');
figure('Name', 'K=20');
plot(DETECTION20V);
xlabel('Face Group');
ylabel('Detection Rate');
figure('Name', 'K=30');
plot(DETECTION30V);
xlabel('Face Group');
ylabel('Detection Rate');
figure('Name', 'K = 10,20,30');
XVAL = 1:10;
plot(XVAL, DETECTION10V, XVAL, DETECTION20V, XVAL, DETECTION30V);
xlabel('Face Group');
ylabel('Detection Rate');
legend('K = 10', 'K = 20', 'K = 30');