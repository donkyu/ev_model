function [sample] = data_reduction(data,Time_converted)
    num=1;
    time=0;
    sample = ones(100,1);
    Size_of_time = size(Time_converted);
    max_time = floor(Time_converted(Size_of_time(1,1),1));
    while(Time_converted(num,1)< max_time-2)
        vel_count = 0;
        v_num = 0;
        watch_dog=Time_converted(num,1);
        before=0;
        while (Time_converted(num,1)-watch_dog <0.5)
           if (before > Time_converted(num,1))
               break
           end
           before = Time_converted(num,1);
           vel_count = vel_count+data(num,1);
           num = num+1;
           v_num = v_num+1;
        end
        time = time+1;
        sample(time,1) = vel_count/v_num;
    end
end