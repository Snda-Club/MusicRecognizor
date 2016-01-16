% E = logenergy(P, H)
%
% Returns a MxK matrix of log energy filter coefficients
% P is an NxK matrix of K power spectrum frames of length N
% H is an NxM filterbank matrix of M filters for frames of length N
function E = logenergy(P, H)

	if nargin ~= 2
		error('Usage: logenergy(P, H).')
		return
	end

	[MM,M] = size(H); % num filters
	[~,K] = size(P); % num frames
	E = zeros(M,K);

	% Sum the power values in each filter for each frame
	% Integration of power over frequency gives energy
	for k = 1:K
		%E(:,k) = sum(H .* P(:,k))';
        
        tmp=zeros(MM,M);
        
        for v=1:M
            tmp(:,v)=H(:,v).*P(:,k);
        end
        
        E(:,k)=sum(tmp)';
        
	end

	E = log(E);

end
