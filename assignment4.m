% Team members: Willis Larson, Conner Babinchak, Sean McHale
% Engineering 0711 MW 4:00-6:00
% Instructor: Dan Budny
% Date: 9/25/17
% Assignment number 4
% This script allows the user to load data, then outputs the data's
% mean, minimum, maximu, median, variance, standard deviation, as
% well as plotting two versions of histograms, one using the hist command,
% the other using the bar command

clear
goAgain='y'; %set up loop in case user wants to run the program again
while(goAgain=='y')

    reptyp=0;

    while(reptyp==0) %this loop makes sure that the file actually exists

        reptyp=1;

        filename=input('Input the name of your file: ','s');

        if(~exist(filename,'file'));

            disp('Please enter a real file name')

            reptyp=0;

        else

            %checks for ragged data

            try

                load(filename)

            catch

                disp('That is not a valid data set, please input a valid data set')

                reptyp=0;

            end

        end

    end

    

    

    data=load(filename);

    len=length(data);

    tot=0;

    

    %initalising min and max variables

    dat_max=data(1);

    dat_min=data(1);

    

    for(i=1:len)

        

        %gets the total

        tot=tot+data(i);

        

        %gets the min

        if(data(i)<dat_min)

            dat_min=data(i);

        end

        

        %gets the max

        if(data(i)>dat_max)

            dat_max=data(i);

        end

            

    end
    

    %gets the mean

    dat_mean=tot/len;

    disp(['mean: ',num2str(dat_mean)])



    %displaying min and max

    disp(['min: ',num2str(dat_min)])

    disp(['max: ',num2str(dat_max)])

    

    %finding the median

    sData=sort(data);

    if(rem(len,2))==0

        %median for if the list is even

        midPoint=len/2;

        midVal=data(midPoint)+data(midPoint-1);

        dat_med=(midVal/2);

    else

        %median if for the list length is odd

        midPoint=ceil(len/2);

        dat_med=sData(midPoint);

    end

    disp(['median: ',num2str(dat_med)])

    

    %loop to find variance

    diff_count=0;

    for(i=1:len)

        diff_count=diff_count+(data(i)-dat_mean)^2;

    end

    

    %finishes calculations and displays variance

    dat_var=diff_count/(len-1);

    disp(['variance: ',num2str(dat_var)])

    

    %determines std and displays it

    dat_std=dat_var^.5;

    disp(['standard deviation: ',num2str(dat_std)])

    

    %Histograms and such in this part

    

    bin_val=0;

    while(bin_val<=0)

        bin_val=input('Input a valid number of bins: ');

    end

    

    %messing around with bar bins

    dat_range=dat_max-dat_min;

    dat_step=dat_range/bin_val;

    bar_bin=zeros(1,bin_val);

    

    for(i=1:len)

        for(j=1:bin_val)

            if(data(i)<((j)*dat_step+dat_min))

                bar_bin(j)=bar_bin(j)+1;

                break

            end

            %checks if data(j)=max value

            if(j==bin_val)

                bar_bin(bin_val)=bar_bin(bin_val)+1;

            end

        end

    end

    

    %gets numerical values for bin names

    bin_names_num=zeros(1,bin_val);

    for(i=0:bin_val-1)

        spef_bin_name=[(i*dat_step+dat_min)];

        bin_names_num(1,i+1)=(i*dat_step+dat_min);

    end

      

    
    %lets user customize the histograms
    xlab=input('What do you want your x axis to be labeled: ','s');

    ylab=input('What do you want your y axis to be labeled: ','s');

    %this is the part that graphs it

    subplot(2,1,1)

    hist(data,bin_val)

    title('Using the HIST command')

    xlabel(xlab);

    ylabel(ylab);

    

    subplot(2,1,2)

    bar(bin_names_num,bar_bin)

    title('Using the bar command')

    xlabel(xlab);

    ylabel(ylab);

    %this is the part that displays your name

    your_name=input('Input your name: ','s');

    gtext(your_name)

    

    %this is the part that asks if you want go again

    goAgain='q';%used to be a value other than y/n

    while ((goAgain~='n' & goAgain~='y')|(isempty((goAgain~='n' & goAgain~='y'))))%checks for user error w/ no input

        goAgain=lower(input('do you want to go again? (y/n): ','s'));

    end

end
