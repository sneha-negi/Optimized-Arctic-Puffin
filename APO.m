function [BestF,BestX,curve]=APO(N,T,lb,ub,dim,fobj)
%% -------------------Initialization------------------------------------%

PopPos=initialization(N,dim,ub,lb);
PopFit=zeros(N, 1);
for i = 1:N
    PopFit(i) = fobj(PopPos(i, :));
end
[BestF, idx] = min(PopFit);
BestX = PopPos(idx, :);
curve = zeros(T, 1);

%% -------------------Start iteration------------------------------------%
for It = 1:T
    thetha1 = (1 - It/T);
    for i = 1:N
        B = 2 * log(1/rand) * thetha1;

%% -------------------1.Aerial Flight Stage-------------------%
        C = 0.5 * exp(-2 * It / T); %% Change 2
        if B > C
            while true
                K = [1:i-1, i+1:N];
                RandInd = K(randi([1,N-1]));
                step1 = PopPos(i, :) - PopPos(RandInd, :);
                if norm(step1) ~= 0 && ~isequal(PopPos(i, :), PopPos(RandInd, :))
                    break;
                end
            end
            %% -------------------1.1 Aerial search.-------------------%
            
            Y=PopPos(i,:) +  Levy(dim, PopFit, BestF) .* step1 +round(0.5*(0.05+rand))*randn;
            
            %% -------------------1.2 Swooping predation.-------------------%
            
            R=rand(1,dim);
            step2=(R-0.5)*pi;
            S=tan(step2);
            Z=Y.*S;
            Y = SpaceBound(Y, ub, lb);
            Z = SpaceBound(Z, ub, lb);
            NewPop=[Y;Z];
            NewPopfit=[fobj(Y);fobj(Z)];
            [~,sorted_indexes]=sort(NewPopfit);
            newPopPos=NewPop(sorted_indexes(1),:);
        else
%% -------------------2.Underwater Foraging Stage-------------------%
            K = [1:i - 1, i + 1:N];
            RandInd = K(randi([1, N - 1], 1, 3));
            F = 0.5 * thetha1 + 0.1 * rand; % Change 1
            f=(0.1*(rand-1)*(T-It))/T;
            while true
                RandInd = K(randi([1 N-1], 1, 3));
                step1 = PopPos(RandInd(2), :) - PopPos(RandInd(3), :);
                               
                if norm(step1) ~= 0 && RandInd(2) ~= RandInd(3)
                    break;
                end
            end
            %% -------------------2.1	Gathering foraging-------------------%
            if rand<0.5
                W = PopPos(RandInd(1), :) + F .* step1;
            else
                W = PopPos(RandInd(1), :) + F .*Levy(dim, PopFit, BestF).* step1;
            end
            %% -------------------2.2Intensifying search-------------------%
            Y=(1+f)*  W ;
            %% -------------------2.3Underwater Foraging Stage-------------------%
            while true
                rand_leader_index1 = floor(N * rand() + 1);
                rand_leader_index2 = floor(N * rand() + 1);
                X_rand1 = PopPos(rand_leader_index1, :);
                X_rand2 = PopPos(rand_leader_index2, :);
                step2 = X_rand1 - X_rand2;
                if norm(step2) ~= 0 && ~isequal(X_rand1, X_rand2)
                    break;
                end
            end
            Epsilon = unifrnd(0, 1);
            if rand<0.5
                Z = PopPos(i, :) + Epsilon .* step2; % Eq.(11)4.3
            else
                Z = PopPos(i, :) + F .* Levy(dim, PopFit, BestF) .* step2;
            end
            NewPop=[W;Y;Z];
            NewPopfit=[fobj(W);fobj(Y);fobj(Z)];
            [~,sorted_indexes]=sort(NewPopfit);
            newPopPos=NewPop(sorted_indexes(1),:);
        end
        newPopPos = SpaceBound(newPopPos, ub, lb);
        newPopFit = fobj(newPopPos);
        if newPopFit < PopFit(i)
            PopFit(i) = newPopFit;
            PopPos(i, :) = newPopPos;
        end
    end
    for i=1:N
        if PopFit(i)<BestF
            BestF=PopFit(i);
            BestX=PopPos(i,:);
        end
    end
    curve(It)=BestF;
end
end
function o=Levy(Dim, PopFit, BestF) %% Change 3
beta=1.5;
sigma=(gamma(1+beta)*sin(pi*beta/2)/(gamma((1+beta)/2)*beta*2^((beta-1)/2)))^(1/beta);
meanFitness = mean(PopFit);
Scale = 1 + (BestF - meanFitness) / BestF;
Scale = max(0.1, min(5, Scale));
u=randn(1,Dim)*sigma;
v=randn(1,Dim);
step=Scale * u ./ abs(v).^(1/beta);
o=step;
end
     


