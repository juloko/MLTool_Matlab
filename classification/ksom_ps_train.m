function [PARout] = ksom_ps_train(DATA,PAR)

% --- KSOM-PS Training Function ---
%
%   [PARout] = ksom_ps_train(DATA,PAR)
% 
%   Input:
%       DATA.
%           input = input matrix [p x N]
%       PAR.
%           ep = max number of epochs [cte]
%           k = number of prototypes (neurons) [l x c]
%           init = type of initialization for prototypes [cte]
%               1: C = zeros
%               2: C = randomly picked from data
%               3: C = mean of randomly choosen data
%           dist = type of distance [cte]
%               0: dot product
%               2: euclidean distance
%           learn = type of learning step [cte]
%               1: N = No (constant)
%               2: N = No*(1-(t/tmax))
%               3: N = No/(1+t)
%               4: N = No*((Nt/No)^(t/tmax))
%           No = initial learning step [cte]
%           Nt = final learning step [cte]
%           Nn = number of neighbors [cte]
%           neig = type of neighborhood function [cte]
%               1: if winner, h = 1, else h = 0.
%               2: if neighbor, h = exp (-(||ri - ri*||^2)/(V^2))
%                    where: V = Vo*((Vt/Vo)^(t/tmax))
%               3: decreasing function 1
%           Vo = initial neighborhood parameter [cte]
%           Vt = final neighborhood parameter [cte]
%           M = samples used to estimate kernel matrix
%           Kt = Type of Kernel
%           sig2 = Variance (gaussian, log, cauchy kernel)
%           lbl = type of neurons labeling [cte]
%           s = prototype selection type
%   Output:
%       PARout.
%       	C = clusters centroids (prototypes) [pxk]
%           index = cluster index for each sample [1xN]
%           SSE = Sum of Squared Errors for each epoch [1 x ep]
%           label = class of each neuron [Nlin x Ncol]

%% SET DEFAULT HYPERPARAMETERS

if ((nargin == 1) || (isempty(PAR))),
    PARaux.ep = 200;    	% max number of epochs
    PARaux.k = [5 4];      	% number of neurons (prototypes)
    PARaux.init = 02;     	% neurons' initialization
    PARaux.dist = 02;      	% type of distance
    PARaux.learn = 02;     	% type of learning step
    PARaux.No = 0.7;       	% initial learning step
    PARaux.Nt = 0.01;      	% final learnin step
    PARaux.Nn = 01;      	% number of neighbors
    PARaux.neig = 03;      	% type of neighborhood function
    PARaux.Vo = 0.8;      	% initial neighborhood constant
    PARaux.Vt = 0.3;      	% final neighborhood constant
    PARaux.Kt = 1;       	% Type of Kernel (gaussian)
    PARaux.sig2 = 2;        % Variance (gaussian, log, cauchy kernel)
    PARaux.lbl = 1;         % Neurons' labeling function
    PARaux.Von = 0;         % enable or disable video display
    PARaux.s = 1;           % prototype selection type
    PARaux.M = 50;          % samples used to estimate kernel matrix
    PARaux.v = 0.01;        % accuracy parameter (level of sparsity)
    PAR = PARaux;

else
    if (~(isfield(PAR,'ep'))),
        PAR.ep = 200;
    end
    if (~(isfield(PAR,'k'))),
        PAR.k = [5 4];
    end
    if (~(isfield(PAR,'init'))),
        PAR.init = 2;
    end
    if (~(isfield(PAR,'dist'))),
        PAR.dist = 2;
    end
    if (~(isfield(PAR,'learn'))),
        PAR.learn = 2;
    end
    if (~(isfield(PAR,'No'))),
        PAR.No = 0.7;
    end
    if (~(isfield(PAR,'Nt'))),
        PAR.Nt = 0.01;
    end
    if (~(isfield(PAR,'Nn'))),
        PAR.Nn = 1;
    end
    if (~(isfield(PAR,'neig'))),
        PAR.neig = 3;
    end
    if (~(isfield(PAR,'Vo'))),
        PAR.Vo = 0.8;
    end
    if (~(isfield(PAR,'Vt'))),
        PAR.Vt = 0.3;
    end
    if (~(isfield(PAR,'Kt'))),
        PAR.Kt = 1;
    end
    if (~(isfield(PAR,'sig2'))),
        PAR.sig2 = 2;
    end
    if (~(isfield(PAR,'lbl'))),
        PAR.lbl = 1;
    end
    if (~(isfield(PAR,'Von'))),
        PAR.Von = 0;
    end
    if (~(isfield(PAR,'s'))),
        PAR.s = 1;
    end
    if (~(isfield(PAR,'M'))),
        PAR.M = 50;
    end
    if (~(isfield(PAR,'v'))),
        PAR.v = 0.01;
    end
end

%% ALGORITHM

OUT_CL = ksom_ps_cluster(DATA,PAR);
PARout = ksom_ps_label(DATA,OUT_CL);

%% THEORY

% ToDo - All

%% END