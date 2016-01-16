
  function [lab,coff,model]=addtrain(wavpath,label)  
    [num,~]=size(wavpath);
    
    wavname=wavpath(1,:);
        
    coff=extractfeatures(wavname);
    
    coff=coff'; % x*39 matrix;
    
    [h,w]=size(coff);

    lab=zeros(h,1);
    
    lab(:,1)=label(1,1);
    
    %tmplab=lab;
        
    %tmpcoff=coff;
    
    for i=2:num
    
        wavname=wavpath(i,:);
        
        tmpcoff=extractfeatures(wavname);
    
        tmpcoff=tmpcoff'; % x*39 matrix;
    
        [h,w]=size(tmpcoff);

        tmplab=zeros(h,1);
    
        tmplab(:,1)=label(i,1);
    
        lab=[lab;tmplab];
        
        coff=[coff;tmpcoff];
        
    end
   
%    [coff,~,~]=zscore(coff);
    
    model=svmtrain(lab,coff);
    
end