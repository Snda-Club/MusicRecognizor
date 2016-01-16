% f = mel2freq(m)
% Converts mels to frequency (Hz)
function f = mel2freq(m)
	[h,w]=size(m);
    
    tmp=exp(m./1127);
	% Formula from Douglas O'Shaughnessy's 1987 book "Speech Communication: human and machine"
	% converted from log_10 to log_e and inverted
	% f = 700 .* (tmp.-1);
	
    f=zeros(h,w);
    
    for(i=1:w)
        f(:,i)=700.*(tmp(:,i)-1);
    
    end
end
