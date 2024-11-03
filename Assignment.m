clc;
clear;
close all;

% Selection of houses based on 3 criteria: area, price, street
% price had data transformation (Pmax - Pn)
% Street has data trasformation, closer to desire location get highest value

%% Processing training Data

% read full data
DATA = readtable('Oto_Dom.xlsx');

% extract only sample data
isNotNan = ~ismissing(DATA(:,8));
SAMPLE_DATA = DATA(isNotNan,:);

% Prepare parameters A, B, D
B1 = SAMPLE_DATA(:, 8);
A1 = SAMPLE_DATA(:, 4:6);
A = table2array(A1);
B = table2array(B1);
B = cellfun(@str2num, B);
D = 3;
 
%% Initiliaze data and matrices
 
[m,n]=size(A);
br=nan(D+1,n); % Table with breakpoints
R=(max(A)-min(A))./D; % table with steps
X=zeros(n,D,m); %table with variables' coefficients in a 3d matrix
X_2d=nan(m,n*D); %table with variables' coefficients in a 2d matrix
S=zeros(m,2*m); %table with errors (m,2*m)
Evaluation_table=nan(m-1,n*D+2*m+1); %(m-1,n*max(D)+2*m+1) -> Table with coefficients and rank differences
 
%% Calculation of tables
 
% Table with breakpoints
for i=1:D+1
    br(i,:)=min(A)+(i-1)*R;
end
 
%table with variables' coefficients in a 3d matrix
for i=1:m %for all alternatives
    for j=1:n %for all criteria
        for k=1:D %for all intervals
            if (A(i,j)<=br(k+1,j))
                X(j,:,i)=[ones(1,k-1) 1-(br(k+1,j)-A(i,j))/R(j) zeros(1,D-k)];
                break;
            end
        end
    end
end
 
% transformation of X in a 2d matrix
for k=1:m
    X_2d(k,:)=reshape(X(:,:,k)',1,n*D);
end
 
%table with errors
for i=1:m
    S(i,:)=[repmat([0 0],1,i-1) repmat([1 -1],1,1) repmat([0 0],1,m-i)];
end
 
% sort by last column of choice (first 0 then 1)
sorted_evaluation_table=sortrows([X_2d S B],n*D+2*m+1, 'ascend'); 
 
% % Calculate the number of housings recommended
k=sum(sorted_evaluation_table(:,n*D+2*m+1)==0);
 
LP_table=[sorted_evaluation_table(:,1:n*D+2*m) ones(m,1)*(-1); ones(1,n*D) zeros(1,2*m+1)];
 
%% Model and solve the LP
 
model_lab08.obj = [zeros(1,n*D) ones(1,2*m) 0];
model_lab08.modelsense = 'min';
model_lab08.A = sparse(LP_table);
model_lab08.rhs = [0.001*ones(k,1); 0.001*ones(m-k,1); 1];
model_lab08.sense = [repmat('<',1,k) repmat('>',1,m-k) '='];
gurobi_write(model_lab08, 'lab08.lp');
params.outputflag = 0;
result = gurobi(model_lab08, params);
 
% Optional commands that reshapes the solution in a n x number_of_intervals matrix
Solution=reshape(result.x(1:n*D,1),[D,n])';
% Command to calculate the overall utility of all alternatives
overall_utilities=X_2d*result.x(1:n*D);
 
% definde threshold
u0 = result.x(end)

%% Processing Testing Data
% extracting data with no decision
isNan = ismissing(DATA(:,8));
NaN_DATA = DATA(isNan,:);
A2 = NaN_DATA(:, 4:6);
A_1 = table2array(A2);
D_1 = 3;

% Initiliaze data and matrices
[m,n]=size(A_1);
br=nan(D_1+1,n); % Table with breakpoints
R=(max(A_1)-min(A_1))./D_1; % table with steps
X=zeros(n,D_1,m); %table with variables' coefficients in a 3d matrix
X_2d=nan(m,n*D_1); %table with variables' coefficients in a 2d matrix
Evaluation_table=nan(m-1,n*D_1+2*m+1); %(m-1,n*max(D)+2*m+1) -> Table with coefficients and rank differences

%% Calculation of tables 

% Table with breakpoints
for i=1:D_1+1
    br(i,:)=min(A_1)+(i-1)*R;
end

%table with variables' coefficients in a 3d matrix
for i=1:m %for all alternatives
    for j=1:n %for all criteria
        for k=1:D_1 %for all intervals
            if (A_1(i,j)<=br(k+1,j))
                X(j,:,i)=[ones(1,k-1) 1-(br(k+1,j)-A_1(i,j))/R(j) zeros(1,D_1-k)];
                break;
            end
        end
    end
end

% transformation of X in a 2d matrix
for k=1:m
    X_2d(k,:)=reshape(X(:,:,k)',1,n*D_1);
end

overall_utilities=X_2d*result.x(1:n*D_1);
accepted = sum(overall_utilities>u0) % = 1
rejected = sum(overall_utilities<u0) % = 0

% table1 is a table with all parameteres and overall utilities
table1 = [A_1 overall_utilities];

% we check which house is 0 and which 1
result_01 = zeros(size(overall_utilities));

% Populate result_final_2
for i = 1:length(overall_utilities)
    if overall_utilities(i) > u0
        result_01(i) = 1;
    else
        result_01(i) = 0;
    end
end

results_final = [table1 result_01];
% Define column names
columnNames = {'area', 'price', 'district', 'overall_utility', 'decision'};

% Convert the concatenated array into a table
results_final = array2table(results_final, 'VariableNames', columnNames);

