function [Agent_Positions, Density] = Density_Position_Generator(...
        Number_of_Robots, Density_Type,sides, Partition_Number)
    
    % Binary density or no? I would say yes
    syms x y;
    % Symbolic function in terms of x and y
    
    %% The function is only called when Density_Type is 2
    
    if Density_Type == 1
        Density = rand()*x^(randi(20,1,1))+rand()*y^(randi(21,1,1));
        % Matrix
    elseif Density_Type == 2
        Density = zeros(Partition_Number*sides,Partition_Number*sides);
        x = randi([50,100],1);
        for i = 1:(Partition_Number*sides)
            for j = 1:(Partition_Number*sides)
                % Generate Random matrix of non negative density values
                % Binary Density
                %Density(i,j) = randi([0,1],1);
                Density(i,j) = 0;
                %% CITY LAYOUT (GRID)
                %                  for w = 1:20:sides*Partition_Number
                %                     if all(i>w && i<w+10)
                %                         Density(i,j) = 1;
                %                     end
                %                     if all(j>w && j<w+10)
                %                         Density(i,j) = 1;
                %                     end
                %                  end
                %% DENSER CIRCLES
                                 zap1 = sqrt((i-(36))^2+(j-(72))^2);
                                 portion = randi([0,5],1,1);
                                 if all(zap1 >= 0 && zap1 <= 17)
                                    if portion >= 1
                                         Density(i,j) = 1;
                                    end
                                 end
                                 zap2 = sqrt((i-(72))^2+(j-(18))^2);
                                 portion = randi([0,5],1,1);
                                if all(zap2 >= 0 && zap2 <= 18)
                                    if portion >= 1
                                         Density(i,j) = 1;
                                    end
                                end
                %% FARMLAND ROWS/COLUMNS
                %                 for k = 1:4:sides*Partition_Number
                %                     if all(i>k && i<k+3)
                %                         Density(i,j) = 1;
                %                     end
                %                     if all(j>k && j<k+3)
                %                         Density(i,j) = 1;
                %                     end
                %                 end
                %% CONCENTRIC CIRCLES
                for k = 1:4:sides*Partition_Number
                    zoop = sqrt((i-(0.5*sides*Partition_Number))^2+(j-(0.5*sides*Partition_Number))^2);
                    if all(zoop > k && zoop < k+1)
                        Density(i,j) = 1;
                    end
                end
                %% END OF DISTRBIUTIONS
            end
        end
        Agent_Positions = zeros(Number_of_Robots,2);
        
        for i = 1:Number_of_Robots
            Agent_Positions(i,1) = rand(1,1)*(sides);
            Agent_Positions(i,2) = rand(1,1)*(sides);
        end
    end
    
end

