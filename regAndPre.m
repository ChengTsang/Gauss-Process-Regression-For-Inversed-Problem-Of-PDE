function fStar=regAndPre(x0,y0,yadta,A,Hyp)
    % When there is no parameter, the first part is to provide data for training, and it needs to solve many times PDE.

    % When a parameter has second parameters, it performs the transformation between the matrix and the vector.

    % Two parameters are executed in third parts, and the observation vectors are obtained.
    
    % first part
    if nargin==0
        i=1;
        for x1= 0.1:0.1:1
            for x2= 0.1:0.1:1
                %Using cell array to store data, there are 100 cells to put these matrices, each matrix is 11*11.
                udata_2{i}=fun5_1(x1,x2);
                i=i+1;
            end
        end
        save('udata_2.mat','udata_2');
    end
    
    % second part
    if nargin==1
        % Regression for each component
        %whos -file udata.mat;
        load('udata_2.mat');
        udata_2{1};
        for i=1:1:121
            for j=1:1:100
                if mod(i-1,11)==0
                    ydata{i}(j)=udata_2{j}((floor((i-1)/11)+1),1);
                else
                    %The 100 dimensional vector of each component of the 11*11 dimensional matrix.
                    ydata{i}(j)=udata_2{j}((floor((i-1)/11)+1),mod(i-1,11)+1);
            
                end
            end
        end
        save('ydata.mat','ydata')
      % get hyperparameter
         for i=1:1:121
             %Udata is the data set for each component of training, and each Hyp is a three-dimensional vector.
             Hyp{i}=exp(getHyp(ydata{i}')) ;
         end
         
         
        save('Hyp.mat','Hyp');
      % Get intermediate matrix
      [x1,x2] = meshgrid(linspace(0.1,1,10)); x = [x1(:),x2(:)];
        for k=1:1:121
            for i=1:1:100
                for j=1:1:100
                K{k}(i,j)=(Hyp{k}(2))^2*exp(-0.5*(x(i,:)-x(j,:))*(Hyp{k}(1))^(-2)*(x(i,:)-x(j,:))');
                end
            end
        end
         save('K.mat','K');
       % Get the matrix A\y that needs to be saved.
       for i=1:1:121
           A{i}=(K{i}+(Hyp{i}(3))^2*eye(100))\(ydata{i}');
       end
       save('A.mat','A');
     K{1};
    end
        
    % Predict
    % the third part 
    if nargin==5
        xStar=[x0,y0];
        xStar;
        [x1,x2] = meshgrid(linspace(0.1,1,10)); x = [x1(:),x2(:)];
        for i=1:1:121 
            for j=1:1:100
            k{i}(1,j)=(Hyp{i}(2))^2*exp(-0.5*(xStar-x(j,:))*(Hyp{i}(1))^(-2)*(xStar-x(j,:))');
            end
        end
       for i=1:1:121
            if mod(i-1,11)==0
                 fStar((floor((i-1)/11)+1),1)=k{i}*A{i};
            else
             fStar((floor((i-1)/11)+1),mod(i-1,11)+1)=k{i}*A{i};  
            end
       end 
    end
end
    

    
    
